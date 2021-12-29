import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailer_app/components/cheadtitleicon.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/screens/profileupdatescreen.dart';

import '../constants.dart';

class MyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Consumer<AppData>(
            builder: (context, data, ch) {
              var customer = data.userData;
              return customer != null
                  ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      "${customer.name[0]}",
                      style: kTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CHeadTitleIcon(
                    heading: 'Name',
                    content: customer.name,
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.lightBlue,
                    ),
                    color: Colors.lightBlue,
                  ),
                  CHeadTitleIcon(
                    heading: 'Phone Number',
                    content: customer.mobile,
                    icon: Icon(
                      Icons.call,
                      color: Colors.deepOrangeAccent,
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                  CHeadTitleIcon(
                    heading: 'Email',
                    content: customer.email,
                    icon: Icon(
                      Icons.email,
                      color: Colors.redAccent,
                    ),
                    color: Colors.redAccent,
                  ),
                ],
              )
                  : ch;
            },
            child: Center(
              child: Text('Not Found'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileUpdateScreen(),
          ),
        ),
        child: Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }
}
