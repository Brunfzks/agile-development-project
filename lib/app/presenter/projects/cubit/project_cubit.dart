import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/infra/model/user_model.dart';
import 'package:agile_development_project/app/infra/repositories/project_repository_impl.dart';
import 'package:agile_development_project/app/usescases/project/create_project_usecase.dart';
import 'package:agile_development_project/app/usescases/project/get_projects_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectState.initial());

  final ProjectRepositoryImpl _projectRepositoryImpl =
      GetIt.I<ProjectRepositoryImpl>();

  void getProjects(UserModel user) async {
    emit(
      state.copyWith(status: ProjectStatus.loading),
    );

    final result = await GetProjectUsesCases(
      repository: _projectRepositoryImpl,
    ).call(
      ParamsGetProjects(
        idUser: user.idUser,
      ),
    );

    result.fold(
        (ProjectsExeption exception) => {
              if (exception.message == 'USUARIO INVALIDO')
                {
                  emit(state.copyWith(
                    status: ProjectStatus.error,
                    error: exception.message,
                  ))
                }
              else
                {
                  emit(state.copyWith(
                    status: ProjectStatus.error,
                    error: exception.message,
                  ))
                }
            }, (List<ProjectModel> projects) {
      emit(state.copyWith(
        status: ProjectStatus.completed,
        projects: projects,
      ));
    });
  }

  Future<bool> insertProjects(ProjectModel project) async {
    emit(
      state.copyWith(status: ProjectStatus.loading),
    );
    bool retorno = false;

    final result = await CreateProjectUsesCases(
      repository: _projectRepositoryImpl,
    ).call(
      ParamsCreateProjects(
        project: project,
      ),
    );

    result.fold((ProjectsExeption exception) {
      if (exception.message == 'USUARIO INVALIDO') {
        emit(state.copyWith(
          status: ProjectStatus.error,
          error: exception.message,
        ));
      } else {
        emit(state.copyWith(
          status: ProjectStatus.error,
          error: exception.message,
        ));
      }
    }, (ProjectModel project) {
      var projects = state.projects;
      projects.add(project);
      emit(state.copyWith(
        status: ProjectStatus.completed,
        projects: projects,
      ));
      retorno = true;
    });
    return retorno;
  }
}