// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.color,
    this.onPressed,
    this.icon,
  }) : super(key: key);
  final Color color;
  final void Function()? onPressed;
  final Image? icon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints.expand(width: 40, height: 50),
      onPressed: onPressed,
      hoverColor: Colors.white,
      fillColor: color,
      enableFeedback: true,
      child: icon,
      shape: CircleBorder(),
    );
  }
}