// ignore_for_file: prefer_const_constructors

import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/presenter/main/cubit/main_cubit.dart';
import 'package:agile_development_project/app/presenter/main/widgets/side_menu.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/presenter/projects/projects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: Stack(children: [
        SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                const Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: Projects(
                  user: context.watch<MainCubit>().state.user,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return AnimatedPositioned(
              left: state.notificationShow ? 20 : -450,
              top: 20,
              duration: Duration(seconds: 2),
              child: notificationMessage(
                  context, state.notificationStatus, state.notificarionMessage),
            );
          },
        ),
      ]),
    );
  }

  Widget notificationMessage(
      BuildContext context, StatusMessage status, String message) {
    late Color color;
    late String text;
    switch (status) {
      case StatusMessage.erro:
        color = ConstColors.erroColor;
        text = 'Error';
        break;
      case StatusMessage.success:
        color = ConstColors.sucessColor;
        text = 'Success';
        break;
      case StatusMessage.warning:
        color = ConstColors.warningColor;
        text = 'Warning';
        break;
    }

    return Card(
      elevation: 5,
      child: SizedBox(
        width: 400,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.check_circle,
              color: color,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text),
                Text(
                  message,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    context.read<MainCubit>().removeMessage();
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
