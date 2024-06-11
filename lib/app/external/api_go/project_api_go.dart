import 'dart:convert';

import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/datasource/project_datasource.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/usescases/project/create_project_usecase.dart';
import 'package:agile_development_project/app/usescases/project/delete_project_usescase.dart';
import 'package:agile_development_project/app/usescases/project/get_projects_usecase.dart';
import 'package:agile_development_project/app/usescases/project/update_project_usecase.dart';
import 'package:dio/dio.dart';

class ProjectApiGo implements ProjectDatasource {
  Dio dio;
  ProjectApiGo({
    required this.dio,
  });

  @override
  Future<List<ProjectModel>> getProjects(ParamsGetProjects params) async {
    try {
      var result = await dio.get(
        '${ConstParameters.getUrlBase(isProtected: true)}projects/${params.idUser}',
      );

      var jsonA = json.decode(result.data);
      List<ProjectModel> listProject = [];

      for (var project in jsonA) {
        listProject.add(ProjectModel.fromMap(project));
      }

      return listProject;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw ProjectsExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw ProjectsExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw ProjectsExeption(message: e.toString());
    }
  }

  @override
  Future<ProjectModel> insertProjects(ParamsCreateProjects params) async {
    try {
      var result = await dio.post(
        '${ConstParameters.getUrlBase(isProtected: true)}projects',
        data: params.project.toJson(),
      );
      return ProjectModel.fromMap(json.decode(result.data));
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw ProjectsExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw ProjectsExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw ProjectsExeption(message: e.toString());
    }
  }

  @override
  Future<bool> deleteProjects(ParamsDeleteProjects params) async {
    try {
      await dio.delete(
        '${ConstParameters.getUrlBase(isProtected: true)}projects/${params.idProject}',
      );
      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw ProjectsExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw ProjectsExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw ProjectsExeption(message: e.toString());
    }
  }

  @override
  Future<bool> updateProjects(ParamsUpdateProjects params) async {
    try {
      await dio.put(
        '${ConstParameters.getUrlBase(isProtected: true)}projects',
        data: params.project.toJson(),
      );
      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw ProjectsExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw ProjectsExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw ProjectsExeption(message: e.toString());
    }
  }
}
