import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/user_repository.dart';
import 'package:agile_development_project/app/infra/model/credentials_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class ILogin {
  Future<Either<UserException, UserModel>> call(ParamsLogin params);
}

class LoginUsesCases implements ILogin {
  UserRepository repository;
  LoginUsesCases({
    required this.repository,
  });

  @override
  Future<Either<UserException, UserModel>> call(ParamsLogin params) async {
    if (params.credentials.email.isEmpty) {
      return left(UserException(message: 'EMPTY LOGIN'));
    }
    if (params.credentials.password.isEmpty) {
      return left(UserException(message: 'EMPTY PASSWORD'));
    }
    return await repository.login(params);
  }
}

class ParamsLogin {
  final CredentialsModel credentials;
  ParamsLogin({
    required this.credentials,
  });
}
