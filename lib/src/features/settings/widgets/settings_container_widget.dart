import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class SettingsContainer extends StatelessWidget {
  final Widget left;
  final Widget right;
  final Function() action;

  const SettingsContainer({
    super.key,
    required this.left,
    required this.right,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: black10, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            left,
            right,
          ],
        ),
      ),
    );
  }
}
