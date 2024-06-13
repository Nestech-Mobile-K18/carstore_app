import 'package:flutter/material.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:my_app/src/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? colorButton;
  final String? contentButton;
  final Color? colorContentButton;
  final double? contentSize;
  final FontWeight? contentFontWeight;
  const CustomButton({
    super.key,
    this.onTap,
    this.colorButton,
    required this.contentButton,
    this.colorContentButton,
    this.contentSize,
    this.contentFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colorButton ?? ColorsGlobal.globalOrange,
        ),
        child: CustomText(
          title: contentButton,
          color: colorContentButton ?? ColorsGlobal.globalWhite,
          size: contentSize ?? 18,
          fontWeight: contentFontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }
}
