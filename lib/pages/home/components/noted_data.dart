import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class NotedData extends StatelessWidget {
  const NotedData({
    Key? key,
    required this.notedValue,
  }) : super(key: key);

  final String notedValue;
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      maxLines: null,
      scrollController: ScrollController(),
      controller: TextEditingController(
        text : notedValue,
      ),
      decoration: InputDecoration(
      
      suffixIcon: IconButton(
        onPressed: () {},
        icon: Image.asset('assets/images/mines_square.png'),
      ),
      filled: true,
      fillColor: kPrimaryColor,
    ));
  }
}