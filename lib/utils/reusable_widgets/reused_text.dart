import 'package:flutter/material.dart';

class Heading22font600 extends StatelessWidget {
  const Heading22font600(
      {super.key, required this.heading, required this.color});
  final String heading;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(heading,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Gilroy',
            fontSize: 22,
            color: color));
  }
}

class Heading12font500 extends StatelessWidget {
  const Heading12font500(
      {super.key, required this.heading, required this.color});
  final String heading;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(heading,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Gilroy',
            fontSize: 12,
            color: color));
  }
}

class Heading15font500 extends StatelessWidget {
  const Heading15font500(
      {super.key, required this.heading, required this.color});
  final String heading;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(heading,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Gilroy',
            fontSize: 16,
            color: color));
  }
}
