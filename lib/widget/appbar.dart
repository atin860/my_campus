import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:my_campus/widget/constant.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final TextAlign? titleAlignment;
  final bool? automaticallyImplyLeading;
  final Action? action;
  const MyAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.backgroundColor,
    this.titleAlignment,
    this.automaticallyImplyLeading,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      title: Text(
        title,
        style: kappbarTextStyle,
        textAlign: titleAlignment,
      ),
      actions: actions,
      backgroundColor: backgroundColor ?? kappbarback,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
