import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {super.key,
      required this.name,
      required this.image,
      required this.onPressed});
  final String name;
  final String image;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: screenHeight * 0.19,
          width: screenWidth * 0.19,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: kappbarback,
                blurRadius: 15.0,
                offset: Offset(0, 5))
          ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                 // backgroundColor: Colors.purple,
                 backgroundColor: Colors.white,
                  radius: 30,
                  // child: Icon(Icons.book),
                  child: Center(
                    child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/logo/$image.png",)),
                  )),
              const SizedBox(height: 10),
              Text(
                name,
                style: kcontainerTextStyle,
              )
            ],
          )),
    );
  }
}
