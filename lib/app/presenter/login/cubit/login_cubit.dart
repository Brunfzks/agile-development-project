import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/external/data_mock/user_datamock.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/infra/repositories/user_repository_impl.dart';
import 'package:agile_development_project/app/presenter/login/cubit/login_state.dart';
import 'package:agile_development_project/app/usescases/login/login_usecase.dart';
import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  void login(String email, String password) async {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );

    final result = await LoginUsesCases(
      repository: UserRepositoryImpl(
        datasource: UserDataMock(),
      ),
    ).call(
      ParamsLogin(
        user: UserModel(email: email, idUser: 0, password: password, user: ''),
      ),
    );

    result.fold(
        (UserException exception) => {
              if (exception.message == 'USUARIO INVALIDO')
                {
                  emit(state.copyWith(
                    status: LoginStatus.error,
                    error: exception.message,
                  ))
                }
              else
                {
                  emit(state.copyWith(
                    status: LoginStatus.error,
                    error: exception.message,
                  ))
                }
            },
        (UserModel user) => {
              emit(state.copyWith(
                status: LoginStatus.completed,
                user: user,
              ))
            });
  }

  void changeRegistrationScreen(LoginStatus tela) {
    switch (tela) {
      case LoginStatus.initial:
        emit(state.copyWith(status: LoginStatus.initial));
        break;
      case LoginStatus.registration:
        emit(state.copyWith(status: LoginStatus.registration));
        break;
      default:
        emit(state.copyWith(status: LoginStatus.initial));
        break;
    }
  }
}
