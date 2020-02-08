import 'package:flutter/material.dart';



class ButtonWithIcon extends StatelessWidget {
  //型に注意
  final VoidCallback onPressed;
  final String label;
  final Icon icon;
  final color;


  ButtonWithIcon({this.onPressed, this.icon, this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      //horizontal両端にpaddingをつける。縦はvertical。
      child: SizedBox(
        height: 50.0,
        width: double.infinity,
        child: RaisedButton.icon(
            onPressed: onPressed,
            icon: icon,
            label: Text(label, style: TextStyle(fontSize: 18.0),),
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))
            ),
        ),
      ),
    );
  }
}
