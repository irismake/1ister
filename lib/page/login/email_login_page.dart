import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../widget/custom/custom_text_form_field.dart';
import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/join_widget.dart';
import '../../widget/navigator/home_page_navigator.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  @override
  final _emailFormkey = GlobalKey<FormState>();
  final _passwordFormkey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userPassword = '';

  bool _emailFilled = false;
  bool _passwordFilled = false;
  bool _signInValid = false;

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() {
      setState(() {
        final formKeyState = _emailFormkey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });

    _passwordFocus.addListener(() {
      setState(() {
        final formKeyState = _passwordFormkey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });
  }

  String? _checkSignInValid(String? value) {
    if (_emailFocus.hasFocus) {
      _signInValid = true;
      return null;
    }
    if (!_signInValid) {
      return '아이디 또는 비밀번호가 일치하지 않습니다';
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: JoinWidget(
          title: '가입하신 아이디와\n비밀번호를 입력해주세요.',
          firstFieldText: '',
          firstGuideState: false,
          firstGuideText: null,
          secondGuideState: false,
          secondGuideText: null,
          firstCustomForm: Form(
            key: _emailFormkey,
            child: CustomTextFormField(
              hintText: '이메일',
              focusNode: _emailFocus,
              onChanged: (value) {
                setState(() {
                  _userEmail = value;
                  value.isNotEmpty ? _emailFilled = true : _emailFilled = false;
                });
              },
              validator: (value) {
                return _checkSignInValid(value);
              },
              keyboardType: TextInputType.text,
            ),
          ),
          secondFieldText: '',
          secondCustomForm: Form(
            key: _passwordFormkey,
            child: CustomTextFormField(
              hintText: '비밀번호',
              focusNode: _passwordFocus,
              isObscureText: true,
              onChanged: (value) {
                setState(() {
                  _userPassword = value;
                  value.isNotEmpty
                      ? _passwordFilled = true
                      : _passwordFilled = false;
                });
              },
              keyboardType: TextInputType.text,
            ),
          ),
          authenticationState: false,
          authenticationButton: null,
          timer: null,
          nextPageButton: NextPageButton(
            firstFieldState: _emailFilled,
            secondFieldState: _passwordFilled,
            text: '로그인',
            onPressed: () async {
              print("[final email] : $_userEmail");
              print("[final password] : $_userPassword");
              _signInValid = await ApiService.signIn(_userEmail, _userPassword);
              print(_signInValid);
              final formKeyState = _emailFormkey.currentState!;
              if (formKeyState.validate()) {
                formKeyState.save();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePageNavigator()),
                    (route) => false);
              }
            },
          ),
        ),
      ),
    );
  }
}
