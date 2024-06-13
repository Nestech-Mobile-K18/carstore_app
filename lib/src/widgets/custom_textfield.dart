import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/colors.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? labelText;
  final bool? obscureText;
  final TextInputType? textInputType;
  final Color? hintTextColor;
  final Color? contextColor;
  final Color? labelColor;
  final bool? disableTitle;
  final Widget? iconSuffit;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;
  final bool? isLeadIconImg;
  final String? pathLeadIconImg;
  final String? Function(String?)? validator;
  final FontWeight? contentFontWeight;
  final FontWeight? labelFontWeight;
  final double? contentSize;
  final double? labelSize;
  final bool? enableSuggestions;
  final bool? autocorrect;

  const CustomTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.labelText,
      this.labelColor,
      this.readOnly,
      this.obscureText,
      this.iconSuffit,
      this.disableTitle,
      this.hintTextColor,
      this.onChanged,
      this.autofillHints,
      this.onEditingComplete,
      this.inputFormatters,
      this.contextColor,
      this.contentFontWeight,
      this.labelFontWeight,
      this.contentSize,
      this.labelSize,
      this.isLeadIconImg,
      this.pathLeadIconImg,
      this.textInputType,
      this.enableSuggestions,
      this.autocorrect,
      this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    CustomTextFieldManager.register(this);
  }

  @override
  void dispose() {
    CustomTextFieldManager.unregister(this);
    super.dispose();
  }

  void _onTap() {
    setState(() {
      // Set the current CustomTextField as selected
      isSelected = true;
      // Reset all other CustomTextFields
      CustomTextFieldManager.resetAllExcept(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 2,
              color: isSelected
                  ? ColorsGlobal.globalOrange
                  : ColorsGlobal.dividerGrey,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.isLeadIconImg == true)
                    Image.asset(widget.pathLeadIconImg ?? ''),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: widget.onChanged,
                          onEditingComplete: widget.onEditingComplete,
                          autofillHints: widget.autofillHints,
                          enableSuggestions: widget.enableSuggestions ?? false,
                          validator: widget.validator,
                          autocorrect: widget.autocorrect ?? false,
                          onTap: _onTap,
                          keyboardType:
                              widget.textInputType ?? TextInputType.text,
                          controller: widget.controller,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color:
                                widget.contextColor ?? ColorsGlobal.globalGrey,
                            fontWeight:
                                widget.contentFontWeight ?? FontWeight.normal,
                            fontSize: widget.contentSize ?? 16.0,
                          ),
                          readOnly: widget.readOnly ?? false,
                          obscureText: widget.obscureText ?? false,
                          decoration: InputDecoration(
                              hintText: widget.hintText ?? '',
                              labelText: widget.disableTitle == true
                                  ? ""
                                  : widget.labelText,
                              labelStyle: TextStyle(
                                color: widget.labelColor ??
                                    ColorsGlobal.globalGrey,
                                fontWeight:
                                    widget.labelFontWeight ?? FontWeight.normal,
                                fontSize: widget.labelSize ?? 16.0,
                              ),
                              hintStyle: TextStyle(
                                  color: widget.hintTextColor ??
                                      ColorsGlobal.textGrey),
                              border: InputBorder.none,
                              suffixIcon: widget.iconSuffit),
                          inputFormatters: widget.inputFormatters,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class CustomTextFieldManager {
  static List<_CustomTextFieldState> _customTextFields = [];

  static void register(_CustomTextFieldState customTextFieldState) {
    _customTextFields.add(customTextFieldState);
  }

  static void unregister(_CustomTextFieldState customTextFieldState) {
    _customTextFields.remove(customTextFieldState);
  }

  static void resetAllExcept(_CustomTextFieldState currentTextField) {
    // Iterate through all CustomTextFields
    for (var textField in _customTextFields) {
      // If the current text field is not the selected one, reset its state
      if (textField != currentTextField) {
        // ignore: invalid_use_of_protected_member
        textField.setState(() {
          textField.isSelected = false;
        });
      }
    }
  }
}
