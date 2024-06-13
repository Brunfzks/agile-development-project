// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/presenter/dashboard/cubit/dashboard_cubit.dart';
import 'package:agile_development_project/app/presenter/dashboard/widget/add_colab_dialog.dart';
import 'package:agile_development_project/app/presenter/dashboard/widget/create_group_dialog.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';

import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/presenter/main/widgets/side_menu.dart';
import 'package:agile_development_project/app/presenter/widgets/header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  final GlobalKey<_DashboardState> dashbordKey = GlobalKey();

  @override
  void initState() {
    context.read<DashboardCubit>().getProject(widget.project);
    controller.addGroups(context.read<DashboardCubit>().returnGroupData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () async {
                                                context
                                                    .read<DashboardCubit>()
                                                    .getUsers();
                                                _addColabDialog();
                                              },
                                              child: Container(
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(30)),
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
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          width: 40,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            color: ConstColors.backGroundColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              state.project.projectUsers[index]
                                                  .user.characters.first
                                                  .toUpperCase(),
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
                    groupConstraints: const BoxConstraints.tightFor(width: 240),
                    headerBuilder: (context, group) {
                      return AppFlowyGroupHeader(
                        addIcon: const Icon(Icons.add),
                        margin: const EdgeInsets.all(8),
                        title: Text(group.headerData.groupName),
                      );
                    },
                    controller: controller,
                    cardBuilder: (context, group, groupItem) {
                      final textItem = groupItem as TextItem;
                      return AppFlowyGroupCard(
                        decoration: const BoxDecoration(color: Colors.red),
                        key: ObjectKey(textItem),
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
  TextItem(this.s);

  @override
  String get id => s;
}
