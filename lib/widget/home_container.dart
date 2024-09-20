import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({
    super.key,
  });
//final String image;

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Container(
        height: screenHeight * 0.18,
        width: screenWidth * 0.20,
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(94, 171, 239, 0.842),
              blurRadius: 30.0,
              offset: Offset(0, 10))
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 70,
                child: Image(image: AssetImage("assets/img/human.png"))),
            SizedBox(height: 20),
            Text(
              "item name",
              style: kcontainerTextStyle,
            )
          ],
        ));
  }
}
