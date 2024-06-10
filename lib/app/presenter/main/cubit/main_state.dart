part of 'main_cubit.dart';

enum MainStatus { initial, completed, error, loading }

class MainState extends Equatable {
  const MainState({
    required this.status,
    required this.user,
    required this.projects,
    required this.error,
    required this.notificationShow,
    required this.alertMessage,
  });

  final MainStatus status;
  final UserModel user;
  final List<ProjectModel> projects;
  final String error;
  final bool notificationShow;
  final AlertMessage alertMessage;

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
        alertMessage: AlertMessage(
          message: '',
          status: StatusMessage.success,
        ));
  }

  MainState copyWith({
    MainStatus? status,
    UserModel? user,
    List<ProjectModel>? projects,
    String? error,
    bool? notificationShow,
    AlertMessage? alertMessage,
  }) {
    return MainState(
      status: status ?? this.status,
      user: user ?? this.user,
      projects: projects ?? this.projects,
      error: error ?? this.error,
      notificationShow: notificationShow ?? this.notificationShow,
      alertMessage: alertMessage ?? this.alertMessage,
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
      alertMessage,
    ];
  }
}
