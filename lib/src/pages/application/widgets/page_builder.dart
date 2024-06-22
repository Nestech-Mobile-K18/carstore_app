import 'package:flutter/material.dart';
import 'package:my_app/src/pages/home/home_page.dart';

// ignore: must_be_immutable
class PageBuilder extends StatefulWidget {
  final int index;

  const PageBuilder({
    super.key,
    required this.index,
  });

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  String? userAddress;
  @override
  Widget build(BuildContext context) {
    return buildPage(widget.index);
  }

  Widget buildPage(int index) {
    List<Widget> widget = [
      const HomePage(),
      Container(),
      Container(),
    ];

    return widget[index];
  }
}
