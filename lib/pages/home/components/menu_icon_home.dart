import 'package:flutter/material.dart';

class MenuIconHome extends StatelessWidget {
  const MenuIconHome({
    Key? key,
    this.onPressed,
    required this.iconName,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String iconName;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          iconSize: 50,
          icon: Image.asset('assets/images/$icon'),
          onPressed: onPressed,
        ),
        Text(
          iconName,
          style: const TextStyle(
              fontFamily: 'RobotoRegular',
              fontSize: 12,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
