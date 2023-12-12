import 'package:employee_management/apps/provider/user/user_provider.dart';
import 'package:employee_management/pages/home/home.dart';
import 'package:employee_management/pages/salary_detail/salary_detail.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSalary extends StatefulWidget {
  const ListSalary({ Key? key }) : super(key: key);

  @override
  _ListSalaryState createState() => _ListSalaryState();
}

class _ListSalaryState extends State<ListSalary> {
  UserProvider? userProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
            'Gaji',
            style: TextStyle(
                fontFamily: 'RobotoMedium',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        leading: IconButton(
            icon: Image.asset('assets/images/chev_right_black.png'),
            onPressed: () => Navigator.of(context).pop(),
          ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: Consumer<UserProvider>(
          builder: (userContext, valueUser, child) {
            userContext.read<UserProvider>().getUserData;
            userProvider = valueUser;
            return valueUser.userData.isEmpty && !valueUser.error ? const Center(child: CircularProgressIndicator())
            : valueUser.error ? ScaffoldMessenger(child: Text(valueUser.errorMessage)) 
            : Container(
              decoration: BoxDecoration(
                color: kBluePrimary
              ),
              child: Column(
                children: <Widget>[
                  /* USER DATA */
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: kBluePrimary,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * .07,
                            top: size.height * .03,
                            bottom: size.height * .005
                          ),
                          child: Text(
                            valueUser.userData['data']['fullname'],
                            style: const TextStyle(
                              fontFamily: 'RobotoRegular',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),
                          ),
                        ),
                  
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * .07,
                            bottom: size.height * .005
                  
                          ),
                          child: Text(
                            valueUser.userData['data']['role'].toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'RobotoRegular',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * .07,
                            bottom: size.height * .03
                  
                          ),
                          child: Text(
                            'NIP : ' + valueUser.userData['data']['nip'],
                            style: const TextStyle(
                              fontFamily: 'RobotoRegular',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: greyPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.03
                            ),
                            child: const Text(
                              'Daftar Gaji',
                              style: TextStyle(
                                fontFamily: 'RobotoMedium',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.black
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: size.width * 1,
                              child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (salaryContext, index) {
                                  return SalaryListData(
                                    onTap: () {
                                      Navigator.of(salaryContext, rootNavigator: true).push(
                                        MaterialPageRoute(builder: (context) => SalaryDetail()),
                                      );
                                    },
                                    size: size,
                                    image: 'assets/images/mei.png',
                                    salary: 'Rp. 7.000.000',
                                    month: 'Mei',
                                    date: '30/05/2022',
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SalaryListData extends StatelessWidget {
  const SalaryListData({
    Key? key,
    required this.size, required this.month, required this.date, required this.salary, required this.image, this.onTap
  }) : super(key: key);

  final Size size;
  final String month;
  final String date;
  final String salary;
  final String image;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 5
      ),
      child: Container(
        height: size.height * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: ListTile(
          onTap: onTap,
          leading: Image.asset(image),
          title: Text(
            month,
            style: TextStyle(
              fontFamily: 'RobotoMedium',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              date,
              style: TextStyle(
                fontFamily: 'RobotoRegular',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          trailing: Text(
            salary,
            style: TextStyle(
              fontFamily: 'RobotoMedium',
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            ),
          dense: false,
        ),
      ),
    );
  }
}