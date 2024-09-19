import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.hint});
final String hint;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        child: Center(child: Text(hint,style: kLabelTextStyle,)),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color.fromARGB(158, 255, 193, 7),
            borderRadius: BorderRadius.circular(13)),
      ),
    );
  }
}
