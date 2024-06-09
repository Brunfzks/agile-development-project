import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/config/const_text.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/infra/model/type_user_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/presenter/main/cubit/main_cubit.dart';
import 'package:agile_development_project/app/presenter/projects/cubit/project_cubit.dart';
import 'package:agile_development_project/app/presenter/projects/widgets/project_card_grid_view.dart';
import 'package:agile_development_project/app/presenter/widgets/button_widget.dart';
import 'package:agile_development_project/app/presenter/widgets/field_form_widget.dart';
import 'package:agile_development_project/app/presenter/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Projects extends StatefulWidget {
  const Projects({super.key, required this.user});

  final UserModel user;

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  void initState() {
    context.read<ProjectCubit>().getProjects(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      primary: false,
      padding: const EdgeInsets.all(ConstParameters.constPadding),
      child: Column(
        children: [
          Header(titleScreen: 'MEUS PROJETOS', user: widget.user),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: ConstParameters.constPadding * 1.5,
                    vertical: ConstParameters.constPadding /
                        (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  _createProjectDialog(context, widget.user);
                },
                icon: const Icon(Icons.add),
                label: const Text("Novo Projeto"),
              ),
            ],
          ),
          const SizedBox(height: ConstParameters.constPadding),
          Responsive(
            mobile: ProjectCardGridView(
              crossAxisCount: size.width < 650 ? 2 : 4,
              childAspectRatio: size.width < 650 ? 1.3 : 1,
              projects: context.watch<ProjectCubit>().state.projects,
            ),
            tablet: ProjectCardGridView(
              projects: context.watch<ProjectCubit>().state.projects,
            ),
            desktop: ProjectCardGridView(
              projects: context.watch<ProjectCubit>().state.projects,
              childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _createProjectDialog(BuildContext context, UserModel user) {
  final formKey = GlobalKey<FormState>();
  TextEditingController projectDescriptionController = TextEditingController();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Novo Projeto'),
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
                    hintText: 'Descrição',
                    icon: const Icon(
                      Icons.description,
                      color: ConstColors.complementaryColor,
                    ),
                    controller: projectDescriptionController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Por Favor, entre com a descrição!';
                      }
                      return null;
                    },
                    maxLines: 5,
                    minLines: 5,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonForm(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<ProjectCubit>()
                            .insertProjects(ProjectModel(
                                description: projectDescriptionController.text,
                                feedback: '',
                                idProject: 0,
                                projectUsers: [
                                  ProjectUserModel(
                                    email: user.email,
                                    idProject: 0,
                                    idUser: user.idUser,
                                    typeUser: TypeUserModel(
                                      idTypeUser: 1,
                                      typeUser: 'Admin',
                                    ),
                                    user: user.user,
                                  )
                                ]))
                            .then(
                              (value) async =>
                                  await context.read<MainCubit>().showMessage(
                                        value
                                            ? 'Projeto Criado Com Succesoo'
                                            : 'Erro ao criar Projeto',
                                        value
                                            ? StatusMessage.success
                                            : StatusMessage.erro,
                                      ),
                            );
                        Navigator.pop(context);
                      }
                    },
                    heigth: 50,
                    width: 200,
                    text: Text(
                      'Criar',
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
    },
  );
}
