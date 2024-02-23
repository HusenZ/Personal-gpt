import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini_app/bloc/app_bloc.dart';
import 'package:flutter_gemini_app/models/chat_msg_model.dart';
import 'package:flutter_gemini_app/utils/app_images.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController chatEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expert Bot"),
      ),
      body: BlocConsumer<AppBloc, AppState>(
        bloc: appBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatModel> messages = (state as ChatSuccessState).message;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messages[index].role == 'user'
                                    ? "Husen"
                                    : "Flutter Expert",
                                style: TextStyle(
                                  color: messages[index].role == 'user'
                                      ? Colors.white
                                      : Colors.blue.shade400,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 10,
                                ),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.amber.withOpacity(0.1),
                                ),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: messages[index].parts.first.text)
                                ])),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (appBloc.generating)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Lottie.asset(AppLottie.loadingLottie),
                        )
                      ],
                    ),
                  Container(
                    height: 120,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: chatEditingController,
                            decoration: InputDecoration(
                              hintText: "Ask me...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        appBloc.generating
                            ? IconButton.outlined(
                                onPressed: () {}, icon: const Icon(Icons.send))
                            : IconButton.filled(
                                onPressed: () {
                                  if (chatEditingController.text.isNotEmpty) {
                                    String text = chatEditingController.text;
                                    chatEditingController.clear();
                                    appBloc.add(
                                      ChatGenerateNewTextMsgEvent(
                                        inputMessage: text,
                                      ),
                                    );
                                    debugPrint(messages.first.parts.first.text);
                                  }
                                  print("button pressed----------");
                                },
                                icon: const Icon(Icons.send),
                                color: Theme.of(context).primaryColorDark,
                              ),
                      ],
                    ),
                  )
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
