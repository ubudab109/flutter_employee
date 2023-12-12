import 'package:carousel_slider/carousel_controller.dart';
import 'package:employee_management/pages/salary/salary.dart';
import 'package:employee_management/pages/salary_detail/components/carousel_salary_detail.dart';
import 'package:employee_management/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// FOR DUMMY CHART
class ChartData {
  ChartData(
      {required this.x,
      required this.y,
      required this.color,
      required this.radius});
  final String x;
  final double y;
  final String color;
  final String radius;
}

class SalaryDetail extends StatefulWidget {
  const SalaryDetail({Key? key}) : super(key: key);

  @override
  _SalaryDetailState createState() => _SalaryDetailState();
}

class _SalaryDetailState extends State<SalaryDetail> {
  late List<ChartData> data;
  late TooltipBehavior tooltipBehavior;
  CarouselController controllerDot = CarouselController();
  int activeIndexCarousel = 0;
  List<Map<String, dynamic>> dummy = [
    {
      'data' : 12312312,
      'data2' : 31212312,
      'data3' : 1231231,
      'data4' : 1232432
    },
    {
      'data' : 12312312,
      'data2' : 31212312,
      'data3' : 1231231,
      'data4' : 1232432
    }
  ];
  @override
  void initState() {
    data = [
      ChartData(x: 'Potongan', y: 1750000, color: '0XFFFF6C19', radius: '70%'),
      ChartData(
          x: 'Pendapatan', y: 5250000, color: '0XFF4AD3FE', radius: '80%'),
    ];
    tooltipBehavior =
        TooltipBehavior(enable: true, format: "point.x : point.y");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Rincian Gaji',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'RobotoMedium',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        leading: IconButton(
          icon: Image.asset('assets/images/chev_right_black.png'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: greyPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: themePrimayColor),
          child: Column(
            children: [
              Center(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: greyPrimaryColor),
                      child: Column(
                        children: [
                          ChartSalary(tooltipBehavior: tooltipBehavior, data: data),
                          SalaryChartLegend(size: size)
                        ],
                      ))),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: greyPrimaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.03,
                              left: size.width * 0.07
                            ),
                            child: Text(
                              'Detail Pendapatan',
                              style: TextStyle(
                                fontFamily: 'RobotoMedium',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: size.width * 2,
                          //   child: CarouselSalarDetail(
                          //     size: size, 
                          //     activeIndex: activeIndexCarousel, 
                          //     onPageChanged: (index, reason) {
                          //       setState(() {
                          //         activeIndexCarousel = index;
                          //       });
                          //     },
                          //     onDotClicked: (index) {
                          //       controllerDot.animateToPage(index,
                          //           duration: Duration(seconds: 1),
                          //           curve: Curves.ease);
                          //     }, 
                          //     controller: controllerDot,
                          //     itemBuilder: (context, index, realIndex) {
                          //       return Padding(
                          //           padding: const EdgeInsets.all(7.0),
                          //           child: Container(
                          //             width: size.width * 0.8,
                          //             decoration:
                          //                   BoxDecoration(
                          //                     borderRadius: BorderRadius.circular(10),
                          //                   color: kPrimaryColor, 
                          //                   boxShadow: const <BoxShadow>[
                          //                   BoxShadow(
                          //                     color: Color.fromRGBO(0, 0, 0, 0.25),
                          //                     offset: Offset(0, 4),
                          //                     blurRadius: 4.0,
                          //                     spreadRadius: 0)
                          //               ]),
                          //             child: Column(
                          //               children: <Widget>[
                                          
                          //               ],
                          //             ),
                          //           ),
                          //         );
                          //     },
                          //   ),
                          // ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _salaryCarouselWidget(Widget child, Size size) {
    return Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          width: size.width * 0.8,
          decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                color: kPrimaryColor, 
                boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4.0,
                  spreadRadius: 0)
            ]),
          child: Column(
            children: <Widget>[
              child
            ],
          ),
        ),
      );
  }


  Widget _salaryData(List<Text> data) {
    return Column(
      children: <Widget>[
        ...data
      ],
    );
  }
}

class SalaryChartLegend extends StatelessWidget {
  const SalaryChartLegend({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            LegendChart(icon: 'assets/svg/circle_blue.svg', text: 'Rp. 5.250.000', size: size,),
            Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: size.width * 0.03,
                bottom: size.height * 0.03
              ),
              child: Text(
                'Pendapatan',
                style: TextStyle(
                    fontFamily: 'RobotoMedium',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFAAAAAA)
                  )
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.only(right: size.width * 0.05),
          child: Column(
            children: <Widget>[
              LegendChart(icon: 'assets/svg/cirle_orange.svg', text: 'Rp. 1.750.000', size: size,),
              Padding(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: size.height * 0.03
                ),
                child: Text(
                  'Potongan',
                  style: TextStyle(
                      fontFamily: 'RobotoMedium',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFAAAAAA)
                    )
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartSalary extends StatelessWidget {
  const ChartSalary({
    Key? key,
    required this.tooltipBehavior,
    required this.data,
  }) : super(key: key);

  final TooltipBehavior tooltipBehavior;
  final List<ChartData> data;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        margin: EdgeInsets.all(15),
        tooltipBehavior: tooltipBehavior,
        enableMultiSelection: true,
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Rp. 7.000.000',
                style: TextStyle(
                    fontFamily: 'RobotoMedium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  'Laba Kotor',
                  style: TextStyle(
                      fontFamily: 'RobotoMedium',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFC4C4C4)),
                ),
              )
            ],
          ))
        ],
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            dataSource: data,
            startAngle: 30,
            endAngle: 30,
            pointColorMapper: (ChartData data, _) =>
                Color(int.parse(data.color)),
            yValueMapper: (ChartData data, _) => data.y,
            xValueMapper: (ChartData data, _) => data.x,
            innerRadius: '70%',
            explode: true,
            explodeIndex: 1

            
          )
        ]);
  }
}

class LegendChart extends StatelessWidget {
  const LegendChart({ Key? key, required this.icon, required this.text, required this.size }) : super(key: key);
  final String icon;
  final String text;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.02
          ),
          child: SvgPicture.asset(icon),
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'RobotoMedium',
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}