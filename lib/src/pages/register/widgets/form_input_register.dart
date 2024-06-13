import 'package:flutter/material.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:my_app/src/resources/common.dart';
import 'package:my_app/src/resources/media_res.dart';
import 'package:my_app/src/resources/validation.dart';
import 'package:my_app/src/widgets/common/strings_extention.dart';
import 'package:my_app/src/widgets/custom_button.dart';
import 'package:my_app/src/widgets/custom_form.dart';
import 'package:my_app/src/widgets/custom_text.dart';
import 'package:my_app/src/widgets/image_button.dart';
import 'package:my_app/src/widgets/only/register/divider_with_text.dart';

import '../../../widgets/custom_textfield.dart';

// ignore: must_be_immutable
class FormInputRegister extends StatefulWidget {
  final dynamic formKey;
  final TextEditingController? userController;
  final TextEditingController? mailController;
  final TextEditingController? phoneController;
  final TextEditingController? passwordController;

  final void Function()? onLogIn;
  final void Function()? onSignUp;
  final void Function()? onGoogle;
  final void Function()? onFacebook;
  final void Function()? onTwitter;
  bool isShowPassword;
  FormInputRegister(
      {super.key,
      this.formKey,
      this.userController,
      this.mailController,
      this.phoneController,
      this.passwordController,
      this.isShowPassword = false,
      this.onLogIn,
      this.onSignUp,
      this.onGoogle,
      this.onFacebook,
      this.onTwitter});

  @override
  State<FormInputRegister> createState() => _FormInputRegisterState();
}

class _FormInputRegisterState extends State<FormInputRegister> {
  final Validation _validation = Validation();

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: CustomForm(
        formKey: widget.formKey,
        children: [
          CustomTextField(
            controller: widget.userController,
            textInputType: TextInputType.name,
            isLeadIconImg: true,
            pathLeadIconImg: MediaRes.userIcon,
            autofillHints: const [AutofillHints.username],
            labelText: StringsExtention.userName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy điền username';
              } else if (!_validation.isNameValid(value)) {
                return 'Tên người dùng phải có ít nhất 6 ký tự, không có số và kí tự biệt';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.mailController,
            textInputType: TextInputType.emailAddress,
            isLeadIconImg: true,
            pathLeadIconImg: MediaRes.mailIcon,
            autofillHints: const [AutofillHints.email],
            labelText: StringsExtention.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy điền email';
              } else if (!_validation.isEmailValid(value)) {
                return 'Email không hợp lệ';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.phoneController,
            textInputType: TextInputType.phone,
            isLeadIconImg: true,
            pathLeadIconImg: MediaRes.phoneIcon,
            autofillHints: const [AutofillHints.telephoneNumber],
            labelText: StringsExtention.phoneAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy điền số điện thoại';
              } else if (!_validation.isPhoneValid(value)) {
                return 'Số điện thoại không hợp lệ';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.passwordController,
            textInputType: TextInputType.visiblePassword,
            isLeadIconImg: true,
            pathLeadIconImg: MediaRes.lockIcon,
            autofillHints: const [AutofillHints.newPassword],
            obscureText: !widget.isShowPassword,
            labelText: StringsExtention.passWord,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Hãy điền password';
              } else if (!_validation.isPasswordValid(value)) {
                return 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa,\n chữ thường và ký tự đặc biệt';
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
          CustomButton(
            contentButton: StringsExtention.signUp,
            onTap: widget.onSignUp,
          ),
          const SizedBox(height: 24),
          const DividerWithText(text: StringsExtention.or),
          const SizedBox(height: 24),
          const CustomText(
            title: StringsExtention.signUpWith,
            color: ColorsGlobal.globalOrange,
            fontWeight: FontWeight.w500,
            size: 12,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageButton(
                onTap: widget.onFacebook,
                imagePath: MediaRes.facebookIcon,
                marginHorizontalButton: 10,
              ),
              ImageButton(
                onTap: widget.onTwitter,
                imagePath: MediaRes.instagramIcon,
                marginHorizontalButton: 10,
              ),
              ImageButton(
                onTap: widget.onGoogle,
                imagePath: MediaRes.googleIcon,
                marginHorizontalButton: 10,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: StringsExtention.alreadyHaveAnAccount,
                color: CommonValues().getColorFromHex('040415'),
                size: 14.0,
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                onPressed: widget.onLogIn,
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.zero,
                  ),
                ),
                child: CustomText(
                  title: StringsExtention.signIn,
                  color: CommonValues.backgroundColorDefault,
                  size: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
