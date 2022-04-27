import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tailer_app/components/main_button.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/models/gender.dart';
import 'package:tailer_app/screens/fabric_screen.dart';
import 'package:tailer_app/screens/typescreen.dart';


class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  List<Gender> genders = [
    Gender(
        selectedImage: 'assets/male.svg',
        image: 'assets/male_white.svg',
        title: 'Male',
        selected: false),
    Gender(
        selectedImage: 'assets/female.svg',
        image: 'assets/female_white.svg',
        title: 'Female',
        selected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Gender'),
      ),
      body: Column(
        children: [
          GridView.builder(
            itemCount: genders.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) => GridTile(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (index == 0) {
                      genders[index].selected = !genders[index].selected;
                      genders[1].selected = false;
                    } else {
                      genders[index].selected = !genders[index].selected;
                      genders[0].selected = false;
                    }
                  });
                },
                onDoubleTap: () => {},
                child: Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          genders[index].selected
                              ? genders[index].selectedImage
                              : genders[index].image,
                          width: 60,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            genders[index].title,
                            overflow: TextOverflow.ellipsis,
                            style:
                            TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          MainButton(
            submit: genders.any((element) => element.selected == true) ? () {
              context.read<AppData>().setSelectedGender(
                    genders.firstWhere((element) => element.selected),
                  );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FabricScreen(),
                ),
              );
            } : (){},
          )
        ],
      ),
    );
  }
}
