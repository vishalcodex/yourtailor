import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/screens/homescreen.dart';

import 'components/inputfield.dart';
import 'components/main_button.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          primaryColor: kPrimaryCardColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: kPrimaryCardColor,
              onPrimary: Colors.white,
            ),
          ),
        ),
        home: MyHomePage(title: appName),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cMobile = TextEditingController();
  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    checkRoute();
    super.initState();
  }

  checkRoute() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool isRegister = localStorage.getBool('isRegister');
    if (isRegister != null) {
      Provider.of<AppData>(context, listen: false).setUserData(
        localStorage.getString('name'),
        localStorage.getString('email'),
        localStorage.getString('phone'),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      // cName.text = localStorage.getString('name');
      // cEmail.text = localStorage.getString('email');
      // cMobile.text = localStorage.getString('phone');
    }
  }

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: context.read<AppData>().userData != null
            ? [IconButton(icon: Icon(Icons.person), onPressed: () {})]
            : [],
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
                    label: 'Register',
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
