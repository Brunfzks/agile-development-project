import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/usescases/login/login_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<UserException, UserModel>> login(ParamsUser params);
}
