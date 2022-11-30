import 'package:flutter/material.dart';

class FSOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonTitle;
  final Color outlineColor;
  final TextStyle buttonTitleStyle;
  final double buttonRadius;

  const FSOutlineButton(
      {super.key,
      this.onPressed,
      required this.buttonTitle,
      this.outlineColor = Colors.grey,
      this.buttonRadius = 0,
      this.buttonTitleStyle = const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 14,
      )});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(buttonTitle),
      style: ButtonStyle(
          textStyle:
              MaterialStateTextStyle.resolveWith((states) => buttonTitleStyle),
          side: MaterialStateProperty.all(BorderSide(
              color: outlineColor, width: 1.0, style: BorderStyle.solid)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius)))),
    );
  }
}
