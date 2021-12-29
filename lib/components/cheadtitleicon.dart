import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CHeadTitleIcon extends StatelessWidget {
  final String heading;
  final String content;
  final bool isDivide;
  final Icon icon;
  final Color color;

  CHeadTitleIcon(
      {this.heading,
      this.content,
      this.isDivide = true,
      this.icon,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                child: icon,
                backgroundColor: color.withOpacity(0.2),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    heading,
                    style: kHeadingTextStyle,
                  ),
                  Text(
                    content,
                    style: kContentTextStyle,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          if (isDivide)
            Divider(
              thickness: 2.0,
              indent: 60.0,
            ),
        ],
      ),
    );
  }
}
