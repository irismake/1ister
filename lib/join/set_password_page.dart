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
  void initState() {
    super.initState();

    _passwordFocus.addListener(() {
      setState(() {
        final formKeyState = _passwordFormkey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
        if (_passwordState && _passwordCheckState) {
          _nextButtonState = true;
        } else {
          _nextButtonState = false;
        }
      });
    });

    _passwordCheckFocus.addListener(() {
      setState(() {
        final formKeyState = _passwordCheckFormkey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
        if (_passwordState && _passwordCheckState) {
          _nextButtonState = true;
        } else {
          _nextButtonState = false;
        }
      });
    });
  }

  Future<void> signUp(String name, String email, String password, String userName) async {
    try {
      final Uri uri = Uri.parse('http://172.30.1.87:5999/user/signup');

      final Map<String, dynamic> requestBody = {
        "name": name,
        "email": email,
        "password": password,
        "username": userName,
      };

      final http.Response response = await http.post(
        uri,
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
      } else {
        print('회원가입 실패 - 상태 코드: ${response.statusCode}');
        // 실패 시에 대한 추가적인 처리를 할 수 있습니다.
      }
    } catch (e) {
      print('회원가입 오류: $e');
    }
  }

  void _agreementPopUp() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        //backgroundColor: Colors.black.withOpacity(30),
        context: context,
        builder: (context) {
          return Container(
            height: 280.h,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Modal BottomSheet'),
                  ElevatedButton(
                    child: const Text('Done!'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),

          );
        });
  }
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
                            isObscureText:true,
                            validator: (value) {

                            },
                            onChanged: (value) {
                              setState(() {
                                password = value!;
                                if(value!.isNotEmpty){
                                  _passwordState = true;

                                }else{
                                  _passwordState = false;

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
                            isObscureText:true,
                            onChanged: (value) {
                              setState(() {
                                passwordCheck = value!;
                                if(value!.isNotEmpty){
                                  _passwordCheckState = true;

                                }else{
                                  _passwordCheckState = false;

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
                      setState(() {
                        if(_nextButtonState) {

                          // final formKeyState =
                          // _passwordFormkey.currentState!;
                          // if (formKeyState.validate()) {
                          //   formKeyState.save();
                          // }
                          // if (password != passwordCheck) {
                          //   _passwordState = false;
                          // }
                          //_agreementPopUp();
                          signUp('아보카도', 'iris3455@gmail.com','kgh0125', 'lister001');
                        }
                      });



                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 151.w, vertical: 20.h),
                      backgroundColor:
                      _nextButtonState ? Colors.black : noFocusColor,
                    ),
                    child: Text(
                      "회원가입",
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
