import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/domain/entities/alert_message.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/presenter/dashboard/dashboard.dart';
import 'package:agile_development_project/app/presenter/dashboard_old/widgets/file_info_card.dart';
import 'package:agile_development_project/app/presenter/main/cubit/main_cubit.dart';
import 'package:agile_development_project/app/presenter/projects/cubit/project_cubit.dart';
import 'package:agile_development_project/app/presenter/projects/widgets/create_project_dialog.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardProjects extends StatelessWidget {
  const CardProjects({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                    project: project,
                    user: context.read<MainCubit>().state.user)),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(ConstParameters.constPadding),
          decoration: const BoxDecoration(
            color: ConstColors.secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA4CDFF).withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(
                      context.read<ProjectCubit>().verifyProjectType(
                              context.read<MainCubit>().state.user.idUser,
                              project)
                          ? Icons.admin_panel_settings
                          : Icons.person,
                      color: const Color(0xFFA4CDFF),
                    ),
                  ),
                  PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 'Excluir':
                          context
                              .read<ProjectCubit>()
                              .deleteProjects(project)
                              .then((value) {
                            if (!context.mounted) {
                              return;
                            }
                            context.read<AlertMessageCubit>().showMessage(
                                value
                                    ? 'Projeto ${project.description} excluido com sucesso!'
                                    : 'Erro ao excluir o projeto!',
                                value
                                    ? StatusMessage.success
                                    : StatusMessage.erro);
                          });
                          break;
                        case 'Alterar':
                          _alterProjectDialog(
                              context: context, project: project);
                          break;
                      }
                    },
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          enabled: context
                              .read<ProjectCubit>()
                              .verifyProjectType(
                                  context.read<MainCubit>().state.user.idUser,
                                  project),
                          value: 'Excluir',
                          child: const Row(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Excluir"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          enabled: context
                              .read<ProjectCubit>()
                              .verifyProjectType(
                                  context.read<MainCubit>().state.user.idUser,
                                  project),
                          value: 'Alterar',
                          child: const Row(
                            children: [
                              Icon(Icons.note_alt),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Alterar"),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Text(
                project.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const ProgressLine(
                color: Color(0xFFA4CDFF),
                percentage: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_alterProjectDialog({
  required BuildContext context,
  required ProjectModel project,
}) {
  TextEditingController projectDescriptionController =
      TextEditingController(text: project.description);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CreateProjectDialog(
          projectDescriptionController: projectDescriptionController,
          onTap: () {
            context
                .read<ProjectCubit>()
                .updateProjects(ProjectModel(
                    statusProjectTask: project.statusProjectTask,
                    description: projectDescriptionController.text,
                    feedback: project.feedback,
                    idProject: project.idProject,
                    projectUsers: project.projectUsers))
                .then(
              (value) {
                if (!context.mounted) return;
                context.read<AlertMessageCubit>().showMessage(
                      value
                          ? 'Projeto ${projectDescriptionController.text} Atualizado Com Succesoo'
                          : 'Erro ao Atualizar Projeto',
                      value ? StatusMessage.success : StatusMessage.erro,
                    );
              },
            );
            Navigator.pop(context);
          },
          include: false);
    },
  );
}
