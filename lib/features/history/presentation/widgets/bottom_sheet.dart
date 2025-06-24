import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legy/core/extension/text_style_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/history/model/report_model.dart';
import 'package:legy/features/history/presentation/app/history_cubit.dart';
import 'package:legy/features/history/presentation/app/history_state.dart';
import 'package:legy/features/history/presentation/widgets/grid_order_item_widget.dart';

class ReportBottomSheet extends StatefulWidget {
  final String orderId;

  const ReportBottomSheet({super.key, required this.orderId});

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  IssueType? _selectedIssue;
  File? _imageFile;

  final picker = ImagePicker();

  final Map<IssueType, String> _issueTypeLabels = {
    IssueType.MISSING_PRODUCT: 'Missing Product',
    IssueType.WRONG_ORDER: 'Wrong Order',
    IssueType.LATE_DELIVERY: 'Late Delivery',
    IssueType.DRIVER: 'Driver Issue',
    IssueType.APPLICATION: 'Application Issue',
    IssueType.ORDER: 'Order Issue',
  };

  Future<void> _pickImage() async {
    final picked =
        await picker.pickImage(source: ImageSource.camera); // or .gallery
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryCubit, HistoryState>(
      listener: (context, state) {
        if (state is ReportSubmitted) {
          Navigator.pop(context);
        } else if (state is ReportError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Report an Issue',
                  style: TextStyles.textSemiBold.black1.copyWith(fontSize: 18),
                ),
                const Gap(20),
                DropdownButtonFormField<IssueType>(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colours.lightThemeOrange5,
                        width: 2,
                      ),
                    ),
                    labelText: 'Issue Type',
                    filled: true,
                    fillColor: Colours.lightThemeWhite1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: _selectedIssue,
                  items: IssueType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(_issueTypeLabels[type]!),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedIssue = val),
                  validator: (val) =>
                      val == null ? 'Please select an issue type' : null,
                ),
                const Gap(16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colours.lightThemeOrange5,
                        width: 2,
                      ),
                    ),
                    labelText: 'Description',
                    filled: true,
                    fillColor: Colours.lightThemeWhite1,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Describe the issue in detail...',
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? 'Description required'
                      : null,
                ),
                const Gap(16),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colours.lightThemeGrey0, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colours.lightThemeWhite1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt,
                            color: Colours.lightThemeOrange5),
                        SizedBox(width: 10),
                        Text(
                          'Add Photo',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colours.lightThemeOrange5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(16),
                if (_imageFile != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _imageFile!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(16),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.lightThemeOrange5,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final report = ReportModel(
                          orderId: widget.orderId,
                          type: _selectedIssue!.name,
                          description: _descriptionController.text.trim(),
                          // You can extend ReportModel to handle image path if needed
                        );
                        context.read<HistoryCubit>().submitReport(report);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyles.textSemiBoldLarge.white1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
