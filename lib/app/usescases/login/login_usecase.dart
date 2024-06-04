import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/user_repository.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class ILogin {
  Future<Either<UserException, UserModel>> call(ParamsUser params);
}

class Login implements ILogin {
  UserRepository repository;
  Login({
    required this.repository,
  });

  @override
  Future<Either<UserException, UserModel>> call(ParamsUser params) async {
    if (params.user.user.isEmpty) {
      return left(UserException(message: 'EMPTY LOGIN'));
    }
    if (params.user.password.isEmpty) {
      return left(UserException(message: 'EMPTY PASSWORD'));
    }
    return await repository.login(params);
  }
}

class ParamsUser {
  final UserModel user;
  ParamsUser({
    required this.user,
  });
}
