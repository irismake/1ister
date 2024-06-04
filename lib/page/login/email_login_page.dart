import 'package:flutter/material.dart';

import '../../components/custom_ui_kit/custom_next_page_button.dart';
import '../../components/custom_ui_kit/custom_text_form_field.dart';
import '../../components/navigator/home_page_navigator.dart';
import '../../components/widget/sign_widget.dart';
import '../../services/api_service.dart';

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
  bool _emailSignInValid = false;
  bool _emailExistenceValid = false;

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

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _checkSignInValid(String? value) {
    if (!_emailSignInValid) {
      return '아이디 또는 비밀번호가 일치하지 않습니다';
    }
  }

  String? _checkEmailExistence(String? value) {
    if (!_emailExistenceValid) {
      return '일치하는 아이디가 존재하지 않습니다.';
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SignWidget(
          title: '가입하신 아이디와\n비밀번호를 입력해주세요.',
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
                if (_emailFocus.hasFocus) {
                  _emailExistenceValid = true;
                  _emailSignInValid = true;
                  return null;
                }
                List<String? Function(String)> validators = [
                  _checkSignInValid,
                  _checkEmailExistence,
                ];
                for (var validator in validators) {
                  var result = validator(value!);
                  if (result != null) {
                    return result;
                  }
                }
              },
              keyboardType: TextInputType.text,
            ),
          ),
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
          nextPageButton: NextPageButton(
            firstFieldState: _emailFilled,
            secondFieldState: _passwordFilled,
            text: '로그인',
            onPressed: () async {
              _emailExistenceValid = await ApiService.checkEmail(_userEmail);
              if (_emailExistenceValid) {
                _emailSignInValid =
                    await ApiService.signIn(_userEmail, _userPassword);
              }
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
