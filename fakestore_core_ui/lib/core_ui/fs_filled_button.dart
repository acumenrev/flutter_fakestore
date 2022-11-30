import 'package:flutter/material.dart';

class FSFilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonTitle;
  final Color backgroundColor;
  final TextStyle buttonTitleStyle;
  final double buttonRadius;

  const FSFilledButton(
      {super.key,
      this.onPressed,
      required this.buttonTitle,
      this.backgroundColor = Colors.grey,
      this.buttonRadius = 0,
      this.buttonTitleStyle = const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      )});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonTitle),
      style: ButtonStyle(
          textStyle:
              MaterialStateTextStyle.resolveWith((states) => buttonTitleStyle),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius)))),
    );
  }
}
