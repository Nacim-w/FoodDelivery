import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legy/common/extensions/text_style_extension.dart';
import 'package:legy/common/res/media.dart';
import 'package:legy/common/res/styles/colours.dart' show Colours;
import 'package:legy/common/res/styles/text.dart';

class DetailsLocation extends StatefulWidget {
  const DetailsLocation({super.key, required this.from, required this.to});
  final String from;
  final String to;

  @override
  State<DetailsLocation> createState() => _DetailsLocationWidgetState();
}

class _DetailsLocationWidgetState extends State<DetailsLocation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colours.lightThemeGrey2),
          borderRadius: BorderRadius.circular(12),
        ),
        leading: SvgPicture.asset(
          width: 20,
          height: 20,
          Media.paymentLocation,
        ),
        title: Row(
          children: [
            Text("${widget.from} -> ${widget.to}",
                style: TextStyles.textSemiBoldLarge.black1),
          ],
        ),
        subtitle: Text("221B Dakarn,Senegal",
            style: TextStyles.textMediumLarge.black1),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colours.lightThemeGrey2),
        onTap: () {},
      ),
    );
  }
}
