import 'package:employee_management/pages/home/components/noted_data.dart';
import 'package:flutter/material.dart';

class NoteDataEmpty extends StatelessWidget {
  const NoteDataEmpty({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(
            border: Border(
            left: BorderSide(
                style: BorderStyle.solid,
                width: 6,
                color: Colors.white
            ),
          ),
        // borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only( bottom: 0 ),
      child: const NotedData(
        notedValue: 'Tidak Ada Catatan Pada Tanggal Yang Dipilih'
      ));
  }
}