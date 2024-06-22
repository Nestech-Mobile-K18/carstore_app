import 'package:flutter/material.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:my_app/src/widgets/common/strings_extention.dart';
import 'package:my_app/src/widgets/only/home/research_bar.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ReSearchBar(
            hintText: StringsExtention.searchExample,
            colorSearch: ColorsGlobal.globalColorReSearch,
            onChanged: (value) {},
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.multiple_stop_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}
