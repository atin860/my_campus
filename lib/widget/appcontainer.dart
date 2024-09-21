import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.name, required this.image});
  final String name;
 final String image;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Container(
        height: screenHeight * 0.18,
        width: screenWidth * 0.20,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(94, 171, 239, 0.842),
              blurRadius: 30.0,
              offset: Offset(0, 10))
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 70,
                child: CircleAvatar(
                    radius: 60,
                   // child: Icon(Icons.book),
                    child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/logo/$image.png"))
                        )
                        ),
            SizedBox(height: 20),
            Text(
              name,
              style: kcontainerTextStyle,
            )
          ],
        ));
  }
}