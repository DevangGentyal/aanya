import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Aanya/common_vars.dart';
class FeatureItem extends StatelessWidget {
  final String text,nextPageName;
  final IconData icon1, icon2;
  final double fontSize, iconSize,width;
  final EdgeInsets padding;
  final Color backgroundColor;
  const FeatureItem({
    super.key,
    required this.text,
    required this.fontSize,
    required this.iconSize,
    required this.width,
    required this.icon1,
    required this.icon2,
    required this.backgroundColor,
    required this.padding,
    required this.nextPageName,
  });
  @override
  Widget build(BuildContext context) {
    CommonVariables commvars = Provider.of<CommonVariables>(context);

    return GestureDetector(
      onTap: (){
        commvars.updatePageName(nextPageName);
      },
      child: Container(
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10 * ffem)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10*ffem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Icon(
                      icon1,
                      color: Color.fromARGB(255, 132, 137, 255),
                      size: iconSize,
                    ),
                  ),
                  Container(
                    child: Icon(
                      icon2,
                      color: Color.fromARGB(255, 132, 137, 255),
                      size: iconSize,
                    ),
                  )
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 80 * fem,
              ),
              child: Text(
                text,
                softWrap: true,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff8388ff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
