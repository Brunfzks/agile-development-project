import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/datasource/task_datasource.dart';
import 'package:agile_development_project/app/usescases/task/update_task_usecase.dart';
import 'package:dio/dio.dart';

class TaskApiGo implements TaskDataSource {
  Dio dio;
  TaskApiGo({
    required this.dio,
  });

  @override
  Future<bool> updateTask(ParamsUpdateTask params) async {
    try {
      await dio.put('${ConstParameters.getUrlBase(isProtected: true)}task',
          data: params.task.toJson());

      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw TaskExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw TaskExeption(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw TaskExeption(message: e.toString());
    }
  }
}
