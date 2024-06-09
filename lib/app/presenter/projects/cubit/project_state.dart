part of 'project_cubit.dart';

enum ProjectStatus { initial, completed, error, loading }

class ProjectState extends Equatable {
  const ProjectState({
    required this.status,
    required this.projects,
    required this.error,
  });

  final ProjectStatus status;
  final List<ProjectModel> projects;
  final String error;

  factory ProjectState.initial() {
    return const ProjectState(
      error: '',
      status: ProjectStatus.initial,
      projects: [],
    );
  }

  ProjectState copyWith({
    ProjectStatus? status,
    List<ProjectModel>? projects,
    String? error,
  }) {
    return ProjectState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, projects, error];

  @override
  bool get stringify => true;
}
