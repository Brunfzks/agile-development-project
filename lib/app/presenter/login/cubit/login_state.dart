import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus { initial, completed, error, loading }

enum LoginScreen { registration, login }

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginScreen screen;
  final String error;
  final UserModel user;

  factory LoginState.initial() {
    return LoginState(
      screen: LoginScreen.login,
      status: LoginStatus.initial,
      error: '',
      user: UserModel(
        user: '',
        password: '',
        idUser: 0,
        email: '',
      ),
    );
  }

  const LoginState({
    required this.screen,
    required this.status,
    required this.error,
    required this.user,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? error,
    UserModel? user,
    LoginScreen? screen,
  }) {
    return LoginState(
      screen: screen ?? this.screen,
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, error, user, screen];
}
