import 'dart:convert';

import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/datasource/projectuser_datasource.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/usescases/projectUser/delete_projectuser_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/get_users_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/insert_projectuser_usescase.dart';
import 'package:dio/dio.dart';

class ProjectuserApiGo implements ProjectuserDataSource {
  Dio dio;
  ProjectuserApiGo({
    required this.dio,
  });

  @override
  Future<List<ProjectUserModel>> getProjectUser(
      ParamsGetProjectUser params) async {
    try {
      var result = await dio.get(
        '${ConstParameters.getUrlBase(isProtected: true)}projectuser',
      );
      var jsonA = json.decode(result.data);
      List<ProjectUserModel> listProject = [];

      for (var project in jsonA) {
        listProject.add(ProjectUserModel.fromMap(project));
      }
      return listProject;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw ProjectUsersExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw ProjectUsersExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw ProjectUsersExeption(message: e.toString());
    }
  }

  @override
  Future<ProjectUserModel> insertProjectUser(
      ParamsInsertProjectUser params) async {
    try {
      var result = await dio.post(
          '${ConstParameters.getUrlBase(isProtected: true)}projectuser',
          data: params.projectUserModel.toJson());

      return ProjectUserModel.fromJson(result.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw ProjectUsersExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw ProjectUsersExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw ProjectUsersExeption(message: e.toString());
    }
  }

  @override
  Future<bool> deleteProjectUser(ParamsDeleteProjectUser params) async {
    try {
      await dio.delete(
        '${ConstParameters.getUrlBase(isProtected: true)}projectuser/${params.projectUserModel.idProjectUser}',
      );

      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw ProjectUsersExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw ProjectUsersExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw ProjectUsersExeption(message: e.toString());
    }
  }
}
