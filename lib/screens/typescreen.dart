import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailer_app/components/main_button.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/screens/book_appointment_screen.dart';

import '../models/type.dart';

class TypeScreen extends StatefulWidget {
  @override
  _TypeScreenState createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  List<DressType> dataList;

  @override
  initState() {
    super.initState();

    dataList = context.read<AppData>().selectedGender.title == "Male"
        ? context.read<AppData>().maleTypes
        : context.read<AppData>().femaleTypes;
    setState(() {

    });
  }

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
            if (data.selectedGender.title == "Male")
              Expanded(
                child: ListView.builder(
                  itemCount: data.maleTypes.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(data.maleTypes[index].title +
                          "  (${data.needFabric ? data.maleTypes[index].needFabricPrice : data.maleTypes[index].haveFabricPrice}₹)"),
                      value: data.maleTypes[index].selected,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (val) {
                        data.setMaleSelected(index, val);
                      },
                    );
                  },
                ),
              ),
            if (data.selectedGender.title == 'Female')
              Expanded(
                child: ListView.builder(
                  itemCount: data.femaleTypes.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(data.femaleTypes[index].title +
                          "  (${data.needFabric ? data.femaleTypes[index].needFabricPrice : data.femaleTypes[index].haveFabricPrice}₹)"),
                      value: data.femaleTypes[index].selected,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (val) {
                        data.setFemaleSelected(index, val);
                      },
                    );
                  },
                ),
              ),
            MainButton(
              submit: dataList.any((element) => element.selected == true)
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
