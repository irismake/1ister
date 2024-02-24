import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final bool labelState;
  final String? labelText;
  final double height;
  final double fieldHeight;
  final TextStyle textStyle;
  final String? initText;
  final TextEditingController? controller;

  const CustomTextField({
    required this.labelState,
    required this.labelText,
    required this.height,
    required this.fieldHeight,
    required this.textStyle,
    required this.initText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          labelState
              ? Text(
                  labelText!,
                  style: TextStyle(
                      fontFamily: 'PretendardRegular',
                      color: Color(0xff343A40),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.5.h),
                )
              : Container(
                  color: Colors.deepOrange,
                  height: 10,
                ),
          SizedBox(
            height: fieldHeight,
            child: TextFormField(
              style: textStyle,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              expands: true,
              controller: controller,
              initialValue: initText,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 12.0.w),
                filled: false,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: Color(0xffDEE2E6),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    width: 1.w,
                    color: Color(0xffDEE2E6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
