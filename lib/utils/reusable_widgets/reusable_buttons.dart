import 'package:ateam/utils/colors/colors.dart';
import 'package:ateam/utils/reusable_widgets/reused_text.dart';
import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton(
      {super.key, required this.onpressed, required this.buttontitle});
  final VoidCallback onpressed;
  final String buttontitle;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        width: width * .3,
        height: height * .05,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: whitecolor),
        child: Center(
          child: Heading15font500(
            heading: buttontitle,
            color: primaryblue,
          ),
        ),
      ),
    );
  }
}
