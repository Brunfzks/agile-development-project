import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    this.maskFormatter,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.enable = true,
    this.isPassword = false,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
    this.textStyle,
  });

  final String hintText;
  final Icon icon;
  final TextInputFormatter? maskFormatter;
  final TextEditingController controller;
  final bool enable;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int maxLines;
  final int minLines;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLines: maxLines,
        minLines: minLines,
        style: textStyle ?? ConstText.formFieldText,
        validator: validator,
        obscureText: isPassword,
        enabled: enable,
        controller: controller,
        inputFormatters: [maskFormatter ?? MaskTextInputFormatter()],
        decoration: InputDecoration(
          fillColor: ConstColors.backGroundColor.withAlpha(70),
          filled: true,
          hintText: hintText,
          hintStyle: textStyle ?? ConstText.formFieldText,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFFDFE4EC)),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
