import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/credentials_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/infra/repositories/user_repository_impl.dart';
import 'package:agile_development_project/app/presenter/login/cubit/login_state.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  final UserRepositoryImpl userRepositoryImpl = GetIt.I<UserRepositoryImpl>();

  void login(String email, String password) async {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );

    final result = await LoginUsesCases(
      repository: userRepositoryImpl,
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
            }, (UserModel user) {
      emit(state.copyWith(
        status: LoginStatus.completed,
        user: user,
      ));
    });
  }

  void registration(String email, String password, String user) async {
    emit(
      state.copyWith(status: LoginStatus.loading),
    );

    final result = await RegistrationUsesCases(
      repository: userRepositoryImpl,
    ).call(
      ParamsRegistration(
        user: UserModel(
          email: email,
          password: password,
          idUser: 0,
          user: user,
        ),
      ),
    );

    result.fold(
        (UserException exception) => {
              if (exception.message == 'USUARIO JA CADASTRADO')
                {
                  emit(state.copyWith(
                    status: LoginStatus.error,
                    error: exception.message,
                    screen: LoginScreen.login,
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
        (bool user) => {login(email, password)});
  }

  void changeRegistrationScreen(LoginScreen tela) {
    switch (tela) {
      case LoginScreen.login:
        emit(state.copyWith(screen: LoginScreen.login));
        break;
      case LoginScreen.registration:
        emit(state.copyWith(screen: LoginScreen.registration));
        break;
      default:
        emit(state.copyWith(screen: LoginScreen.login));
        break;
    }
  }
}
