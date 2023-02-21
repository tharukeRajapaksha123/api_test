import 'dart:convert';

import 'package:api_test/constants.dart';
import 'package:api_test/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuestionController {
  String get _baseUrl => "$baseUrl/question-controller";

  Future<List<QuestionModel>> getQuestions() async {
    List<QuestionModel> questions = [];
    try {
      await http.get(Uri.parse(_baseUrl)).then((value) {
        final body = jsonDecode(value.body);

        for (Map<String, dynamic> data in body["questions"]) {
          try {
            QuestionModel questionModel = QuestionModel.fromMap(data);
            questions.add(questionModel);
          } catch (e) {
            print("er $e");
          }
        }
      });

      return questions;
    } catch (e) {
      debugPrint("get questions failed $e");
      return [];
    }
  }

  Future<void> deleteQuestion(String id) async {
    try {
      await http.delete(Uri.parse("$_baseUrl/$id"));
    } catch (e) {
      debugPrint("delete question failed $e");
    }
  }

  Future<void> createUpdateQuestion(
      String? id, QuestionModel questionModel) async {
    try {
      if (id == null) {
        final res = await http.post(
          Uri.parse(_baseUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
            {
              "answerIndex": questionModel.answerIndex,
              "examType": "text",
              "answers": questionModel.answers,
              "question": questionModel.question,
              "moduleId": null,
              "chapterId": null
            },
          ),
        );
        print(res.statusCode);
      } else {
        final res = await http.put(
          Uri.parse(
            "$_baseUrl/$id",
          ),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "data": {
              "answerIndex": questionModel.answerIndex,
              "examType": "text",
              "answers": questionModel.answers,
              "question": questionModel.question,
              "moduleId": null,
              "chapterId": null
            },
          }),
        );
        print(res.statusCode);
      }
    } catch (e) {
      debugPrint("create update question failed $e");
    }
  }
}
