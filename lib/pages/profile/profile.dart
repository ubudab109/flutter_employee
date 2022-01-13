// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables
import 'dart:io';

import 'package:employee_management/apps/provider/auth/auth_provider.dart';
import 'package:employee_management/pages/profile/subpages/pin_setting.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // AUTH PROVIDER
  AuthProvider? authProvider;

  // GET FILE FROM
  File? image;

  // UPLOAD FILE
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: kBluePrimary,
            automaticallyImplyLeading: false),
        backgroundColor: themePrimayColor,
        body: Consumer<AuthProvider>(
          builder: (context, value, child) {
            authProvider = value;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // USER DATA PROFILE
                  Container(
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.02),
                          child: Stack(
                            children: [
                              AvatarUserProfile(
                                images: image != null
                                    ? FileImage(image!)
                                    : AssetImage('assets/images/user_default.png'),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  iconSize: 40,
                                  icon: Image.asset('assets/images/camera_add.png'),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 200,
                                          width: double.infinity,
                                          color: themePrimayColor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () =>
                                                      pickImage(ImageSource.camera),
                                                  child: Text('Ambil Dari Kamera')),
                                              ElevatedButton(
                                                  onPressed: () =>
                                                      pickImage(ImageSource.gallery),
                                                  child: Text('Ambil Dari Galeri'))
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  color: kBluePrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        UserDataInformation(
                          dataName: 'Name',
                          valueName: 'Rizky Daus',
                        ),
                        UserDataInformation(
                          dataName: 'Posisi Jabatan',
                          valueName: 'Back End Developer',
                        ),
                        UserDataInformation(
                          dataName: 'NIP',
                          valueName: '3245620544',
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10.0))
                      ],
                    ),
                  ),
    
                  SizedBox(
                    height: size.height * 0.007,
                  ),
                  // USER CONTACT PROFILE
                  Container(
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserContactData(
                          size: size,
                          icon: 'assets/svg/Phone.svg',
                          value: '0857897458',
                        ),
                        UserContactData(
                          size: size,
                          icon: 'assets/svg/Message.svg',
                          value: 'rizkyfirdaus0309@gmail.com',
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10.0))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.007,
                  ),
    
                  // USER CONTACT PROFILE
                  Container(
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 51, bottom: 10),
                            child: Text(
                              'Keamanan Akun',
                              style: TextStyle(
                                  color: kBluePrimary,
                                  fontFamily: 'RobotoMedium',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 51),
                              child: SecuritySettingFlex(
                                settingName: 'Ganti Kata Sandi',
                              )),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 51),
                              child: SecuritySettingFlex(
                                onButtonClick: () {
                                  // Navigator?.pushNamed(context, '/pin');
                                  // Navigator.of(context).pushNamed("/pin");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PinSetting(
                                            isPinActive: true,
                                          )));
                                },
                                settingName: 'Atur Pin',
                              )),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10.0))
                      ],
                    ),
                  ),
    
                  SizedBox(
                    height: size.height * 0.007,
                  ),
    
                  // LOGOUT BUTTON
                  Container(
                      width: double.infinity,
                      height: size.height * 0.2,
                      color: kPrimaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 20, right: size.width * 0.07),
                              child: SizedBox(
                                width: 161,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    value.logout(context);
                                  },
                                  child: Text(value.loadingLogout ? 'Processing...' : 'Logout'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        kBluePrimary),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class SecuritySettingFlex extends StatelessWidget {
  const SecuritySettingFlex({
    Key? key,
    required this.settingName,
    this.onButtonClick,
  }) : super(key: key);

  final String settingName;
  final void Function()? onButtonClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 15, // 60% of space => (6/(6 + 4))
            child: Text(
              settingName,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'RobotoMedium',
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 4, // 40% of space
            child: Image.asset('assets/images/chevron-right.png'),
          ),
        ],
      ),
    );
  }
}

class UserContactData extends StatelessWidget {
  const UserContactData({
    Key? key,
    required this.size,
    required this.icon,
    required this.value,
  }) : super(key: key);

  // SIZE FOR RESPONSIVE
  final Size size;

  // ICON FOR KEY
  final String icon;

  // DATA CONTACT USER VALUE
  final String value;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: EdgeInsets.only(top: 15, left: 51),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(icon),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.035),
                child: Text(
                  value,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'RobotoMedium',
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
              )
            ],
          )),
    );
  }
}

class AvatarUserProfile extends StatelessWidget {
  const AvatarUserProfile({
    Key? key,
    required this.images,
  }) : super(key: key);
  final images;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: images,
      radius: 78,
      backgroundColor: themePrimayColor,
    );
  }
}

class UserDataInformation extends StatelessWidget {
  const UserDataInformation({
    Key? key,
    required this.dataName,
    required this.valueName,
  }) : super(key: key);
  final String dataName;
  final String valueName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 51),
            child: Text(
              dataName,
              style: TextStyle(
                  color: kBluePrimary,
                  fontFamily: 'RobotoMedium',
                  fontWeight: FontWeight.w300,
                  fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 51),
            child: Text(
              valueName,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'RobotoMedium',
                  fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}