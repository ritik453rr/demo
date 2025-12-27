import 'package:demo/core/app_constants.dart';
import 'package:demo/core/common/app_button.dart';
import 'package:demo/core/routes/app_routes.dart';
import 'package:demo/extensions/app_extensions.dart';
import 'package:demo/storage/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  /// Controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  /// Variables
  var emailError = null;
  var passwordError = null;
  var isLoading = false;

  /// Method to validate email
  bool validateEmail() {
    var email = emailController.text.trim();
    if (email.isEmpty) {
      emailError = "Enter password";
      return false;
    }
    if (!AppConstants.isValidEmail(email)) {
      emailError = "enter valid email";
      return false;
    }
    return true;
  }

  /// Method to validate password
  bool validatePass() {
    var password = passwordController.text.trim();
    if (password.isEmpty) {
      passwordError = "Enter password";
      return false;
    }
    return true;
  }

  /// Updates email error message based on input validation.
  void onChangeEmail(String val) {
    val.isEmpty ? emailError = "enter email" : emailError = null;
  }

  /// Updates password error message based on input validation.
  void onChangePass(String val) {
    val.trim().isEmpty
        ? passwordError = "enter password"
        : passwordError = null;
  }

  /// Validates inputs and simulates a login process with a loading state.
  Future<void> login({required context}) async {
    if (isLoading) return; // Prevent multiple login attempts
    if (validateEmail() && validatePass()) {
      AppConstants.hideKeyBoard();
      setState(() {
        isLoading = true;
      });
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "Login successful", isSuccess: true);
        AppStorage.setLoginStatus(status: true);
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        showSnackBar(context, e.message ?? "Login failed", isSuccess: false);
      }
    }
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isSuccess = true,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Text Field for email
            TextField(
              controller: emailController,
              onChanged: (val) {
                setState(() {
                  onChangeEmail(val);
                });
              },
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: emailError,
                border: OutlineInputBorder(),
              ),
            ),
            10.h,

            /// Text Field for password
            TextField(
              controller: passwordController,
              onChanged: (val) {
                setState(() {
                  onChangePass(val);
                });
              },
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
                errorText: passwordError,
              ),
              obscureText: true,
            ),
            20.h,

            isLoading
                ? CircularProgressIndicator()
                :
                /// Login Button
                appButton(
                  title: "Login",
                  onPressed: () {
                    login(context: context);
                  },
                ),
          ],
        ),
      ),
    );
  }
}
