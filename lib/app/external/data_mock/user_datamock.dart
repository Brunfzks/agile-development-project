import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/datasource/user_datasource.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';

class UserDataMock implements UserDataSource {
  final UserModel userDataMock =
      UserModel(user: 'teste', password: 'teste', idUser: 1, email: 'teste');

  @override
  Future<UserModel> login(ParamsLogin params) async {
    await Future.delayed(const Duration(seconds: 1));
    if (params.user.email == userDataMock.email &&
        params.user.password == userDataMock.password) {
      return params.user;
    }
    throw UserException(message: 'USUARIO INVALIDO');
  }

  @override
  Future<UserModel> registration(ParamsRegistration params) async {
    await Future.delayed(const Duration(seconds: 1));
    if (params.user.email != 'erro') {
      return UserModel(
          email: params.user.email,
          idUser: 2,
          password: params.user.password,
          user: params.user.user);
    }
    throw UserException(message: 'USUARIO EXISTENTE');
  }
}
