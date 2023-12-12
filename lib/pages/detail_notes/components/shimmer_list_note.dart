// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListNote extends StatelessWidget {
  const ShimmerListNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      highlightColor: Colors.grey.shade200,
      baseColor: Colors.grey.shade400,
      child: ListTile(
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 10,
                width: 10,
                padding: const EdgeInsets.only(right: 5),
                color: Colors.grey.shade400,
              ),
            ),
            Container(
              height: 10,
              width: 25,
              padding: const EdgeInsets.only(right: 5),
              color: Colors.grey.shade400,
            ),
          ],
        ),
        subtitle: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    height: 10,
                    width: size.width * 1,
                    padding: const EdgeInsets.only(right: 5),
                    color: Colors.grey.shade400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    height: 10,
                    width: size.width * 1,
                    padding: const EdgeInsets.only(right: 5),
                    color: Colors.grey.shade400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    height: 10,
                    width: size.width * 1,
                    padding: const EdgeInsets.only(right: 5),
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            )),
        dense: true,
        contentPadding: EdgeInsets.all(20),
        trailing: Container(
          width: 15,
          height: 20,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}