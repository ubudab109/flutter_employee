import 'package:flutter/material.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({
    Key? key,
    this.onPressed
  }) : super(key: key);
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(

        icon: const Icon(Icons.add),
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color(0XFFFF6161)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
        ),
        label: const Text('Buat Catatan',
            style: TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 14,
                fontWeight: FontWeight.w700)));
  }
}
