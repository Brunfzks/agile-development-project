part of 'alert_message_cubit.dart';

class AlertMessageState extends Equatable {
  AlertMessageState({
    required this.messages,
  });

  final List<AlertMessage> messages;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  factory AlertMessageState.initial() {
    return AlertMessageState(messages: const []);
  }

  AlertMessageState copyWith({
    List<AlertMessage>? messages,
  }) {
    return AlertMessageState(
      messages: messages ?? this.messages,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [messages];
}
