part of 'main_cubit.dart';

enum MainStatus { initial, completed, error, loading }

class MainState extends Equatable {
  const MainState({
    required this.status,
    required this.user,
    required this.projects,
    required this.error,
    required this.notificationShow,
    required this.notificationStatus,
    required this.notificarionMessage,
  });

  final MainStatus status;
  final UserModel user;
  final List<ProjectModel> projects;
  final String error;
  final bool notificationShow;
  final StatusMessage notificationStatus;
  final String notificarionMessage;

  factory MainState.initial() {
    return MainState(
      error: '',
      status: MainStatus.initial,
      projects: const [],
      user: UserModel(
        email: '',
        idUser: 0,
        password: '',
        user: '',
      ),
      notificationShow: false,
      notificationStatus: StatusMessage.success,
      notificarionMessage: '',
    );
  }

  MainState copyWith({
    MainStatus? status,
    UserModel? user,
    List<ProjectModel>? projects,
    String? error,
    bool? notificationShow,
    StatusMessage? notificationStatus,
    String? notificarionMessage,
  }) {
    return MainState(
      status: status ?? this.status,
      user: user ?? this.user,
      projects: projects ?? this.projects,
      error: error ?? this.error,
      notificationShow: notificationShow ?? this.notificationShow,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      notificarionMessage: notificarionMessage ?? this.notificarionMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      status,
      user,
      projects,
      error,
      notificationShow,
      notificationStatus,
      notificarionMessage,
    ];
  }
}
