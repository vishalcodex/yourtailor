import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailer_app/components/main_button.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/models/gender.dart';
import 'package:tailer_app/models/occasion.dart';
import 'package:tailer_app/screens/gender_screen.dart';
import 'package:provider/provider.dart';
import 'package:tailer_app/screens/typescreen.dart';

class OccasionScreen extends StatefulWidget {
  @override
  _OccasionScreenState createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  List<Occasion> occasions = [
    Occasion(
        selectedImage: 'assets/male.svg',
        image: 'assets/male_white.svg',
        title: 'Regular',
        selected: false),
    Occasion(
        selectedImage: 'assets/wedding_couple.svg',
        image: 'assets/wedding_couple_white.svg',
        title: 'Wedding',
        selected: false),
    Occasion(
        selectedImage: 'assets/male.svg',
        image: 'assets/male_white.svg',
        title: 'Family Function',
        selected: false),
    Occasion(
        selectedImage: 'assets/male.svg',
        image: 'assets/male_white.svg',
        title: 'Festive',
        selected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Occasion'),
      ),
      body: Column(
        children: [
          GridView.builder(
            itemCount: occasions.length,
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
                      occasions[index].selected = !occasions[index].selected;
                      occasions[1].selected = false;
                      occasions[2].selected = false;
                      occasions[3].selected = false;
                    } else if (index == 1) {
                      occasions[index].selected = !occasions[index].selected;
                      occasions[0].selected = false;
                      occasions[2].selected = false;
                      occasions[3].selected = false;
                    } else if (index == 2) {
                      occasions[index].selected = !occasions[index].selected;
                      occasions[0].selected = false;
                      occasions[1].selected = false;
                      occasions[3].selected = false;
                    } else {
                      occasions[index].selected = !occasions[index].selected;
                      occasions[1].selected = false;
                      occasions[0].selected = false;
                      occasions[2].selected = false;
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
                          occasions[index].selected
                              ? occasions[index].selectedImage
                              : occasions[index].image,
                          width: 60,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            occasions[index].title,
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
            submit: occasions.any((element) => element.selected == true)
                ? () {
                    context.read<AppData>().setOccasions(occasions);
                    // context.read<AppData>().setSelectedGender(
                    //       Gender(
                    //           selectedImage: 'assets/male.svg',
                    //           image: 'assets/male_white.svg',
                    //           title: 'Male',
                    //           selected: false),
                    //     );
                    return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenderScreen(),
                      ),
                    );
                  }
                : () {},
          )
        ],
      ),
    );
  }
}
