import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailer_app/components/date_field.dart';
import 'package:tailer_app/components/main_button.dart';
import 'package:tailer_app/components/time_field.dart';
import 'package:tailer_app/controllers/appdata.dart';

import 'homescreen.dart';

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  TextEditingController cTimingFrom = TextEditingController();
  TextEditingController cTimingTo = TextEditingController();
  TextEditingController cDate = TextEditingController();
  TextEditingController cAddress = TextEditingController();
  final _form = GlobalKey<FormState>();

  // replace this function with the examples above
  showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thanks"),
      content: Text(
        message,
      ),
      actions: [
        ElevatedButton(
          child: Text("Go Home"),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () {}, child: alert);
      },
    );
  }

  void formSubmit() {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
    } else {
      _form.currentState.save();
      // dismiss keyboard during async call

      FocusScope.of(context).requestFocus(FocusNode());

      Provider.of<AppData>(context, listen: false).setUserInfoData(
        cDate.text,
        cTimingFrom.text,
        cTimingTo.text,
        cAddress.text,
      );
      Provider.of<AppData>(context, listen: false).setLoading(true);
      Provider.of<AppData>(context, listen: false).sendData().then((res) {
        Provider.of<AppData>(context, listen: false).setLoading(false);
        showAlertDialog(context, 'Message has been sent');
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OccasionScreen(),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.calendar_today_sharp),
                  title: BasicDateField(
                    label: 'Date',
                    controller: cDate,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select time';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: BasicTimeField(
                    label: 'Timing From',
                    controller: cTimingFrom,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select time';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: BasicTimeField(
                    label: 'Timing To',
                    controller: cTimingTo,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select time';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Address",
                    ),
                    controller: cAddress,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select time';
                      }
                      return null;
                    },
                    maxLines: 3,
                  ),
                ),
                Spacer(),
                Consumer<AppData>(
                  builder: (context, data, ch) => MainButton(
                    label: 'Book Now',
                    submit: formSubmit,
                    loading: data.loading,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
