import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:agile_development_project/app/infra/repositories/status_repository_impl.dart';
import 'package:agile_development_project/app/usescases/status/insert_status_usecase.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  final StatusRepositoryImpl _statusRepositoryImpl =
      GetIt.I<StatusRepositoryImpl>();

  List<AppFlowyGroupData> returnGroupData() {
    List<AppFlowyGroupData> groups = [];
    for (var statusProjectTask in state.project.statusProjectTask) {
      groups.add(AppFlowyGroupData(
          id: statusProjectTask.idStatusProjectTask.toString(),
          name: statusProjectTask.status));
    }
    return groups;
  }

  void getProject(ProjectModel project) {
    emit(state.copyWith(project: project));
  }

  Future<void> createStatus(String description) async {
    emit(
      state.copyWith(status: DashboardStatus.loading),
    );
    final result = await CreateStatusUsesCases(
      repository: _statusRepositoryImpl,
    ).call(
      ParamsCreateStatus(
          status: StatusProjectTaskModel(
              idProject: state.project.idProject,
              idStatusProjectTask: 0,
              status: description)),
    );

    result.fold((StatusExeption exception) {
      if (exception.message == 'USUARIO INVALIDO') {
        emit(state.copyWith(
          status: DashboardStatus.error,
          error: exception.message,
        ));
      } else {
        emit(state.copyWith(
          status: DashboardStatus.error,
          error: exception.message,
        ));
      }
    }, (StatusProjectTaskModel status) {
      state.project.statusProjectTask.add(status);
      emit(state.copyWith(
        project: state.project,
        status: DashboardStatus.completed,
      ));
    });
  }
}
