import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final List<Widget>? children;
  final dynamic formKey;
  final bool? canPop;
  final Function()? onChanged;
  final void Function(bool)? onPopInvoked;
  final AutovalidateMode? autovalidateMode;
  final void Function(bool, Object?)? onPopInvokedWithResult;
  final Future<bool> Function()? onWillPop;
  const CustomForm(
      {super.key,
      this.children,
      this.formKey,
      this.canPop,
      this.onChanged,
      this.onPopInvoked,
      this.autovalidateMode,
      this.onPopInvokedWithResult,
      this.onWillPop});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: onChanged,
      // ignore: deprecated_member_use
      onPopInvoked: onPopInvoked,
      autovalidateMode: autovalidateMode,
      onPopInvokedWithResult: onPopInvokedWithResult,
      canPop: canPop,
      // ignore: deprecated_member_use
      onWillPop: onWillPop,
      child: Column(
        children: children ?? [],
      ),
    );
  }
}
