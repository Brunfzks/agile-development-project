import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';

abstract class UserDataSource {
  Future<UserModel> login(ParamsLogin params);
  Future<UserModel> registration(ParamsRegistration params);
}
