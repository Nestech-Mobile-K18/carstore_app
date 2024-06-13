import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String data;
  final Color? colorText;
  final double? sizeText;

  const AppTextWidget(
      {super.key, required this.data, this.colorText, this.sizeText});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: colorText ?? Colors.black,
        fontSize: sizeText,
      ),
    );
  }
}
