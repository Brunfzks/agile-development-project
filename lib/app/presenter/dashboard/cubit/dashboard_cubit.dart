import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:agile_development_project/app/infra/repositories/projectuser_repository_impl.dart';
import 'package:agile_development_project/app/infra/repositories/status_repository_impl.dart';
import 'package:agile_development_project/app/usescases/projectUser/delete_projectuser_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/get_users_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/insert_projectuser_usescase.dart';
import 'package:agile_development_project/app/usescases/status/change_order_usecase.dart';
import 'package:agile_development_project/app/usescases/status/delete_status_usecase.dart';
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
  final ProjectUserRepositoryImpl _projectuserRepositoryImpl =
      GetIt.I<ProjectUserRepositoryImpl>();

  List<AppFlowyGroupData> returnGroupData() {
    List<AppFlowyGroupData> groups = [];
    for (var statusProjectTask in state.project.statusProjectTask) {
      groups.add(AppFlowyGroupData(
          id: statusProjectTask.idStatusProjectTask.toString(),
          name: statusProjectTask.status));
    }
    return groups;
  }

  void moveGroup(List<String> listids) async {
    List<StatusProjectTaskModel> tasks = [];
    for (var index = 0; index < listids.length; index++) {
      tasks.add(state.project.statusProjectTask.firstWhere(
          (value) => value.idStatusProjectTask == int.parse(listids[index])));
      tasks[index] = StatusProjectTaskModel(
          idProject: tasks[index].idProject,
          idStatusProjectTask: tasks[index].idStatusProjectTask,
          status: tasks[index].status,
          ordem: index);
    }

    state.project.statusProjectTask.clear();
    state.project.statusProjectTask.addAll(tasks);

    emit(
      state.copyWith(
        project: state.project,
        status: DashboardStatus.loading,
      ),
    );

    final result = await ChangeStatusOrder(
      repository: _statusRepositoryImpl,
    ).call(
      ParamsChangeStatusOrder(status: state.project.statusProjectTask),
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
    }, (bool value) {
      emit(state.copyWith(
        status: DashboardStatus.completed,
      ));
    });
  }

  void getUsers() async {
    emit(
      state.copyWith(status: DashboardStatus.loading),
    );
    final result = await GetProjectUsers(
      repository: _projectuserRepositoryImpl,
    ).call(
      ParamsGetProjectUser(),
    );

    result.fold((ProjectUsersExeption exception) {
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
    }, (List<ProjectUserModel> projectUsers) {
      emit(state.copyWith(
        projectsUsers: projectUsers,
        status: DashboardStatus.completed,
      ));
    });
  }

  void getProject(ProjectModel project) {
    emit(state.copyWith(project: project));
  }

  Future<bool> insertProjectuser(ProjectUserModel projecuser) async {
    var retorno = false;
    emit(
      state.copyWith(status: DashboardStatus.loading),
    );
    final result = await InsertProjectUsers(
      repository: _projectuserRepositoryImpl,
    ).call(
      ParamsInsertProjectUser(projectUserModel: projecuser),
    );

    result.fold((ProjectUsersExeption exception) {
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
    }, (ProjectUserModel projectUser) {
      state.project.projectUsers.add(projectUser);
      emit(state.copyWith(
        project: state.project,
        status: DashboardStatus.completed,
      ));
      retorno = true;
    });
    return retorno;
  }

  Future<bool> deleteProjectuser(ProjectUserModel projecuser) async {
    var retorno = false;
    emit(
      state.copyWith(status: DashboardStatus.loading),
    );
    final result = await DeleteProjectUsers(
      repository: _projectuserRepositoryImpl,
    ).call(
      ParamsDeleteProjectUser(projectUserModel: projecuser),
    );

    result.fold((ProjectUsersExeption exception) {
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
    }, (bool status) {
      state.project.projectUsers.remove(projecuser);
      emit(state.copyWith(
        project: state.project,
        status: DashboardStatus.completed,
      ));
      retorno = true;
    });
    return retorno;
  }

  Future<bool> deleteStatus(StatusProjectTaskModel statusTask) async {
    var retorno = false;
    emit(
      state.copyWith(status: DashboardStatus.loading),
    );
    final result = await DeleteStatus(
      repository: _statusRepositoryImpl,
    ).call(
      ParamsDeleteStatus(status: statusTask),
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
    }, (bool status) {
      state.project.statusProjectTask.remove(statusTask);
      emit(state.copyWith(
        project: state.project,
        status: DashboardStatus.completed,
      ));
      retorno = true;
    });
    return retorno;
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
              ordem: state.project.statusProjectTask.length,
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
