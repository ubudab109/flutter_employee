// ignore_for_file: prefer_const_constructors

import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';

class PinSetting extends StatefulWidget {
  final bool isPinActive;

  const PinSetting({Key? key, required this.isPinActive}) : super(key: key);

  @override
  _PinSettingState createState() => _PinSettingState();
}

class _PinSettingState extends State<PinSetting> {
  late bool isPinActive;

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  String? otp;

  @override
  void initState() {
    super.initState();
    isPinActive = widget.isPinActive;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBluePrimary,
        title: const Text('Atur Pin'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset('assets/images/chevron-left.png'),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SizedBox(
        width: double.infinity,
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: const Text(
                        'PIN',
                        style: TextStyle(
                            fontFamily: 'RobotoMedium',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 1,
                      child: Switch.adaptive(
                        activeColor: kBluePrimary,
                        autofocus: false,
                        value: isPinActive,
                        onChanged: (value) {
                          setState(() {
                            isPinActive = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: isPinActive
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.02,
                              bottom: 20,
                            ),
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Masukkan Pin',
                                style: TextStyle(
                                    color: kBluePrimary,
                                    fontFamily: 'RobotoMedium',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              PinTextField(
                                  controller: _fieldOne, autoFocus: true),
                              PinTextField(
                                  controller: _fieldTwo, autoFocus: false),
                              PinTextField(
                                  controller: _fieldThree, autoFocus: false),
                              PinTextField(
                                  controller: _fieldFour, autoFocus: false),
                              PinTextField(
                                  controller: _fieldFive, autoFocus: false),
                              PinTextField(
                                  controller: _fieldSix, autoFocus: false),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.02,
                              top: 20,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    otp = _fieldOne.text +
                                        _fieldTwo.text +
                                        _fieldThree.text +
                                        _fieldFour.text +
                                        _fieldFive.text +
                                        _fieldSix.text;
                                  });
                                },
                                child: const Text('Submit'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kBluePrimary),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PinTextField extends StatelessWidget {
  const PinTextField(
      {Key? key, required this.controller, required this.autoFocus})
      : super(key: key);

  final TextEditingController controller;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.5)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.5)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.5)),
          counterText: '',
          hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        onChanged: (value) {
          if (value == '') FocusScope.of(context).previousFocus();
          if (value.length == 1) FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}
