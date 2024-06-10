import 'package:agile_development_project/app/domain/entities/alert_message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'alert_message_state.dart';

class AlertMessageCubit extends Cubit<AlertMessageState> {
  AlertMessageCubit() : super(AlertMessageState.initial());

  Future<void> showMessage(String message, StatusMessage status) async {
    List<AlertMessage> lista = [];
    lista.addAll(state.messages);
    lista.add(AlertMessage(message: message, status: status));
    emit(state.copyWith(messages: lista));
    Future.delayed(const Duration(seconds: 5))
        .then((value) => removeMessage(message, status));
  }

  void removeMessage(String message, StatusMessage status) {
    if (state.messages.isEmpty) {
      return;
    }
    List<AlertMessage> lista = [];
    lista.addAll(state.messages);

    lista.removeAt(0);
    emit(state.copyWith(messages: lista));
  }
}
