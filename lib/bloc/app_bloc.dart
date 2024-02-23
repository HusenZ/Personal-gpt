import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_gemini_app/models/chat_msg_model.dart';
import 'package:flutter_gemini_app/repository/chat_repo.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(ChatSuccessState(message: const [])) {
    on<ChatGenerateNewTextMsgEvent>(chatGenerateNewTextMessageEvent);
  }

  List<ChatModel> messages = [];
  bool generating = false;

  FutureOr<void> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMsgEvent event, Emitter<AppState> emit) async {
    messages.add(
        ChatModel(role: 'user', parts: [ChatParts(text: event.inputMessage)]));
    emit(ChatSuccessState(message: messages));
    generating = true;
    String ans = await ChatRepo.chatTextGenerationRepo(messages);
    messages.add(ChatModel(role: 'model', parts: [ChatParts(text: ans)]));
    generating = false;
    emit(ChatSuccessState(message: messages));
    print("ChataSuccessState is emitted");
  }
}
