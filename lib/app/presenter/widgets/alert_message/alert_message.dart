import 'package:agile_development_project/app/config/const_color.dart';
import 'package:agile_development_project/app/presenter/widgets/alert_message/cubit/alert_message_cubit.dart';
import 'package:flutter/material.dart';

import 'package:agile_development_project/app/domain/entities/alert_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertMessageWidget extends StatefulWidget {
  const AlertMessageWidget({
    super.key,
    required this.status,
    required this.message,
    required this.animation,
  });
  final StatusMessage status;
  final String message;
  final Animation<double> animation;

  @override
  State<AlertMessageWidget> createState() => _AlertMessageWidgetState();
}

class _AlertMessageWidgetState extends State<AlertMessageWidget> {
  @override
  Widget build(BuildContext context) {
    late Color color;
    late String text;
    switch (widget.status) {
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
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: widget.animation,
          curve: Curves.bounceIn,
          reverseCurve: Curves.bounceOut)),
      child: Card(
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Icon(
                Icons.check_circle,
                color: color,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text),
                  Text(
                    widget.message,
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      context.read<AlertMessageCubit>().removeMessage(
                            widget.message,
                            widget.status,
                          );
                    },
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
