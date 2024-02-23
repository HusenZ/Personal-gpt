import 'package:dio/dio.dart';
import 'package:flutter_gemini_app/models/chat_msg_model.dart';
import 'package:flutter_gemini_app/utils/constants.dart';

// ctw4111
class ChatRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatModel> previoiusMessages) async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$apiKey',
        data: {
          "contents": previoiusMessages.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 0.9,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 2048,
            "stopSequences": []
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        },
      );
      print(response);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      } else {
        return "something went wrong";
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
