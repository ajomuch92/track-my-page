import 'package:flutter/material.dart';

class BlackCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;

  const BlackCard({Key? key, this.child, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      elevation: 5.0,
      color: Colors.blueGrey.shade900.withOpacity(0.5),
      child: SizedBox(
        height: _size.height * 0.35,
        width: _size.width * 0.75,
        child: this.child,
      )
    );
  }
}