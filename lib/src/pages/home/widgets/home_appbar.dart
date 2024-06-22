import 'package:flutter/material.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:my_app/src/widgets/common/strings_extention.dart';
import 'package:my_app/src/widgets/custom_text.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsGlobal.globalWhite,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          size: 24,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              size: 24,
            ))
      ],
      centerTitle: true,
      title: const CustomText(
        title: StringsExtention.appName,
        color: ColorsGlobal.globalOrange,
        size: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
