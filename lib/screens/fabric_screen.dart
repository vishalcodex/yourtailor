import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailer_app/components/main_button.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/models/gender.dart';
import 'package:tailer_app/screens/typescreen.dart';

class FabricScreen extends StatefulWidget {
  @override
  _FabricScreenState createState() => _FabricScreenState();
}

class _FabricScreenState extends State<FabricScreen> {
  List<Gender> fabrics = [
    Gender(title: 'I have Fabric', selected: false),
    Gender(title: 'I need Fabric', selected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Fabric'),
      ),
      body: Column(
        children: [
          GridView.builder(
            itemCount: fabrics.length,
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
                      fabrics[index].selected = !fabrics[index].selected;
                      fabrics[1].selected = false;
                    } else {
                      fabrics[index].selected = !fabrics[index].selected;
                      fabrics[0].selected = false;
                    }
                  });
                },
                onDoubleTap: () => {},
                child: Card(
                  elevation: 3,
                  color: fabrics[index].selected ? Colors.grey : Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            fabrics[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
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
            submit: fabrics.any((element) => element.selected == true)
                ? () {
                    context.read<AppData>().setNeedFabric(fabrics
                        .firstWhere((element) => element.selected)
                        .title == "I need Fabric");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TypeScreen(),
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
