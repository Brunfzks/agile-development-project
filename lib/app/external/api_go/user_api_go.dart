// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/usescases/user/login_usecase.dart';
import 'package:agile_development_project/app/usescases/user/registration_usecase.dart';
import 'package:dio/dio.dart';

import 'package:agile_development_project/app/infra/datasource/user_datasource.dart';

class UserApiGo implements UserDataSource {
  Dio dio;
  UserApiGo({
    required this.dio,
  });

  @override
  Future<UserModel> login(ParamsLogin params) async {
    try {
      var result = await Dio().post('${ConstParameters.getUrlBase()}login',
          data: params.credentials.toJson());
      var json = result.data;
      return UserModel.fromJson(json);
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw UserException(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw UserException(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw UserException(message: e.toString());
    }
  }

  @override
  Future<bool> registration(ParamsRegistration params) async {
    try {
      await Dio().post('${ConstParameters.getUrlBase()}user',
          data: params.user.toJson());
      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw UserException(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 409) {
        throw UserException(message: 'USUARIO JA CADASTRADO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw UserException(message: e.toString());
    }
  }
}
