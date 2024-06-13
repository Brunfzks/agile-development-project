// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_text.dart';
import 'package:agile_development_project/app/presenter/widgets/button_widget.dart';
import 'package:agile_development_project/app/presenter/widgets/field_form_widget.dart';
import 'package:flutter/material.dart';

class AddColabDialog extends StatelessWidget {
  AddColabDialog({
    super.key,
    required this.projectDescriptionController,
    required this.onTap,
    required this.include,
  });

  final TextEditingController projectDescriptionController;
  final formKey = GlobalKey<FormState>();
  final Function() onTap;
  final bool include;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(include ? 'Adicionar Colaborador' : 'Alterando'),
      content: SizedBox(
        height: 250,
        child: Form(
          key: formKey,
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                FormFieldWidget(
                  textStyle: ConstText.formFieldTextComplementary,
                  hintText: 'Nome Grupo',
                  icon: const Icon(
                    Icons.description,
                    color: ConstColors.complementaryColor,
                  ),
                  controller: projectDescriptionController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Por Favor, entre com o nome!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ButtonForm(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onTap();
                    }
                  },
                  heigth: 50,
                  width: 200,
                  text: Text(
                    include ? 'Criar' : 'Alterar',
                    style: ConstText.h1,
                  ),
                  color: ConstColors.secondaryColor,
                  borderColor: ConstColors.complementaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
