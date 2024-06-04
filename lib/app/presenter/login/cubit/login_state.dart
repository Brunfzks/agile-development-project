import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus { initial, completed, error, loading, registration }

class LoginState extends Equatable {
  final LoginStatus status;
  final String error;
  final UserModel user;

  factory LoginState.initial() {
    return LoginState(
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
    required this.status,
    required this.error,
    required this.user,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? error,
    UserModel? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, error, user];
}
