import 'dart:developer';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_campus/screens/auth_view/login_scr.dart';
import 'package:my_campus/screens/home_scr.dart';
import 'package:my_campus/widget/loading.dart';
import 'package:my_campus/widget/toast_msg.dart';

// Main Controller
class MainController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 1), () {
      auth.userChanges().listen((user) {
        if (user == null) {
          Get.offAll(() => LoginScr());
        } else {
          // Get.offAll(() => MyApp());
          Get.offAll(() => HomeScreen());
        }
      });
    });
  }

//Login Screen controller
  void login(String email, String password) async {
    showLoading();
    try {
      final Credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      dismissLoadingWidget();
    } on FirebaseAuthException catch (e) {
      dismissLoadingWidget();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showToastMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showToastMessage('Wrong password provided for that user.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        print('Wrong password provided for that user.');
        showToastMessage('Wrong email or password.');
      } else {
        log("FirebaseAuthException: $e");
        print(
          e.message!,
        );
        showToastMessage("Wrong Password provided");
      }
    } catch (e) {
      dismissLoadingWidget();
      log("catch error: $e");
      showToastMessage(e.toString());
      successMessage("Login Successfull");
    }
  }

// Signup Screen controller
  void signup(String email, String password,) async {
    showLoading();
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      dismissLoadingWidget();
      successMessage('Account created successfully');
      // credential.user!.updateDisplayName(name); // TO SET THE NAME OF THE USER
      auth.currentUser!.displayName ?? ""; // TO GET THE NAME OF THE USER
    } on FirebaseAuthException catch (e) {
      dismissLoadingWidget();
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showToastMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showToastMessage('The account already exists for that email.');
      } else {
        print(e);
        showToastMessage(e.message!);
      }
      dismissLoadingWidget();
    } catch (e) {
      dismissLoadingWidget();
      print(e);
      showToastMessage(e.toString());
    }
  }

// Logout button controller
  void logout() async {
    showLoading();
    await auth.signOut();
    dismissLoadingWidget();
    successMessage("logout Succesfully");
  }

// Forget button controller
  void forgetPassword(String email) async {
    showLoading();
    try {
      await auth
          .sendPasswordResetEmail(email: email)
          .then((value) => log('Send otp to $email'));
      dismissLoadingWidget();
      successMessage('Reset password link sent to $email');
    } catch (e) {
      dismissLoadingWidget();
      print(e);
      showToastMessage(e.toString());
    }
  }
}

FirebaseAuth auth = FirebaseAuth.instance;