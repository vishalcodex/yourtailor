import 'package:flutter/material.dart';
import 'package:tailer_app/components/main_button.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/screens/book_appointment_screen.dart';
import 'package:provider/provider.dart';

class TypeScreen extends StatefulWidget {
  @override
  _TypeScreenState createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Type'),
      ),
      body: Consumer<AppData>(
        builder: (context, data, ch) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (true)
              // Container(
              //   padding: const EdgeInsets.all(15.0),
              //   margin: const EdgeInsets.only(top: 8.0),
              //   decoration: BoxDecoration(
              //       color: Colors.redAccent,
              //       borderRadius: BorderRadius.only(
              //         bottomRight: Radius.circular(15),
              //         topRight: Radius.circular(15),
              //       )),
              //   child: Text(
              //     'Mens',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 20.0,
              //     ),
              //   ),
              // ),
            if (true)
              Expanded(
                child: ListView.builder(
                  itemCount: data.maleTypes.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(data.maleTypes[index].title),
                      // title: Text(data.maleTypes[index].title +
                      //     "  (${data.maleTypes[index].price}₹)"),
                      value: data.maleTypes[index].selected,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (val) {
                        data.setMaleSelected(index, val);
                      },
                    );
                  },
                ),
              ),
            // if (context.read<AppData>().selectedGender.title == 'Female')
            //   Container(
            //     padding: const EdgeInsets.all(15.0),
            //     margin: const EdgeInsets.only(top: 8.0),
            //     decoration: BoxDecoration(
            //         color: Colors.pinkAccent,
            //         borderRadius: BorderRadius.only(
            //           bottomRight: Radius.circular(15),
            //           topRight: Radius.circular(15),
            //         )),
            //     child: Text(
            //       'Ladies',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20.0,
            //       ),
            //     ),
            //   ),
            // if (context.read<AppData>().selectedGender.title == 'Female')
            //   Expanded(
            //     child: ListView.builder(
            //       itemCount: data.femaleTypes.length,
            //       itemBuilder: (context, index) {
            //         return CheckboxListTile(
            //           title: Text(data.femaleTypes[index].title +
            //               "  (${data.femaleTypes[index].price}₹)"),
            //           value: data.femaleTypes[index].selected,
            //           activeColor: Theme.of(context).primaryColor,
            //           onChanged: (val) {
            //             data.setFemaleSelected(index, val);
            //           },
            //         );
            //       },
            //     ),
            //   ),
            MainButton(
              submit: data.maleTypes.any((element) => element.selected == true)
                      ? () {
                          context.read<AppData>().setDressTypes(data.maleTypes);
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookAppointmentScreen(),
                            ),
                          );
                        }
                      : () {},
            )
          ],
        ),
      ),
    );
  }
}
