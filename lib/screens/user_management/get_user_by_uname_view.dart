// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api_test/services/user_management.dart';
import 'package:api_test/widgets/input_fileld.dart';
import 'package:api_test/widgets/main_button.dart';
import 'package:flutter/material.dart';

class GetUserByUserNameView extends StatefulWidget {
  final String? username;
  final bool fromBlock;
  const GetUserByUserNameView({Key? key, this.username, this.fromBlock = false})
      : super(key: key);

  @override
  State<GetUserByUserNameView> createState() => _GetUserByUserNameViewState();
}

class _GetUserByUserNameViewState extends State<GetUserByUserNameView> {
  final TextEditingController searchText = TextEditingController();
  String userData = "No Results";
  String _blockText = "block";
  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      setUserData(widget.username!);
    }
  }

  void setUserData(String uname) {
    UserManagementService()
        .getUserDataByUserName(uname)
        .then((value) => setState(() {
              userData = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            if (widget.username == null)
              InputField(
                controller: searchText,
                hintText: "Enter username here",
              ),
            if (widget.username == null)
              MainButton(
                title: "Search",
                onPressed: () {
                  setState(() {
                    setUserData(searchText.text);
                  });
                },
              ),
            Text(
              userData,
              style: const TextStyle(fontSize: 24),
            ),
            if (widget.fromBlock)
              MainButton(
                title: _blockText,
                onPressed: () async {},
              ),
          ],
        ),
      ),
    );
  }
}
