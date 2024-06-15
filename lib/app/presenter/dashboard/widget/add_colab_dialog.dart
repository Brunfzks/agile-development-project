// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_text.dart';
import 'package:agile_development_project/app/domain/entities/alert_message.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/infra/model/type_user_model.dart';
import 'package:agile_development_project/app/presenter/dashboard/cubit/dashboard_cubit.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
import 'package:agile_development_project/app/presenter/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddColabDialog extends StatefulWidget {
  const AddColabDialog({
    super.key,
    required this.projectDescriptionController,
    required this.onTap,
    required this.include,
    required this.project,
  });

  final TextEditingController projectDescriptionController;
  final Function() onTap;
  final bool include;
  final ProjectModel project;

  @override
  State<AddColabDialog> createState() => _AddColabDialogState();
}

class _AddColabDialogState extends State<AddColabDialog> {
  final formKey = GlobalKey<FormState>();
  ProjectUserModel? selectedUser;
  int _value = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.include ? 'Adicionar Colaborador' : 'Alterando'),
      content: SizedBox(
        height: 250,
        child: Form(
          key: formKey,
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                SearchAnchor(
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(
                        context
                            .read<DashboardCubit>()
                            .state
                            .projectsUsers
                            .length, (int index) {
                      final String item = context
                          .read<DashboardCubit>()
                          .state
                          .projectsUsers[index]
                          .email;
                      return ListTile(
                        enabled: widget.project.projectUsers
                            .where((value) =>
                                value.idUser ==
                                context
                                    .read<DashboardCubit>()
                                    .state
                                    .projectsUsers[index]
                                    .idUser)
                            .isEmpty,
                        title: Text(item),
                        onTap: () {
                          selectedUser = context
                              .read<DashboardCubit>()
                              .state
                              .projectsUsers[index];
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Admin'),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value ?? 1;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Colab'),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: _value,
                        onChanged: (int? value) {
                          setState(() {
                            _value = value ?? 2;
                          });
                        },
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 25,
                ),
                ButtonForm(
                  onPressed: () {
                    if (selectedUser != null) {
                      context
                          .read<DashboardCubit>()
                          .insertProjectuser(
                            ProjectUserModel(
                              idProjectUser: 0,
                              email: selectedUser!.email,
                              idProject: widget.project.idProject,
                              idUser: selectedUser!.idUser,
                              typeUser: TypeUserModel(
                                  idTypeUser: _value,
                                  typeUser: _value == 1 ? 'admin' : 'colab'),
                              user: selectedUser!.user,
                            ),
                          )
                          .then((value) {
                        formKey.currentContext!
                            .read<AlertMessageCubit>()
                            .showMessage(
                                value
                                    ? 'Colaborador ${selectedUser!.user} adicionado ao projeto'
                                    : 'Erro ao adicionar o colaborador',
                                value
                                    ? StatusMessage.success
                                    : StatusMessage.erro);
                      });
                      Navigator.pop(context);
                    }
                  },
                  heigth: 50,
                  width: 200,
                  text: Text(
                    widget.include ? 'Criar' : 'Alterar',
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
