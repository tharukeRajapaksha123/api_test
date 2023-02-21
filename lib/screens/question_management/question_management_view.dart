import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/models/question_model.dart';
import 'package:api_test/screens/question_management/create_question_view.dart';
import 'package:api_test/services/question_controller.dart';
import 'package:api_test/widgets/main_loader.dart';
import 'package:flutter/material.dart';

class QuestionManagement extends StatefulWidget {
  const QuestionManagement({super.key});

  @override
  State<QuestionManagement> createState() => _QuestionManagementState();
}

class _QuestionManagementState extends State<QuestionManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Question Management",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigateHelper().navigator(context, CreateQuestionView());
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: QuestionController().getQuestions(),
          builder: (context, AsyncSnapshot<List<QuestionModel>> snapshot) {
            return !snapshot.hasData
                ? const MainLoader()
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      QuestionModel questionModel = snapshot.data![index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Question: ${questionModel.question}",
                            ),
                            Text(
                              "Correct Answer: ${questionModel.answerIndex}",
                            ),
                            const Text("Answers"),
                            const Divider(),
                            ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: questionModel.answers
                                  .map((e) => Text(
                                        e.toString(),
                                      ))
                                  .toList(),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    NavigateHelper().navigator(
                                        context,
                                        CreateQuestionView(
                                          questionModel: questionModel,
                                        ));
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await QuestionController()
                                        .deleteQuestion(questionModel.id!);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
