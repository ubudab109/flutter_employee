import 'package:employee_management/splashcreen/splashscreen.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(const Main()));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management Attendence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: themePrimayColor, primaryColor: themePrimayColor),
      home: const Scaffold(
        backgroundColor: kPrimaryColor,
        body: Splashscreen(),
      ),
    );
  }
}
