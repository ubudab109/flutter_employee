import 'package:employee_management/pages/home/components/profile_information_bar.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserInformationWidget extends StatelessWidget {
  final String fullname;
  final String role;
  final String nip;
  final String image;
  const UserInformationWidget(
      {Key? key,
      required this.size,
      required this.fullname,
      required this.role,
      required this.nip,
      required this.image})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size.width * 0.18,
          height: size.height * .07,
          decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(30))),
          child: Align(
            alignment: Alignment(size.width * .001, 0),
            child: Container(
                width: size.width * 0.15,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(image)))),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: size.width * .03),
          child:
              ProfileInformationBar(fullname: fullname, role: role, nip: nip),
        ),
        Container(
            margin: EdgeInsets.only(left: size.width * 0.3),
            padding: EdgeInsets.only(bottom: size.height * .03),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/svg/bell.svg',
                width: size.width * 0.1,
              ),
              onPressed: () {},
            ))
      ],
    );
  }
}
