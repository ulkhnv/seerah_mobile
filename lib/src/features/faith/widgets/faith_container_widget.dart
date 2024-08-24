import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class FaithContainerWidget extends StatelessWidget {
  final Widget child;
  final double verticalPadding;
  final double horizontalPadding;
  final Color color;
  final double? width;
  final double? height;
  final double borderRadius;

  const FaithContainerWidget({
    super.key,
    required this.child,
    this.verticalPadding = 0,
    this.horizontalPadding = 0,
    this.color = white,
    this.width,
    this.height,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: black10,
        ),
      ),
      child: child,
    );
  }
}
