import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/screens/exam_management/exam_management.dart';
import 'package:api_test/screens/question_management/question_management_view.dart';
import 'package:api_test/services/exam_controller.dart';
import 'package:api_test/widgets/main_button.dart';
import 'package:flutter/material.dart';

import 'screens/user_management/user_management_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DGMentor api test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dg mentor api test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            MainButton(
              title: "User Management",
              onPressed: () {
                NavigateHelper().navigator(
                  context,
                  const UserManagementView(),
                );
              },
            ),
            MainButton(
              title: "Exam Management",
              onPressed: () {
                NavigateHelper().navigator(
                  context,
                  const ExamManagement(
                    examtype: EXAMTYPE.exam,
                  ),
                );
              },
            ),
            MainButton(
              title: "Assessment Management",
              onPressed: () {
                NavigateHelper().navigator(
                  context,
                  const ExamManagement(
                    examtype: EXAMTYPE.assessment,
                  ),
                );
              },
            ),
            MainButton(
              title: "Quiz Management",
              onPressed: () {
                NavigateHelper().navigator(
                  context,
                  const ExamManagement(
                    examtype: EXAMTYPE.quiz,
                  ),
                );
              },
            ),
            MainButton(
              title: "Question Management",
              onPressed: () {
                NavigateHelper().navigator(
                  context,
                  const QuestionManagement(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
