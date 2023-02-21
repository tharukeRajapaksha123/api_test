// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/models/question_model.dart';
import 'package:api_test/screens/exam_management/exam_management.dart';
import 'package:api_test/services/question_controller.dart';
import 'package:api_test/widgets/input_fileld.dart';
import 'package:api_test/widgets/main_button.dart';
import 'package:api_test/widgets/main_loader.dart';
import 'package:flutter/material.dart';

import 'package:api_test/models/exam_model.dart';
import 'package:api_test/services/exam_controller.dart';

class CreateExamView extends StatefulWidget {
  final EXAMTYPE examtype;
  final ExamModel? examModel;
  const CreateExamView({
    Key? key,
    required this.examtype,
    this.examModel,
  }) : super(key: key);

  @override
  State<CreateExamView> createState() => _CreateExamViewState();
}

class _CreateExamViewState extends State<CreateExamView> {
  String get keyWord => widget.examtype == EXAMTYPE.assessment
      ? "assessment"
      : widget.examtype == EXAMTYPE.exam
          ? "exam"
          : "quiz";

  final TextEditingController name = TextEditingController();
  List selectedQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.examModel != null) {
      setState(() {
        name.text = widget.examModel!.name;
        selectedQuestions = widget.examModel!.questions_ids;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.examModel == null ? "Create $keyWord" : "Update $keyWord"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(controller: name, hintText: "Name"),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Add Questions for the $keyWord",
              style: const TextStyle(fontSize: 18),
            ),
            FutureBuilder(
              future: QuestionController().getQuestions(),
              builder: (context, AsyncSnapshot<List<QuestionModel>> questions) {
                return !questions.hasData
                    ? const MainLoader()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: questions.data!.length,
                        itemBuilder: (context, index) {
                          QuestionModel questionModel = questions.data![index];
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color:
                                  selectedQuestions.contains(questionModel.id)
                                      ? Colors.purple
                                      : Colors.grey,
                            )),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  selectedQuestions.add(questionModel.id);
                                });
                              },
                              onLongPress: () {
                                setState(() {
                                  selectedQuestions.remove(questionModel.id);
                                });
                              },
                              title: Text(
                                questionModel.question,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
            MainButton(
              title: widget.examModel != null
                  ? "Update $keyWord"
                  : "Create $keyWord",
              onPressed: () async {
                ExamModel examModel = ExamModel(
                    id: widget.examModel != null ? widget.examModel!.id : null,
                    questions_ids: selectedQuestions,
                    questions: [],
                    name: name.text);

                widget.examModel != null
                    ? await ExamController().updateExam(
                        widget.examtype,
                        examModel,
                        examModel.id!,
                      )
                    : await ExamController()
                        .createExam(widget.examtype, examModel);

                // ignore: use_build_context_synchronously
                NavigateHelper().navigator(
                    context,
                    ExamManagement(
                      examtype: widget.examtype,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
