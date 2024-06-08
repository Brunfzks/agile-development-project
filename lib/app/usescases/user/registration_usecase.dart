import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/user_repository.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IRegistration {
  Future<Either<UserException, bool>> call(ParamsRegistration params);
}

class RegistrationUsesCases implements IRegistration {
  UserRepository repository;
  RegistrationUsesCases({
    required this.repository,
  });

  @override
  Future<Either<UserException, bool>> call(ParamsRegistration params) async {
    if (params.user.email.isEmpty) {
      return left(UserException(message: 'EMPTY LOGIN'));
    }
    if (params.user.password.isEmpty) {
      return left(UserException(message: 'EMPTY PASSWORD'));
    }
    if (params.user.user.isEmpty) {
      return left(UserException(message: 'EMPTY USER'));
    }
    return await repository.registration(params);
  }
}

class ParamsRegistration {
  final UserModel user;
  ParamsRegistration({
    required this.user,
  });
}
