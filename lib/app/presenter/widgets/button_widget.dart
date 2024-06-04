import 'package:flutter/material.dart';

class ButtonForm extends StatelessWidget {
  const ButtonForm({
    super.key,
    required this.width,
    required this.text,
    required this.heigth,
    required this.color,
    required this.borderColor,
  });

  final double width;
  final double heigth;
  final Text text;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heigth,
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStatePropertyAll(BorderSide(
              color: borderColor, width: 2, style: BorderStyle.solid)),
          backgroundColor: MaterialStatePropertyAll(color),
        ),
        onPressed: () {},
        child: text,
      ),
    );
  }
}
