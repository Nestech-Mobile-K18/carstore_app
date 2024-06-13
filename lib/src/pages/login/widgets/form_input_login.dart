import 'package:flutter/material.dart';
import 'package:my_app/src/resources/common.dart';
import 'package:my_app/src/resources/media_res.dart';
import 'package:my_app/src/widgets/common/strings_extention.dart';
import 'package:my_app/src/widgets/custom_button.dart';
import 'package:my_app/src/widgets/custom_form.dart';
import 'package:my_app/src/widgets/custom_text.dart';

import '../../../widgets/custom_textfield.dart';

// ignore: must_be_immutable
class FormInputLogin extends StatefulWidget {
  final dynamic formKey;
  final TextEditingController? userController;
  final TextEditingController? passwordController;
  final void Function()? onForgotPassword;
  final void Function()? onLogIn;
  final void Function()? onSignUp;
  bool isShowPassword;
  FormInputLogin(
      {super.key,
      this.formKey,
      this.userController,
      this.passwordController,
      this.isShowPassword = false,
      this.onForgotPassword,
      this.onLogIn,
      this.onSignUp});

  @override
  State<FormInputLogin> createState() => _FormInputLoginState();
}

class _FormInputLoginState extends State<FormInputLogin> {
  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: CustomForm(
        formKey: widget.formKey,
        children: [
          CustomTextField(
            controller: widget.userController,
            isLeadIconImg: true,
            pathLeadIconImg: MediaRes.userIcon,
            autofillHints: const [AutofillHints.username],
            labelText: StringsExtention.userName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy điền username';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.passwordController,
            isLeadIconImg: true,
            pathLeadIconImg: MediaRes.lockIcon,
            autofillHints: const [AutofillHints.newPassword],
            obscureText: !widget.isShowPassword,
            labelText: StringsExtention.passWord,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy điền password';
              }
              return null;
            },
            iconSuffit: IconButton(
              icon: Icon(
                widget.isShowPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                setState(
                  () {
                    widget.isShowPassword = !widget.isShowPassword;
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: widget.onForgotPassword,
            child: const Text(
              StringsExtention.forgotPassword,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            contentButton: StringsExtention.login,
            onTap: widget.onLogIn,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: StringsExtention.dontHaveAnAccount,
                color: CommonValues().getColorFromHex('040415'),
                size: 14.0,
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                onPressed: widget.onSignUp,
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.zero,
                  ),
                ),
                child: CustomText(
                  title: StringsExtention.signUp,
                  color: CommonValues.backgroundColorDefault,
                  size: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
