import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/user_repository.dart';
import 'package:agile_development_project/app/infra/datasource/user_datasource.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource datasource;
  UserRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<UserException, UserModel>> login(ParamsLogin params) async {
    try {
      final specie = await datasource.login(params);
      return Right(specie);
    } on UserException catch (e) {
      return Left(e);
    } on Exception {
      return left(UserException(message: 'Exception Error'));
    }
  }

  @override
  Future<Either<UserException, UserModel>> registration(
      ParamsRegistration params) async {
    try {
      final specie = await datasource.registration(params);
      return Right(specie);
    } on UserException catch (e) {
      return Left(e);
    } on Exception {
      return left(UserException(message: 'Exception Error'));
    }
  }
}
