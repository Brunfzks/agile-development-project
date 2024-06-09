import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.initial());

  void getUser(UserModel user) {
    emit(state.copyWith(user: user));
  }

  Future<void> showMessage(String message, StatusMessage status) async {
    emit(state.copyWith(
      notificationShow: true,
      notificarionMessage: message,
      notificationStatus: status,
    ));

    await Future.delayed(const Duration(seconds: 5));

    emit(state.copyWith(
      notificationShow: false,
    ));
  }

  void removeMessage() {
    emit(state.copyWith(
      notificationShow: false,
    ));
  }
}
