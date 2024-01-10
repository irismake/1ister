import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextPageButton extends StatelessWidget {
  final bool firstFieldState;
  final bool secondFieldState;
  final Function onPressed;
  final String text;

  const NextPageButton({
    required this.firstFieldState,
    required this.secondFieldState,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          child: TextButton(
            onPressed: () async {
              onPressed();
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0.h),
              backgroundColor: firstFieldState && secondFieldState
                  ? Colors.black
                  : Color(0xFFDEE2E6), // Adjust the color accordingly
            ),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'PretendardRegular',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: firstFieldState && secondFieldState
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
