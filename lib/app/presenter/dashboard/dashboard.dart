// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agile_development_project/app/config/const_text.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/infra/model/task_model.dart';
import 'package:agile_development_project/app/presenter/widgets/field_form_widget.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/domain/entities/alert_message.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/presenter/dashboard/cubit/dashboard_cubit.dart';
import 'package:agile_development_project/app/presenter/dashboard/widget/add_colab_dialog.dart';
import 'package:agile_development_project/app/presenter/dashboard/widget/create_group_dialog.dart';
import 'package:agile_development_project/app/presenter/main/widgets/side_menu.dart';
import 'package:agile_development_project/app/presenter/projects/cubit/project_cubit.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/alert_message.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
import 'package:agile_development_project/app/presenter/widgets/header.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    required this.user,
    required this.project,
  });

  final UserModel user;
  final ProjectModel project;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late AppFlowyBoardController controller;
  final GlobalKey<_DashboardState> dashbordKey = GlobalKey();

  @override
  void initState() {
    context.read<DashboardCubit>().getProject(widget.project);
    controller = AppFlowyBoardController(
      onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        debugPrint('Move item from $fromIndex to $toIndex');

        context.read<DashboardCubit>().moveGroup(controller.groupIds);
      },
      onMoveGroupItem: (groupId, fromIndex, toIndex) {
        debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
      },
      onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
        var task = context
            .read<DashboardCubit>()
            .state
            .project
            .tasks
            .where((value) => value.idStatus.toString() == fromGroupId)
            .toList();

        context
            .read<DashboardCubit>()
            .updateTask(TaskModel(
              deadLine: task[fromIndex].deadLine,
              description: task[fromIndex].description,
              idProject: task[fromIndex].idProject,
              idStatus: int.parse(toGroupId),
              idTask: task[fromIndex].idTask,
              idUser: task[fromIndex].idUser,
              ordem: toIndex,
              priority: task[fromIndex].priority,
            ))
            .then((value) {
          if (!value) return;

          controller.clear();
          controller
              .addGroups(context.read<DashboardCubit>().returnGroupData());
        });
      },
    );
    controller.addGroups(context.read<DashboardCubit>().returnGroupData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: dashbordKey,
          drawer: const SideMenu(),
          body: Row(children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: ConstParameters.constPadding,
                    right: ConstParameters.constPadding,
                    bottom: ConstParameters.constPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Header(
                            titleScreen: widget.project.description,
                            user: widget.user)),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<DashboardCubit, DashboardState>(
                            builder: (context, state) {
                              return Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.project.projectUsers.length + 1,
                                    itemBuilder: (context, index) {
                                      return index ==
                                              state.project.projectUsers.length
                                          ? SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (!context
                                                        .read<ProjectCubit>()
                                                        .verifyProjectType(
                                                            widget.user.idUser,
                                                            widget.project)) {
                                                      return;
                                                    }
                                                    context
                                                        .read<DashboardCubit>()
                                                        .getUsers();
                                                    _addColabDialog();
                                                  },
                                                  child: Container(
                                                    width: 40,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      color: ConstColors
                                                          .backGroundColor,
                                                    ),
                                                    child: const Center(
                                                      child: Icon(Icons.add),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                color:
                                                    ConstColors.backGroundColor,
                                              ),
                                              child: PopupMenuButton(
                                                onSelected: (value) {
                                                  switch (value) {
                                                    case 'Excluir':
                                                      var user = state.project
                                                          .projectUsers[index];
                                                      context
                                                          .read<
                                                              DashboardCubit>()
                                                          .deleteProjectuser(
                                                              user)
                                                          .then(
                                                            (value) => dashbordKey
                                                                .currentContext!
                                                                .read<
                                                                    AlertMessageCubit>()
                                                                .showMessage(
                                                                  value
                                                                      ? 'Colaborador ${user.user} Removido do projeto'
                                                                      : 'Erro ao remover o colaborador',
                                                                  value
                                                                      ? StatusMessage
                                                                          .success
                                                                      : StatusMessage
                                                                          .erro,
                                                                ),
                                                          );
                                                      break;
                                                  }
                                                },
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      enabled: false,
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.email),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(state
                                                              .project
                                                              .projectUsers[
                                                                  index]
                                                              .email),
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      enabled: !(state
                                                                  .project
                                                                  .projectUsers[
                                                                      index]
                                                                  .idUser ==
                                                              widget.user
                                                                  .idUser) &&
                                                          context
                                                              .read<
                                                                  ProjectCubit>()
                                                              .verifyProjectType(
                                                                  widget.user
                                                                      .idUser,
                                                                  widget
                                                                      .project),
                                                      value: 'Excluir',
                                                      child: const Row(
                                                        children: [
                                                          Icon(Icons.delete),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "Remover do projeto"),
                                                        ],
                                                      ),
                                                    ),
                                                  ];
                                                },
                                                child: Center(
                                                  child: Text(
                                                    state
                                                        .project
                                                        .projectUsers[index]
                                                        .user
                                                        .characters
                                                        .first
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: ConstParameters.constPadding * 1.5,
                                vertical: ConstParameters.constPadding /
                                    (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: () {
                              if (!context
                                  .read<ProjectCubit>()
                                  .verifyProjectType(
                                      widget.user.idUser, widget.project)) {
                                return;
                              }
                              _alterGroupDialog();
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: ConstParameters.constPadding),
                    Expanded(
                      flex: 5,
                      child: AppFlowyBoard(
                        config: const AppFlowyBoardConfig(
                            groupBackgroundColor: Colors.blue,
                            groupBodyPadding: EdgeInsets.all(8)),
                        groupConstraints:
                            const BoxConstraints.tightFor(width: 240),
                        headerBuilder: (context, group) {
                          return AppFlowyGroupHeader(
                            addIcon: const Icon(Icons.add),
                            moreIcon: const Icon(Icons.remove),
                            margin: const EdgeInsets.all(8),
                            onMoreButtonClick: () {
                              if (!context
                                  .read<ProjectCubit>()
                                  .verifyProjectType(
                                      widget.user.idUser, widget.project)) {
                                return;
                              }

                              context
                                  .read<DashboardCubit>()
                                  .deleteStatus(context
                                      .read<DashboardCubit>()
                                      .state
                                      .project
                                      .statusProjectTask
                                      .firstWhere((value) =>
                                          value.idStatusProjectTask ==
                                          int.parse(group.id)))
                                  .then((value) {
                                controller.clear();
                                controller.addGroups(dashbordKey.currentContext!
                                    .read<DashboardCubit>()
                                    .returnGroupData());
                                dashbordKey.currentContext!
                                    .read<DashboardCubit>()
                                    .moveGroup(controller.groupIds);
                              });
                            },
                            title: Text(group.headerData.groupName),
                          );
                        },
                        controller: controller,
                        cardBuilder: (context, group, groupItem) {
                          final textItem = groupItem as TextItem;
                          return AppFlowyGroupCard(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            key: ObjectKey(textItem),
                            child: cardTask(textItem),
                          );
                        },
                        footerBuilder: (context, group) {
                          return const AppFlowyGroupFooter();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
        BlocBuilder<AlertMessageCubit, AlertMessageState>(
          builder: (context, state) {
            return SizedBox(
              width: state.messages.isNotEmpty ? 450 : 0,
              height: state.messages.length * 70,
              child: ListView.builder(
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    return AlertMessageWidget(
                      status: state.messages[index].status,
                      message: state.messages[index].message,
                    );
                  }),
            );
          },
        )
      ],
    );
  }

  SizedBox cardTask(TextItem textItem) {
    Color priority;
    switch (textItem.task.priority) {
      case 1:
        priority = ConstColors.sucessColor;
        break;
      case 2:
        priority = ConstColors.warningColor;
        break;
      case 3:
        priority = ConstColors.erroColor;
        break;
      default:
        priority = ConstColors.sucessColor;
        break;
    }
    return SizedBox(
      width: 240,
      child: Column(
        children: [
          PopupMenuButton(
            onSelected: (value) {
              if (textItem.task.priority == value) {
                return;
              }
              context
                  .read<DashboardCubit>()
                  .updateTask(TaskModel(
                    deadLine: textItem.task.deadLine,
                    description: textItem.controller.text,
                    idProject: textItem.task.idProject,
                    idStatus: textItem.task.idStatus,
                    idTask: textItem.task.idTask,
                    idUser: textItem.task.idUser,
                    ordem: textItem.task.ordem,
                    priority: value,
                  ))
                  .then((value) {
                if (!value) return;

                controller.clear();
                controller.addGroups(
                    context.read<DashboardCubit>().returnGroupData());
              });
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.auto_awesome),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Low Priority'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.assignment_late),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Normal Priority'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      Icon(Icons.warning),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Top Priority'),
                    ],
                  ),
                ),
              ];
            },
            child: Container(
              height: 8,
              decoration: BoxDecoration(color: priority),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FormFieldWidget(
            onTapOutside: (value) {
              if (textItem.task.description == textItem.controller.text) {
                return;
              }
              context
                  .read<DashboardCubit>()
                  .updateTask(TaskModel(
                    deadLine: textItem.task.deadLine,
                    description: textItem.controller.text,
                    idProject: textItem.task.idProject,
                    idStatus: textItem.task.idStatus,
                    idTask: textItem.task.idTask,
                    idUser: textItem.task.idUser,
                    ordem: textItem.task.ordem,
                    priority: textItem.task.priority,
                  ))
                  .then((value) {
                if (!value) return;

                controller.clear();
                controller.addGroups(
                    context.read<DashboardCubit>().returnGroupData());
              });
            },
            backgroundColor: ConstColors.complementaryColor,
            outlineInputBorder: InputBorder.none,
            maxLines: 20,
            controller: textItem.controller,
            hintText: 'Descrição',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: ConstColors.backGroundColor,
                ),
                child: Container(
                  width: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: ConstColors.backGroundColor,
                  ),
                  child: PopupMenuButton(
                    onSelected: (value) {
                      value as ProjectUserModel;
                      context
                          .read<DashboardCubit>()
                          .updateTask(TaskModel(
                            deadLine: textItem.task.deadLine,
                            description: textItem.controller.text,
                            idProject: textItem.task.idProject,
                            idStatus: textItem.task.idStatus,
                            idTask: textItem.task.idTask,
                            idUser: value.idUser,
                            ordem: textItem.task.ordem,
                            priority: textItem.task.priority,
                          ))
                          .then((value) {
                        if (!value) return;

                        controller.clear();
                        controller.addGroups(
                            context.read<DashboardCubit>().returnGroupData());
                      });
                    },
                    itemBuilder: (context) {
                      return List<PopupMenuItem>.from(
                        context
                            .read<DashboardCubit>()
                            .state
                            .project
                            .projectUsers
                            .map<PopupMenuItem>(
                              (x) => PopupMenuItem(
                                enabled: x.idUser != textItem.task.idUser,
                                value: x,
                                child: Row(
                                  children: [
                                    const Icon(Icons.person),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(x.email),
                                  ],
                                ),
                              ),
                            ),
                      );
                    },
                    child: Center(
                      child: Text(context
                          .read<DashboardCubit>()
                          .state
                          .project
                          .projectUsers
                          .firstWhere(
                              (value) => textItem.task.idUser == value.idUser)
                          .user
                          .characters
                          .first
                          .toUpperCase()),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    _alterDataPicker((data) {
                      if (data.value == textItem.task.deadLine) {
                        return;
                      }
                      context
                          .read<DashboardCubit>()
                          .updateTask(TaskModel(
                            deadLine: data.value,
                            description: textItem.task.description,
                            idProject: textItem.task.idProject,
                            idStatus: textItem.task.idStatus,
                            idTask: textItem.task.idTask,
                            idUser: textItem.task.idUser,
                            ordem: textItem.task.ordem,
                            priority: textItem.task.priority,
                          ))
                          .then((value) {
                        if (!value) return;
                        controller.clear();
                        controller.addGroups(
                            context.read<DashboardCubit>().returnGroupData());
                      });
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    '${textItem.task.deadLine.day}/${textItem.task.deadLine.month}/${textItem.task.deadLine.year}',
                    style: ConstText.formFieldText,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _alterGroupDialog() {
    TextEditingController projectDescriptionController =
        TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CreateGroupDialog(
            projectDescriptionController: projectDescriptionController,
            onTap: () {
              context
                  .read<DashboardCubit>()
                  .createStatus(projectDescriptionController.text)
                  .then((value) {
                controller.clear();
                controller.addGroups(dashbordKey.currentContext!
                    .read<DashboardCubit>()
                    .returnGroupData());
              });

              Navigator.pop(context);
            },
            include: true);
      },
    );
  }

  _alterDataPicker(
      Function(DateRangePickerSelectionChangedArgs)? _onSelectionChanged) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 300,
            height: 300,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: DateTime.now().add(const Duration(days: 1)),
            ),
          ),
        );
      },
    );
  }

  _addColabDialog() {
    TextEditingController projectDescriptionController =
        TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddColabDialog(
          project: context.read<DashboardCubit>().state.project,
          projectDescriptionController: projectDescriptionController,
          onTap: () {},
          include: true,
        );
      },
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;
  final TaskModel task;
  final TextEditingController controller;

  TextItem(
    this.s,
    this.task,
    this.controller,
  );

  @override
  String get id => s;
}
