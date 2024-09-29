import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:my_campus/widget/constant.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final TextAlign? titleAlignment;
final bool? automaticallyImplyLeading;
  const MyAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.backgroundColor,   
    this.titleAlignment,  this.automaticallyImplyLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading??false,
      title: Text(title,style: kappbarTextStyle,textAlign:titleAlignment),
      actions: actions,
      backgroundColor: backgroundColor ??kappbarback,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
