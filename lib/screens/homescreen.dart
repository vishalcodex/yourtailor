import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tailer_app/controllers/appdata.dart';
import 'package:tailer_app/screens/myaccountscreen.dart';
import 'package:tailer_app/screens/occasion_screen.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AppData>(context, listen: false).getData(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Scaffold(
              appBar: AppBar(
                title: Text(appName),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(appName),
                actions: [
                  IconButton(
                      onPressed: () {
                        final RenderBox box = context.findRenderObject();
                        Share.share(
                            'https://play.google.com/store/apps/details?id=com.codex.yourtailor',
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      },
                      icon: Icon(Icons.share_outlined))
                ],
              ),
              body: Consumer<AppData>(
                builder: (context, data, ch) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: ListView(
                    children: <Widget>[
                      if (data.images.length > 0)
                        Container(
                          child: Column(
                            children: <Widget>[
                              CarouselSlider(
                                options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1.0,
                                    onPageChanged: (index, r) {
                                      data.updateCurrent(index);
                                    }),
                                items: data.images
                                    .map(
                                      (a) => Container(
                                        child: CachedNetworkImage(
                                          imageUrl: imagesUrl + a,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: data.images.map((l) {
                                  int index = data.images.indexOf(l);
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: data.current == index
                                          ? Theme.of(context).primaryColor
                                          : Color.fromRGBO(0, 0, 0, 0.4),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAccountScreen(),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            onPrimary: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Personal information',
                            style: kTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OccasionScreen(),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            onPrimary: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Book an appointment',
                            style: kTextStyle.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryCardColor,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: Text(
                          'Customer care number : 7304303087',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      // Card(
                      //   elevation: 5.0,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'The tailor app is an innovative thought of Mr.Atul Pingle.',
                      //           style: Theme.of(context).textTheme.headline6,
                      //         ),
                      //         SizedBox(
                      //           height: 10.0,
                      //         ),
                      //         Text(
                      //           'Contact us:',
                      //           style: TextStyle(
                      //               fontSize: 19.0,
                      //               fontWeight: FontWeight.w600,
                      //               color: Colors.grey[700]),
                      //         ),
                      //         Text('+91 96194 36552',
                      //             style: TextStyle(
                      //                 fontSize: 18.0,
                      //                 fontWeight: FontWeight.w700)),
                      //         Text('Email:',
                      //             style: TextStyle(
                      //                 fontSize: 19.0,
                      //                 color: Colors.grey[700],
                      //                 fontWeight: FontWeight.w600)),
                      //         Text('yourtailor2021@gmail.com',
                      //             style: TextStyle(
                      //                 fontSize: 18.0,
                      //                 fontWeight: FontWeight.w700))
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
