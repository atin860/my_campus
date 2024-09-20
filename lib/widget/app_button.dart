import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.hint, required this.onPressed});
final String hint;
final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: kBackgroundColors,
            borderRadius: BorderRadius.circular(13)),
        
        child: Center(child: Text(hint,style: kLabelTextStyle,)),
      ),
    );
  }
}
