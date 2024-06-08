import 'package:agile_development_project/app/domain/entities/credentials.dart';
import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/external/api_go/user_api_go.dart';
import 'package:agile_development_project/app/external/data_mock/user_datamock.dart';
import 'package:agile_development_project/app/infra/model/credentials_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/infra/repositories/user_repository_impl.dart';
import 'package:agile_development_project/app/presenter/login/cubit/login_state.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  void login(String email, String password) async {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );

    final result = await LoginUsesCases(
      repository: UserRepositoryImpl(
        datasource: UserApiGo(dio: Dio()),
      ),
    ).call(
      ParamsLogin(
        credentials: CredentialsModel(email: email, password: password),
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

  void registration(String email, String password, String user) async {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );

    final result = await RegistrationUsesCases(
      repository: UserRepositoryImpl(
        datasource: UserApiGo(dio: Dio()),
      ),
    ).call(
      ParamsRegistration(
        user:
            UserModel(email: email, password: password, idUser: 0, user: user),
      ),
    );

    result.fold(
        (UserException exception) => {
              if (exception.message == 'USUARIO JA CADASTRADO')
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
        (bool user) => {
              emit(state.copyWith(
                status: LoginStatus.initial,
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
