import 'package:flutter/material.dart';
import 'package:my_app/src/resources/colors.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? dividerColor;

  const DividerWithText({
    Key? key,
    required this.text,
    this.textStyle,
    this.dividerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor ?? ColorsGlobal.textGrey,
            endIndent: 10,
          ),
        ),
        Text(
          text,
          style: textStyle ??
              const TextStyle(
                  color: ColorsGlobal.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Divider(
            color: dividerColor ?? ColorsGlobal.textGrey,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
