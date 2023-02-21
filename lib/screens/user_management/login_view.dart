import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/helpers/scaffold_messanger.dart';
import 'package:api_test/screens/user_management/get_user_by_uname_view.dart';
import 'package:api_test/services/user_management.dart';
import 'package:api_test/widgets/input_fileld.dart';
import 'package:api_test/widgets/main_button.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _key,
            child: Column(
              children: [
                const SizedBox(
                  height: 64,
                ),
                InputField(
                  controller: email,
                  hintText: "Email",
                ),
                InputField(
                  controller: password,
                  shouldObscure: true,
                  hintText: "Password",
                ),
                MainButton(
                  title: "Login",
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      int code = await UserManagementService()
                          .login(email.text, password.text);

                      if (code != 500) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessangerCustom()
                            .scaffoldMessage("Signin sucess", context);
                        // ignore: use_build_context_synchronously
                        NavigateHelper().navigator(
                            context,
                            GetUserByUserNameView(
                              username: email.text,
                            ));
                        return;
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessangerCustom().scaffoldMessage(
                            "Signin Failed.Something went wrong", context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
