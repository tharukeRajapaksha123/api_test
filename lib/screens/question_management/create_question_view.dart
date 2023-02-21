// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/screens/question_management/question_management_view.dart';
import 'package:api_test/services/question_controller.dart';
import 'package:flutter/material.dart';

import 'package:api_test/models/question_model.dart';
import 'package:api_test/widgets/input_fileld.dart';
import 'package:api_test/widgets/main_button.dart';

class CreateQuestionView extends StatefulWidget {
  final QuestionModel? questionModel;
  const CreateQuestionView({
    Key? key,
    this.questionModel,
  }) : super(key: key);

  @override
  State<CreateQuestionView> createState() => _CreateQuestionViewState();
}

class _CreateQuestionViewState extends State<CreateQuestionView> {
  List<String> answers = [];

  final TextEditingController question = TextEditingController();
  final TextEditingController answer = TextEditingController();
  final TextEditingController answerIndex = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.questionModel != null) {
      setState(() {
        question.text = widget.questionModel!.question;
        answerIndex.text = widget.questionModel!.answerIndex.toString();
        answers =
            widget.questionModel!.answers.map((e) => e.toString()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Question"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(controller: question, hintText: "Question"),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Add Answers"),
            ),
            InputField(controller: answer, hintText: "Answer"),
            MainButton(
                title: "Add Answer",
                onPressed: () {
                  if (answer.text.isNotEmpty) {
                    setState(() {
                      answers.add(answer.text);
                      answer.clear();
                    });
                  }
                }),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: answers
                  .map((e) => ListTile(
                        title: Text(
                          e,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              answers.remove(e);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            InputField(
                controller: answerIndex, hintText: "Correct Answer Index"),
            MainButton(
              title: widget.questionModel != null
                  ? "Update Question"
                  : "Create Question",
              onPressed: () async {
                QuestionModel questionModel = QuestionModel(
                  examType: "text",
                  answers: answers,
                  answerIndex: int.parse(answerIndex.text),
                  question: question.text,
                );
                widget.questionModel == null
                    ? await QuestionController()
                        .createUpdateQuestion(null, questionModel)
                    : await QuestionController().createUpdateQuestion(
                        widget.questionModel!.id!, questionModel);

                // ignore: use_build_context_synchronously
                NavigateHelper().navigator(context, const QuestionManagement());
              },
            ),
          ],
        ),
      ),
    );
  }
}
