import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lister/model/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({Key? key}) : super(key: key);

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {

  final noFocusColor = Color(0xffCED4DA);
  final brandPointColor = Color(0xff5BFF7F);
  final darkGrayColor = Color(0xff495057);
  final mildGrayColor= Color(0xffADB5BD);
  final noFocusButtonColor = Color(0xffF9FAFB);
  final focusButtonColor = Color(0xffF1F3F5);

  bool _nextButtonState = false;
  bool _passwordState = false;
  bool _passwordCheckState = false;

  FocusNode _passwordFocus = FocusNode();
  FocusNode _passwordCheckFocus = FocusNode();

  final _passwordFormkey = GlobalKey<FormState>();
  final _passwordCheckFormkey = GlobalKey<FormState>();

  String password = '';
  String passwordCheck = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 88.h),
                child: Column(
                  children: [
                    Container(
                      height: 80.h,
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          '마지막으로\n비밀번호를 설정해 주세요.',
                          style: TextStyle(
                            fontFamily: 'PretendardRegular',
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(
                              '비밀번호',
                              style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: darkGrayColor,
                              ),
                            ),
                            Text(
                              '영어, 숫자 포함 n자 이내',
                              style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: mildGrayColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Form(
                          key: _passwordFormkey,
                          child: CustomTextFormField(
                            hintText: '비밀번호를 설정해 주세요.',
                            focusNode: _passwordFocus,
                            onChanged: (value) {
                              setState(() {
                                password = value!;
                                if(value!.isNotEmpty){
                                  _passwordState = true;
                                  if(_passwordCheckState){
                                    _nextButtonState = true;
                                  }
                                }else{
                                  _passwordState = false;
                                  _nextButtonState = false;
                                }
                              });
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '비밀번호 확인',
                              style: TextStyle(
                                fontFamily: 'PretendardRegular',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: darkGrayColor,
                              ),
                            ),

                        ),
                        SizedBox(
                          height: 9.h,
                        ),

                        Form(
                          key: _passwordCheckFormkey,
                          child: CustomTextFormField(
                            hintText: '비밀번호를 다시 입력해 주세요.',
                            focusNode: _passwordCheckFocus,
                            onChanged: (value) {
                              setState(() {
                                passwordCheck = value!;
                                if(value!.isNotEmpty){
                                  _passwordCheckState = true;
                                  if(_passwordState){
                                    _nextButtonState = true;
                                  }
                                }else{
                                  _passwordCheckState = false;
                                  _nextButtonState = false;
                                }
                              });
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: ()  {
                      if(_nextButtonState){
                        //checkpasswordCheck(passwordCheck);

                      }

                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 158.w, vertical: 20.h),
                      backgroundColor:
                      _nextButtonState ? Colors.black : noFocusColor,
                    ),
                    child: Text(
                      "다음",
                      style: TextStyle(
                        fontFamily: 'PretendardRegular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color:
                        _nextButtonState ? brandPointColor : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
