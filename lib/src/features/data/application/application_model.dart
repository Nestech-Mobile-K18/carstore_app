import 'package:flutter/material.dart';

class BottomNavItemModel {
  final IconData iconData;
  final String label;

  BottomNavItemModel({required this.iconData, required this.label});
}

var bottomTabs = [
  const BottomNavigationBarItem(
    icon: Icon(
      Icons.home,
    ),
    label: 'Home',
  ),
  const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
  const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Profile'),
];
