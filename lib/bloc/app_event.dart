part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class ChatGenerateNewTextMsgEvent extends AppEvent {
  final String inputMessage;

  ChatGenerateNewTextMsgEvent({required this.inputMessage});
}
