import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailer_app/components/inputfield.dart';
import 'package:tailer_app/components/main_button.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/screens/myaccountscreen.dart';

import '../constants.dart';

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController cMobile = TextEditingController();
  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  final _form = GlobalKey<FormState>();


  void formSubmit() async {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
    } else {
      _form.currentState.save();
      // dismiss keyboard during async call

      FocusScope.of(context).requestFocus(FocusNode());

      Provider.of<AppData>(context, listen: false)
          .setUserData(cName.text, cEmail.text, cMobile.text);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('name', cName.text);
      localStorage.setString('email', cEmail.text);
      localStorage.setString('phone', cMobile.text);
      localStorage.setBool('isRegister', true);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyAccountScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    cName.text = context.read<AppData>().userData.name;
    cEmail.text = context.read<AppData>().userData.email;
    cMobile.text = context.read<AppData>().userData.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top),
          child: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  InputField(
                    controller: cName,
                    label: "Name",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter text';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    controller: cMobile,
                    label: "Phone",
                    textInputType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter text';
                      }
                      if (value.length > 10 || value.length < 10) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    controller: cEmail,
                    label: "Email",
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!value.isEmpty && !emailValidation.hasMatch(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  Spacer(),
                  MainButton(
                    isRegister: true,
                    label: 'Update',
                    submit: () => formSubmit(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
