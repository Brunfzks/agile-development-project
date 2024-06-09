import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/datasource/user_datasource.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';

class UserDataMock implements UserDataSource {
  final UserModel userDataMock = UserModel(
    user: 'teste',
    password: 'teste',
    idUser: 1,
    email: 'teste',
  );

  @override
  Future<UserModel> login(ParamsLogin params) async {
    await Future.delayed(const Duration(seconds: 1));
    if (params.credentials.email == userDataMock.email &&
        params.credentials.password == userDataMock.password) {
      return userDataMock;
    }
    throw UserException(message: 'USUARIO INVALIDO');
  }

  @override
  Future<bool> registration(ParamsRegistration params) async {
    await Future.delayed(const Duration(seconds: 1));
    if (params.user.email != 'erro') {
      return true;
    }
    throw UserException(message: 'USUARIO EXISTENTE');
  }
}
