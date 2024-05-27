import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../widget/custom/custom_text_form_field.dart';
import '../../widget/sign_widget.dart';
import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom/custom_progress_bar.dart';
import '../../widget/pop_up/agreement_pop_up.dart';
import 'sign_up_congratulation_page.dart';

class SetPasswordPage extends StatefulWidget {
  final String userEmail;
  final String userId;
  final String name;

  const SetPasswordPage(
      {Key? key,
      required this.userEmail,
      required this.name,
      required this.userId})
      : super(key: key);

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final noFocusColor = Color(0xffCED4DA);
  final darkGrayColor = Color(0xff495057);
  final mildGrayColor = Color(0xffADB5BD);

  bool _passwordFilled = false;
  bool _passwordCheckFilled = false;
  bool _passwordCheckValid = false;

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
      });
    });

    _passwordCheckFocus.addListener(() {
      setState(() {
        final formKeyState = _passwordCheckFormkey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });
  }

  String? _checkPasswordCheckValid(String? value) {
    if (_passwordCheckFocus.hasFocus) {
      _passwordCheckValid = true;
      return null;
    }
    if (password != passwordCheck) {
      return '비밀번호가 일치하지 않습니다';
    }
  }

  void _agreementPopUp() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AgreementPopUp(onAgree: signIn);
          });
        });
  }

  void signIn() async {
    bool signUpState = await ApiService.signUp(
        widget.name, widget.userEmail, password, widget.userId);

    if (signUpState) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpCongratulationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ProgressBar(progress: 3, totalProgress: 3),
        body: SignWidget(
          title: '마지막으로\n비밀번호를 설정해 주세요.',
          firstFieldText: '비밀번호',
          firstCustomForm: Form(
            key: _passwordFormkey,
            child: CustomTextFormField(
              hintText: '비밀번호를 설정해 주세요.',
              focusNode: _passwordFocus,
              isObscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                  value == ''
                      ? _passwordFilled = false
                      : _passwordFilled = true;
                });
              },
              keyboardType: TextInputType.text,
            ),
          ),
          firstGuideText: '영어, 숫자 포함 n자 이내',
          secondFieldText: '비밀번호 확인',
          secondCustomForm: Form(
            key: _passwordCheckFormkey,
            child: CustomTextFormField(
              hintText: '비밀번호를 다시 입력해 주세요.',
              focusNode: _passwordCheckFocus,
              isObscureText: true,
              onChanged: (value) {
                setState(() {
                  passwordCheck = value;
                  value == ''
                      ? _passwordCheckFilled = false
                      : _passwordCheckFilled = true;
                });
              },
              validator: (value) {
                return _checkPasswordCheckValid(value);
              },
              keyboardType: TextInputType.text,
            ),
          ),
          nextPageButton: NextPageButton(
              firstFieldState: _passwordFilled,
              secondFieldState: _passwordCheckFilled,
              text: '회원가입',
              onPressed: () {
                final formKeyState = _passwordCheckFormkey.currentState!;
                if (formKeyState.validate()) {
                  formKeyState.save();
                  _agreementPopUp();
                }
              }),
        ),
      ),
    );
  }
}
