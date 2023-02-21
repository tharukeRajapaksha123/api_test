import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionModel {
  final String? id;
  final int answerIndex;
  final String examType;
  final List answers;
  final String question;
  final String? moduleId;
  final String? chapterId;
  QuestionModel({
    this.id,
    required this.examType,
    required this.answers,
    required this.answerIndex,
    required this.question,
    this.moduleId,
    this.chapterId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'examType': examType,
      'answers': answers,
      'question': question,
      'moduleId': moduleId,
      'chapterId': chapterId,
      "answerIndex": answerIndex,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] ?? "",
      examType: map['examType'] ?? "",
      answers: map['answers'] ?? [],
      answerIndex: map["answer_index"] ?? 0,
      question: map['question'] ?? "-",
      moduleId: map['moduleId'] != null ? map['moduleId'] as String : null,
      chapterId: map['chapterId'] != null ? map['chapterId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
