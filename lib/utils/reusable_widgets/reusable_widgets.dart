import 'package:ateam/utils/colors/colors.dart';
import 'package:ateam/utils/reusable_widgets/reused_text.dart';
import 'package:flutter/material.dart';

class TopHeaderSection extends StatelessWidget {
  const TopHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * .25,
      decoration: BoxDecoration(
          color: primaryblue, borderRadius: BorderRadius.circular(20)),
      child: const Padding(
        padding: EdgeInsets.only(left: 20, top: 40),
        child: Row(
          children: [
            Icon(
              Icons.account_circle,
              color: whitecolor,
              size: 80,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Heading22font600(heading: 'Robert Doe', color: whitecolor),
                Heading12font500(
                    heading: 'robertdoe@gmail.com', color: whitecolor),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomLine extends StatelessWidget {
  const CustomLine({super.key, required this.width, required this.color});
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 16,
      child: Divider(
        color: color,
        thickness: 1,
      ),
    );
  }
}
