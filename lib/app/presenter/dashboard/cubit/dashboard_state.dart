part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, completed, error, loading }

class DashboardState extends Equatable {
  const DashboardState({
    required this.status,
    required this.error,
    required this.project,
  });

  final DashboardStatus status;
  final String error;
  final ProjectModel project;

  factory DashboardState.initial() {
    return DashboardState(
      error: '',
      status: DashboardStatus.initial,
      project: ProjectModel(
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
  }) {
    return DashboardState(
      status: status ?? this.status,
      error: error ?? this.error,
      project: project ?? this.project,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, error, project];
}
