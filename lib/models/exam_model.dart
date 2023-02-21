import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExamModel {
  final String? id;
  final List questions_ids;
  final List questions;
  final String name;
  ExamModel({
    this.id,
    required this.questions_ids,
    required this.questions,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id ?? "",
      'questions_ids': questions_ids,
      'questions': questions,
      'name': name,
    };
  }

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      id: map['id'] ?? "",
      questions_ids: map['questions_ids'] ?? [],
      questions: map['questions'] ?? [],
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ExamModel.fromJson(String source) =>
      ExamModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
