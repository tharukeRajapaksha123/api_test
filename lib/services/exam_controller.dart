import 'dart:convert';
import 'dart:math';

import 'package:api_test/constants.dart';
import 'package:api_test/models/exam_model.dart';
import 'package:http/http.dart' as http;

enum EXAMTYPE { exam, assessment, quiz }

class ExamController {
  String get _baseUrl => baseUrl;

  Future<List<ExamModel>> getExams(EXAMTYPE examtype) async {
    List<ExamModel> exams = [];
    Uri uri = examtype == EXAMTYPE.exam
        ? Uri.parse("$_baseUrl/exam-controller")
        : examtype == EXAMTYPE.assessment
            ? Uri.parse("$_baseUrl/assessment-controller")
            : Uri.parse("$_baseUrl/quiz-controller");
    await http.get(uri).then((value) {
      final body = jsonDecode(value.body);
      String keyWord = examtype == EXAMTYPE.assessment
          ? "assessments"
          : examtype == EXAMTYPE.exam
              ? "exams"
              : "quizzes";
      for (Map<String, dynamic> data in body[keyWord]) {
        ExamModel examModel = ExamModel.fromMap(data);
        exams.add(examModel);
      }
    });
    return exams;
  }

  Future<void> updateExam(
      EXAMTYPE examtype, ExamModel examModel, String id) async {
    try {
      Uri uri = examtype == EXAMTYPE.exam
          ? Uri.parse("$_baseUrl/exam-controller/$id")
          : examtype == EXAMTYPE.assessment
              ? Uri.parse("$_baseUrl/assessment-controller/$id")
              : Uri.parse("$_baseUrl/quiz-controller/$id");

      await http.put(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "data": {
            "name": examModel.name,
            "questions": [],
            "questions_ids": examModel.questions_ids
          }
        }),
      );
    } catch (err) {
      print("Update exam failed $err");
    }
  }

  Future<void> createExam(EXAMTYPE examtype, ExamModel examModel) async {
    try {
      Uri uri = examtype == EXAMTYPE.exam
          ? Uri.parse("$_baseUrl/exam-controller")
          : examtype == EXAMTYPE.assessment
              ? Uri.parse("$_baseUrl/assessment-controller")
              : Uri.parse("$_baseUrl/quiz-controller");

      final res = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": examModel.name,
          "questions": [],
          "questions_ids": examModel.questions_ids
        }),
      );
      print(res.statusCode);
    } catch (err) {
      print("Update exam failed $err");
    }
  }

  Future<void> deleteExam(
    EXAMTYPE examtype,
    String id,
  ) async {
    try {
      Uri uri = examtype == EXAMTYPE.exam
          ? Uri.parse("$_baseUrl/exam-controller/$id")
          : examtype == EXAMTYPE.assessment
              ? Uri.parse("$_baseUrl/assessment-controller/$id")
              : Uri.parse("$_baseUrl/quiz-controller/$id");
      await http.delete(uri);
    } catch (err) {
      print("Update exam failed $err");
    }
  }
}
