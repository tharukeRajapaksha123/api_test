import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/helpers/scaffold_messanger.dart';
import 'package:api_test/screens/user_management/get_user_by_uname_view.dart';
import 'package:api_test/services/user_management.dart';
import 'package:api_test/widgets/input_fileld.dart';
import 'package:api_test/widgets/main_button.dart';
import 'package:flutter/material.dart';

enum USERGENDER { male, female }

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController userCode = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController department = TextEditingController();
  final TextEditingController education = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController role = TextEditingController();
  final TextEditingController password = TextEditingController();

  String dateOfBirth = "";
  USERGENDER gender = USERGENDER.male;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register View"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                controller: firstName,
                hintText: "First Name",
              ),
              InputField(
                controller: lastName,
                hintText: "Last Name",
              ),
              InputField(
                controller: phone,
                hintText: "Phone",
              ),
              InputField(
                controller: userCode,
                hintText: "User Code",
              ),
              InputField(
                controller: education,
                hintText: "Education",
              ),
              InputField(
                controller: department,
                hintText: "Department",
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Male"),
                  Radio(
                    value: USERGENDER.male,
                    groupValue: gender,
                    onChanged: (gender) {
                      setState(() {
                        this.gender = USERGENDER.male;
                      });
                    },
                  ),
                  const Text("Female"),
                  Radio<USERGENDER>(
                    value: USERGENDER.female,
                    groupValue: gender,
                    onChanged: (gender) {
                      setState(() {
                        this.gender = USERGENDER.female;
                      });
                    },
                  ),
                ],
              ),
              Text("Date of birth : $dateOfBirth"),
              MainButton(
                title: "Pick Date of birth",
                onPressed: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 365 * 50)),
                    lastDate: DateTime.now(),
                  );
                  setState(() {
                    dateOfBirth = "${d!.year}/${d.month}/${d.day}";
                  });
                },
              ),
              InputField(
                controller: email,
                hintText: "Email",
              ),
              InputField(
                controller: password,
                hintText: "Password",
                shouldObscure: true,
              ),
              MainButton(
                title: "Regiseter User",
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    Map user = {
                      "firstName": firstName.text,
                      "lastName": lastName.text,
                      "phone": phone.text,
                      "userCode": userCode.text,
                      "dateOfBirth": dateOfBirth,
                      "department": department,
                      "gender": gender == USERGENDER.male ? "male" : "female",
                      "education": education.text,
                      "email": email.text,
                      "uid": "test",
                      "role": "USER"
                    };
                    final int status = await UserManagementService()
                        .registerUser(user, email.text, password.text);
                    if (status != 500) {
                      // ignore: use_build_context_synchronously
                      NavigateHelper().navigator(
                          context,
                          GetUserByUserNameView(
                            username: email.text,
                          ));
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessangerCustom()
                          .scaffoldMessage("Register user failed", context);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
