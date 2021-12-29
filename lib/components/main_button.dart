import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final MaterialPageRoute route;
  final Function submit;
  final String label;
  bool loading;
  bool isRegister;

  MainButton({
    this.route,
    this.submit,
    this.loading = false,
    this.label = "Continue",
    this.isRegister = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading
          ? () {}
          : () {
              return submit();
            },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: isRegister
              ? BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))
              : BorderRadius.zero,
        ),
        onPrimary: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (loading)
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            if (!loading)
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
