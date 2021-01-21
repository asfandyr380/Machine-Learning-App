import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCard extends StatelessWidget {
  final String path;
  final Function onTap;
  CustomCard({this.path, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 151,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xff1B4558), width: 1.8),
        ),
        child: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            path,
            height: 82,
            width: 82,
          ),
        ),
      ),
    );
  }
}

Row cardRow(
    {BuildContext ctx,
    String path1,
    String path2,
    var returnType1,
    var returnType2}) {
      MainAxisAlignment rowAlignment = MainAxisAlignment.spaceEvenly;
  return Row(
    mainAxisAlignment: rowAlignment,
    children: [
      CustomCard(
        path: path1,
        onTap: () {
          Navigator.push(ctx, MaterialPageRoute(builder: (context) {
            return returnType1;
          }));
        },
      ),
      CustomCard(
        path: path2,
        onTap: () {
          Navigator.push(ctx, MaterialPageRoute(builder: (context) {
            return returnType2;
          }));
        },
      ),
    ],
  );
}