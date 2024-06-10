import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/domain/entities/alert_message.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/presenter/dashboard/widgets/file_info_card.dart';
import 'package:agile_development_project/app/presenter/main/cubit/main_cubit.dart';
import 'package:agile_development_project/app/presenter/projects/cubit/project_cubit.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CardProjects extends StatelessWidget {
  const CardProjects({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding:
                    const EdgeInsets.all(ConstParameters.constPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFA4CDFF).withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  'assets/icons/one_drive.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFFA4CDFF), BlendMode.srcIn),
                ),
              ),
              PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 'Excluir':
                      context.read<ProjectCubit>().deleteProjects(project).then(
                          (value) => context.read<AlertMessageCubit>().showMessage(
                              value
                                  ? 'Projeto ${project.description} excluido com sucesso!'
                                  : 'Erro ao excluir o projeto!',
                              value
                                  ? StatusMessage.success
                                  : StatusMessage.erro));
                      break;
                  }
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      enabled: context.read<ProjectCubit>().verifyProjectType(
                          context.read<MainCubit>().state.user.idUser, project),
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
                      enabled: context.read<ProjectCubit>().verifyProjectType(
                          context.read<MainCubit>().state.user.idUser, project),
                      value: 'Alterar',
                      child: const Row(
                        children: [
                          Icon(Icons.delete),
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
    );
  }
}
