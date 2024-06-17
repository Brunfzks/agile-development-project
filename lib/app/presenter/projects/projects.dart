import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/domain/entities/alert_message.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/infra/model/type_user_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/presenter/projects/cubit/project_cubit.dart';
import 'package:agile_development_project/app/presenter/projects/widgets/create_project_dialog.dart';
import 'package:agile_development_project/app/presenter/projects/widgets/project_card_grid_view.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
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
                  _createProjectDialog(context: context, user: widget.user);
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

_createProjectDialog({
  required BuildContext context,
  required UserModel user,
  String? text,
}) {
  TextEditingController projectDescriptionController =
      TextEditingController(text: text);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CreateProjectDialog(
          projectDescriptionController: projectDescriptionController,
          onTap: () {
            context
                .read<ProjectCubit>()
                .insertProjects(ProjectModel(
                    tasks: [],
                    statusProjectTask: [],
                    description: projectDescriptionController.text,
                    feedback: '',
                    idProject: 0,
                    projectUsers: [
                      ProjectUserModel(
                        idProjectUser: 0,
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
              (value) {
                if (!context.mounted) return;
                context.read<AlertMessageCubit>().showMessage(
                      value
                          ? 'Projeto ${projectDescriptionController.text} Criado Com Succesoo'
                          : 'Erro ao criar Projeto',
                      value ? StatusMessage.success : StatusMessage.erro,
                    );
              },
            );
            Navigator.pop(context);
          },
          include: true);
    },
  );
}
