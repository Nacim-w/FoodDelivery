import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/text_style_extension.dart';
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
  IssueType? _selectedIssue;
  final _descriptionController = TextEditingController();

  final Map<IssueType, String> _issueTypeLabels = {
    IssueType.MISSING_PRODUCT: 'Missing Product',
    IssueType.WRONG_ORDER: 'Wrong Order',
    IssueType.LATE_DELIVERY: 'Late Delivery',
    IssueType.DRIVER: 'Driver Issue',
    IssueType.APPLICATION: 'Application Issue',
    IssueType.ORDER: 'Order Issue',
  };

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
        padding: EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report an Issue',
                style: TextStyles.textBoldSmall.black1,
              ),
              const Gap(16),
              DropdownButtonFormField<IssueType>(
                decoration: const InputDecoration(
                  labelText: 'Issue Type',
                  border: OutlineInputBorder(),
                ),
                value: _selectedIssue,
                items: IssueType.values.map((IssueType type) {
                  return DropdownMenuItem<IssueType>(
                    value: type,
                    child: Text(_issueTypeLabels[type]!),
                  );
                }).toList(),
                onChanged: (IssueType? newValue) {
                  setState(() {
                    _selectedIssue = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select an issue type' : null,
              ),
              const Gap(8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              const Gap(16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final report = ReportModel(
                        orderId: widget.orderId,
                        type: _selectedIssue!.name,
                        description: _descriptionController.text.trim(),
                      );
                      context.read<HistoryCubit>().submitReport(report);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
