import 'package:agile_development_project/app/config/const_parameters.dart';
import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/datasource/status_datasource.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:agile_development_project/app/usescases/status/insert_status_usecase.dart';
import 'package:dio/dio.dart';

class StatusApiGo implements StatusDataSource {
  Dio dio;
  StatusApiGo({
    required this.dio,
  });

  @override
  Future<StatusProjectTaskModel> createStatus(ParamsCreateStatus params) async {
    try {
      var result = await dio.post(
          '${ConstParameters.getUrlBase(isProtected: true)}status',
          data: params.status.toJson());

      var json = result.data;
      return StatusProjectTaskModel.fromJson(json);
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw StatusExeption(message: 'Não Encontrado');
      } else if (e.response!.statusCode == 401) {
        throw UserException(message: 'USUARIO INVALIDO');
      } else {
        throw Exception();
      }
    } catch (e) {
      throw UserException(message: e.toString());
    }
  }
}
