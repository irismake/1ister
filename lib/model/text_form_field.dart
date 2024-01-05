import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function(String?) validator;
  final bool isObscureText;
  final TextInputType keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.focusNode,
    required this.onChanged,
    required this.validator,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.isObscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        fontFamily: 'PretendardRegular',
        decorationThickness: 0,
        fontSize: 16.sp,
        color: widget.focusNode.hasFocus ? Colors.black : Colors.grey,
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
          color: Colors.grey,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1.w, color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1.w, color: Colors.grey),
        ),
      ),
    );
  }
}
