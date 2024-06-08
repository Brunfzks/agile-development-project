import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<UserException, UserModel>> login(ParamsLogin params);
  Future<Either<UserException, bool>> registration(ParamsRegistration params);
}
