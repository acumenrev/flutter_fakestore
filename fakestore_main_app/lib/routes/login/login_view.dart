import 'package:fakestore_main_app/app_utils.dart';
import 'package:fakestore_main_app/routes/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../constants/color_constants.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key, required this.controller}) {
    _setupObservers();
  }
  LoginControllerInterface controller;
  final _formKey = GlobalKey<FormState>();
  late BuildContext _buildContext;

  _setupObservers() {
    controller.loginStatus.stream.listen((event) {
      ScaffoldMessenger.of(_buildContext).hideCurrentSnackBar();
      String textValue = "";
      Color snackBarColor = Colors.white;
      Color textColor = ColorConstants.colorE30404;
      if (event.isSuccess) {
        textValue = "Login Success";
        snackBarColor = Colors.white;
        textColor = ColorConstants.colorE30404;
        // Navigate to main page
        _buildContext.pushReplacement("/");
      } else if (event.isError) {
        textValue = event.errorMessage ?? "";
        snackBarColor = Colors.red;
        textColor = Colors.white;
      }
      ScaffoldMessenger.of(_buildContext).showSnackBar(
        SnackBar(
          content: Text(
            textValue,
            style: TextStyle(color: textColor),
          ),
          backgroundColor: snackBarColor,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: _buildContentView(context),
        ),
      ),
    );
  }

  List<Widget> _buildContentView(BuildContext context) {
    List<Widget> list = List.empty(growable: true);
    // svg background
    list.add(_buildSvgBackground(context));
    // form
    list.add(_buildLoginForm(context));
    list.add(Obx(() {
      return controller.isLoading.isTrue
          ? Stack(
              children: [
                // black background
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),
                // circular progress indicator
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              ],
            )
          : const SizedBox(height: 0, width: 0);
    }));
    return list;
  }

  Widget _buildSvgBackground(BuildContext context) {
    return SvgPicture.asset(
      'resources/images/rose-petals.svg',
      alignment: Alignment.center,
      fit: BoxFit.cover,
      allowDrawingOutsideViewBox: true,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          // Logo
          Center(
            child: Image.asset(
              "resources/images/42-Doge-Face.jpg",
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          // Username
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
            child: TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppUtils.getLocalizationContext(context)
                      .login_username_helper_text;
                }
                return null;
              },
              style: const TextStyle(
                  color: Colors.limeAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
              controller: controller.username.value,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(color: Colors.lightGreenAccent),
                  labelText:
                      AppUtils.getLocalizationContext(context).login_username,
                  labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          // Password
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
            child: Obx(() {
              return TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppUtils.getLocalizationContext(context)
                        .login_password_helper_text;
                  }
                  return null;
                },
                style: const TextStyle(
                    color: Colors.limeAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                obscureText: controller.hidePassword.value,
                controller: controller.password.value,
                decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.lightGreenAccent),
                    suffixIcon: InkWell(
                      onTap: () {
                        controller.hidePassword.toggle();
                      },
                      child: Icon(
                        controller.hidePassword.value
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    labelText:
                        AppUtils.getLocalizationContext(context).login_password,
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600)),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    controller.login();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    AppUtils.getLocalizationContext(context).login_login_button,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
