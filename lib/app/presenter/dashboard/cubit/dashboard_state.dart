part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, completed, error, loading }

class DashboardState extends Equatable {
  const DashboardState({
    required this.status,
    required this.error,
    required this.project,
    required this.projectsUsers,
  });

  final DashboardStatus status;
  final String error;
  final ProjectModel project;
  final List<ProjectUserModel> projectsUsers;

  factory DashboardState.initial() {
    return DashboardState(
      projectsUsers: const [],
      error: '',
      status: DashboardStatus.initial,
      project: ProjectModel(
        tasks: [],
        description: '',
        feedback: '',
        idProject: 0,
        projectUsers: [],
        statusProjectTask: [],
      ),
    );
  }

  DashboardState copyWith({
    DashboardStatus? status,
    String? error,
    ProjectModel? project,
    List<ProjectUserModel>? projectsUsers,
  }) {
    return DashboardState(
      status: status ?? this.status,
      error: error ?? this.error,
      project: project ?? this.project,
      projectsUsers: projectsUsers ?? this.projectsUsers,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, error, project, projectsUsers];
}
