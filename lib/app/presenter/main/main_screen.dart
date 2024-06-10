import 'package:agile_development_project/app/presenter/main/cubit/main_cubit.dart';
import 'package:agile_development_project/app/presenter/main/widgets/side_menu.dart';
import 'package:agile_development_project/app/config/responsive.dart';
import 'package:agile_development_project/app/presenter/projects/projects.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/alert_message.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
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
        BlocBuilder<AlertMessageCubit, AlertMessageState>(
          builder: (context, state) {
            return SizedBox(
              width: state.messages.isNotEmpty ? 450 : 0,
              height: state.messages.length * 70,
              child: AnimatedList(
                  key: state.listKey,
                  initialItemCount: state.messages.length,
                  itemBuilder: (context, index, animation) {
                    return AlertMessageWidget(
                      animation: animation,
                      status: state.messages[index].status,
                      message: state.messages[index].message,
                    );
                  }),
            );
          },
        )
      ]),
    );
  }
}
