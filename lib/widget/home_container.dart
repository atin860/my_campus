import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key, required this.itemName});
  final String itemName;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        height: screenHeight * 0.18,
        width: screenWidth * 0.40,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: kBackgroundColors, borderRadius: BorderRadius.circular(15)),
        child: const Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.library_add,
              size: 40,
              color: Colors.white,
            ),
            //  Image(image: AssetImage("assets/img/human.png")),
            SizedBox(height: 20),
            Text(
              "Items name",
              style: kcontainerTextStyle,
            )
          ],
        ));
  }
}
