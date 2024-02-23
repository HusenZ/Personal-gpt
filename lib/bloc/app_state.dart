part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class ChatSuccessEmpty extends AppState {
  ChatSuccessEmpty();
}

class ChatSuccessState extends AppState {
  final List<ChatModel> message;

  ChatSuccessState({required this.message});
}
