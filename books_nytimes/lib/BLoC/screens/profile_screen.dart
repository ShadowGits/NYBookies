import 'package:books_nytimes/BLoC/utilities/constants.dart';
import 'package:books_nytimes/BLoC/utilities/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseUser user;

  ProfileScreen({@required this.user});

  @override
  Widget build(BuildContext context) {
    heightBlockSize = displaySafeHeightBlocks(context);
    widthBlockSize = displaySafeWidthBlocks(context);
    String name;
    String email;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              print("CALLED");
              var updateInfo = UserUpdateInfo();
              updateInfo.displayName = name;
              await user.updateProfile(updateInfo);
              // Update successful.

              print("GAO BACK");
              Navigator.pop(context, true);
            },
          )
        ],
      ),
      body: Form(
        child: Container(
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: user.displayName,
                decoration: InputDecoration(
                  icon: Icon(Icons.contact_mail),
                  labelText: 'Username',
                ),
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (value) {
                  name = value;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
              TextFormField(
                initialValue: user.email,
                decoration: InputDecoration(
                  labelText: "Email",
                  icon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.text,
                autocorrect: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
