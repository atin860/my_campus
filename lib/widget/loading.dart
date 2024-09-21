// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

showLoading([String? text]) => Get.defaultDialog(
    backgroundColor: Colors.white, //.withOpacity(1),
    titleStyle: const TextStyle(fontSize: 0),
    title: "Loading...",
    content: Column(
      children: [
        SpinKitFadingCube(
          color: Colors.blue,
          size: 50.0,
        ),
        if (text != null)
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(text)
            ],
          )
      ],
    ),
    barrierDismissible: false);

dismissLoadingWidget() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) {
    Get.back();
  }
}

Widget loadingWidget() {
  return Center(
    child: SpinKitFadingCube(
      color: Colors.blue,
      size: 50.0,
    ),
  );
}