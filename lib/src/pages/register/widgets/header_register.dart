import 'package:flutter/material.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:my_app/src/resources/media_res.dart';
import 'package:my_app/src/widgets/common/strings_extention.dart';
import 'package:my_app/src/widgets/custom_text.dart';

class HeaderRegister extends StatelessWidget {
  const HeaderRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(MediaRes.logo),
        const SizedBox(height: 95),
        const Column(
          children: [
            CustomText(
              title: StringsExtention.signUp,
              fontWeight: FontWeight.w600,
              color: ColorsGlobal.globalBlack,
              size: 20.0,
            ),
            CustomText(
              title: StringsExtention.welcomeToCarStore,
              fontWeight: FontWeight.w400,
              color: ColorsGlobal.globalBlack,
              size: 14.0,
            ),
          ],
        ),
        const SizedBox(height: 44),
      ],
    );
  }
}
