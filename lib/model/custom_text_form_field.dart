import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool isObscureText;
  final TextInputType keyboardType;

   const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.focusNode,
    required this.onChanged,
    this.validator,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();

}

final noFocusColor = Color(0xffCED4DA);
final noFocusTextColor = Color(0xff868E96);
final brandPointColor = Color(0xff5BFF7F);
final errorColor = Color(0xffFA5252);

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: (value) {
        return widget.validator?.call(value) ?? null;
      },
      obscureText: widget.isObscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        fontFamily: 'PretendardRegular',
        decorationThickness: 0,
        fontSize: 16.sp,
        color: widget.focusNode.hasFocus ? Colors.black :  noFocusTextColor,
        fontWeight: FontWeight.w600,
      ),
      showCursor: false,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        isDense: true,
        prefix: Container(width: 16.w),
        contentPadding: EdgeInsets.symmetric(vertical: 20.0.h),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: 'PretendardRegular',
          color: noFocusColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1.w, color: brandPointColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1.w, color: noFocusColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 1.w, color: errorColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 1.w, color: errorColor),
        ),
        errorStyle: TextStyle(
          fontFamily: 'PretendardRegular',
          color: errorColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
              width: 1.w, color: noFocusColor),
        ),
      ),
    );
  }
}