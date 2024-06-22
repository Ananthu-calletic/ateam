import 'package:ateam/utils/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomTextfeild extends StatefulWidget {
  const CustomTextfeild(
      {super.key, required this.hint, required this.controller});
  final String hint;
  final TextEditingController controller;

  @override
  State<CustomTextfeild> createState() => _CustomTextfeildState();
}

class _CustomTextfeildState extends State<CustomTextfeild> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * .06,
      width: width * .6,
      child: TextField(
        cursorColor: blackcolor,
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: whitecolor,
          filled: true,
          hintText: widget.hint,
          contentPadding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          hintStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontFamily: 'Gilroy',
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        style: const TextStyle(
          fontSize: 13.0,
          fontFamily: 'Gilroy',
          height: 1,
          fontWeight: FontWeight.w400,
          color: blackcolor,
        ),
        // maxLines: maxLines,
      ),
    );
  }
}
