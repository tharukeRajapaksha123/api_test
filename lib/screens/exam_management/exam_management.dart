// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/models/exam_model.dart';
import 'package:api_test/screens/exam_management/create_exam_view.dart';
import 'package:api_test/widgets/main_loader.dart';
import 'package:flutter/material.dart';

import 'package:api_test/services/exam_controller.dart';

class ExamManagement extends StatefulWidget {
  final EXAMTYPE examtype;
  const ExamManagement({
    Key? key,
    required this.examtype,
  }) : super(key: key);

  @override
  State<ExamManagement> createState() => _ExamManagementState();
}

class _ExamManagementState extends State<ExamManagement> {
  List<ExamModel> exams = [];
  bool shouldLoad = false;
  Future<void> setData() async {
    exams.clear();
    setState(() {
      shouldLoad = !shouldLoad;
    });
    List<ExamModel> li = await ExamController().getExams(widget.examtype);

    setState(() {
      exams = li;
      shouldLoad = !shouldLoad;
    });
  }

  @override
  void initState() {
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigateHelper().navigator(
              context,
              CreateExamView(
                examtype: widget.examtype,
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          widget.examtype == EXAMTYPE.assessment
              ? "Assesment Management"
              : widget.examtype == EXAMTYPE.quiz
                  ? "Quiz Management"
                  : "Exam Management",
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8),
        child: shouldLoad
            ? const MainLoader()
            : ListView.builder(
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  ExamModel examModel = exams[index];
                  return ListTile(
                    title: Text(
                      examModel.name,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            NavigateHelper().navigator(
                                context,
                                CreateExamView(
                                  examtype: widget.examtype,
                                  examModel: examModel,
                                ));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            ExamController()
                                .deleteExam(widget.examtype, examModel.id!)
                                .then((value) => setData());
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
