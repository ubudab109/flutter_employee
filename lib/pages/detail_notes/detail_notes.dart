// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:employee_management/apps/model/employee_note/employee_note.dart';
import 'package:employee_management/apps/repository/auth_repository.dart';
import 'package:employee_management/apps/repository/note_data_repository.dart';
import 'package:employee_management/pages/detail_notes/components/list_note_data.dart';
import 'package:employee_management/pages/detail_notes/components/shimmer_list_note.dart';
import 'package:employee_management/pages/home/home.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailNotes extends StatefulWidget {
  final String date;
  final String dateFormat;
  const DetailNotes({Key? key, required this.date, required this.dateFormat})
      : super(key: key);

  @override
  _DetailNotesState createState() => _DetailNotesState();
}

class _DetailNotesState extends State<DetailNotes> {

  // initialize future note data
  late Future<List<EmployeeNoteByDate>> noteDataFuture;

  // selected id from note data
  int? idNote;

  //checking if request get error or not. default false
  bool isRequestError = false;

  // checking if delete error or not. default false;
  bool isDeleteError = false;

  /// FUTURE TO GET NOTE DATA IN CURRENT SELECTED DATE
  Future<List<EmployeeNoteByDate>> getNoteDataByDate() async {
    var token = await AuthRepository().hasToken();

    http.Response response = await NoteDataRepository().getNoteData(token, widget.date);

    List<EmployeeNoteByDate> employeeNotes = [];
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body)['data']['note_data'];
      for (var value in map) {
        EmployeeNoteByDate employeeNoteByDate = EmployeeNoteByDate(
            id: value['id'].toString(),
            color: value['color'] ?? '0XFFFFFFFF',
            time: value['format_time'],
            note: value['note']);

        employeeNotes.add(employeeNoteByDate);
      }
    } else {
      setState(() {
        isRequestError = true;
      });
    }

    return employeeNotes;
  }


  /// DELETE EMPLOYEE NOTE DATA
  Future deleteEmployeeNote(BuildContext context) async {
    var token = await AuthRepository().hasToken();
    http.Response response = await NoteDataRepository().deleteNoteData(token, idNote!);
    if (response.statusCode == 200) {
      var count = jsonDecode(response.body)['data']['count'];
      if (count < 1) {
        backTohome(context);
      }
       ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text('Note Berhasil Dihapus'),
          duration: const Duration(seconds: 2),
      ));
      setState(() {
        isDeleteError = false;
      });
    } else {
      setState(() {
        isDeleteError = true;
      });
    }
  }

  /// BACK TO HOME.
  /// 
  /// THIS FUNCTION WILL USED IF NOTE DATA IN CURRENT DATE IS EMPTY AFTER DELETE
  void backTohome(BuildContext context) async {
    ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(
      content: Text('Note Berhasil Dihapus'),
      duration: const Duration(seconds: 2),
    ));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeMain();
        },
      ));        
  }

  /// SHOWING DIALOG ALERT IN BUTTON DELETE
  showAlertDialog(BuildContext dialogContext) {
    Widget cancelButton = TextButton(
      onPressed: (){
        setState(() {
          idNote = null;
        });
        Navigator.of(dialogContext, rootNavigator: true).pop();
      }, 
      child: Text('Batal')
    );

    Widget confirmButton = TextButton(
      onPressed: () async {
        await deleteEmployeeNote(dialogContext);
        Navigator.of(dialogContext, rootNavigator: true).pop();
        setState(() {
          noteDataFuture = getNoteDataByDate();
        });
      },
      child: Text('Hapus')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Menghapus pengingat?'),
      content: Text('Anda yakin ingin menghapus pengingat ini?'),
      actions: [
        cancelButton, 
        confirmButton
      ],
    );

    showDialog(context: dialogContext, builder: (context) => alertDialog,);
  }

  @override
  void initState() {
    noteDataFuture = getNoteDataByDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          noteDataFuture = getNoteDataByDate();
        });
      } ,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kBluePrimary,
          leading: IconButton(
            icon: Image.asset('assets/images/chevron-left.png'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeMain();
                },
            )),
          ),
          title: const Text(
            'Detail Pengingat',
            style: TextStyle(
                fontFamily: 'RobotoMedium',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: themePrimayColor),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                decoration:
                    BoxDecoration(color: kPrimaryColor, boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4.0,
                      spreadRadius: 0)
                ]),
                height: size.height * 0.08,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 10, right: 29),
                    child: Text(
                      widget.dateFormat,
                      style: const TextStyle(
                          fontFamily: 'RobotoMedium',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: noteDataFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (isRequestError) {
                    return ScaffoldMessenger(child: Center(child: Text('Error: Terjadi kesalahan pada server'),));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final notes = snapshot.data;
                      if (notes?.isEmpty) {
                        backTohome(context);
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: notes?.length,
                          itemBuilder: (listViewContext, index) {
                            return ListNoteData(
                              color: notes![index].color, 
                              time: notes[index].time, 
                              note: notes[index].note,
                              onTap: () {
                                setState(() {
                                  idNote = int.parse(notes[index].id);
                                });
                                showAlertDialog(listViewContext);
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ShimmerListNote();
                          },
                        ),
                      );
                    }
                  } else if (snapshot.connectionState == ConnectionState.active) {
                    return Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ShimmerListNote();
                          },
                        ),
                      );
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ShimmerListNote();
                          },
                        ),
                      );
                  } else {
                    return ScaffoldMessenger(child: Center(child: Text('Tidak ada koneksi internet'),));
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}


