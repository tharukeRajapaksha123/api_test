import 'package:api_test/helpers/navigate_helper.dart';
import 'package:api_test/screens/user_management/get_user_by_uname_view.dart';
import 'package:api_test/screens/user_management/login_view.dart';
import 'package:api_test/screens/user_management/register_view.dart';
import 'package:api_test/widgets/main_button.dart';
import 'package:flutter/material.dart';

class UserManagementView extends StatelessWidget {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MainButton(
              title: "Login",
              onPressed: () {
                NavigateHelper().navigator(
                  context,
                  const LoginView(),
                );
              },
            ),
            MainButton(
              title: "Register User",
              onPressed: () {
                NavigateHelper().navigator(context, RegisterUserView());
              },
            ),
            MainButton(
              title: "Get User",
              onPressed: () {
                NavigateHelper()
                    .navigator(context, const GetUserByUserNameView());
              },
            ),
            // MainButton(
            //   title: "Block / Unblock User",
            //   onPressed: () {
            //     NavigateHelper().navigator(
            //         context,
            //         const GetUserByUserNameView(
            //           fromBlock: true,
            //         ));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
