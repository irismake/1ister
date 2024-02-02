import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRankingSwitch extends StatefulWidget {
  final bool value;
  final Color enableColor;
  final Color disableColor;
  final double width;
  final double height;
  final double switchHeight;
  final double switchWidth;
  final ValueChanged<bool> onChanged;

  CustomRankingSwitch(
      {super.key,
      required this.value,
      required this.enableColor,
      required this.disableColor,
      required this.width,
      required this.height,
      required this.switchHeight,
      required this.switchWidth,
      required this.onChanged});

  @override
  _CustomRankingSwitchState createState() => _CustomRankingSwitchState();
}

class _CustomRankingSwitchState extends State<CustomRankingSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: widget.width ?? 48.0,
            height: widget.height ?? 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.disableColor
                  : widget.enableColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 2.0.h, bottom: 2.0.h, right: 2.0.w, left: 2.0.w),
              child: Container(
                alignment:
                    widget.value ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: widget.switchWidth ?? 20.0,
                  height: widget.switchHeight ?? 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomPrivateSwitch extends StatefulWidget {
  final bool value;
  final Color enableColor;
  final Color disableColor;
  final double width;
  final double height;
  final double switchHeight;
  final double switchWidth;
  final ValueChanged<bool> onChanged;

  const CustomPrivateSwitch(
      {super.key,
      required this.value,
      required this.enableColor,
      required this.disableColor,
      required this.width,
      required this.height,
      required this.switchHeight,
      required this.switchWidth,
      required this.onChanged});

  @override
  _CustomPrivateSwitchState createState() => _CustomPrivateSwitchState();
}

class _CustomPrivateSwitchState extends State<CustomPrivateSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: widget.width ?? 48.0,
            height: widget.height ?? 24.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xFFF1F3F5)),
            child: Stack(
              children: [
                Container(
                  alignment: widget.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: widget.switchWidth ?? 20.0,
                    height: widget.switchHeight ?? 20.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFF343A40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 6.0.h, left: 17.5.w, bottom: 6.0.h, right: 11.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '공개',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _circleAnimation.value == Alignment.centerLeft
                              ? widget.enableColor
                              : widget.disableColor,
                          fontSize: 14.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.4.h,
                        ),
                      ),
                      Text(
                        '비공개',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _circleAnimation.value == Alignment.centerRight
                              ? widget.enableColor
                              : widget.disableColor,
                          fontSize: 14.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.4.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
