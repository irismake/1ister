import 'package:flutter/material.dart';
import 'package:lister/services/api_service.dart';

import '../../widget/custom/custom_text_form_field.dart';
import '../../widget/join_widget.dart';
import '../../widget/custom/custom_next_page_button.dart';
import '../../widget/custom/custom_progress_bar.dart';
import 'set_password_page.dart';

class SetIdNamePage extends StatefulWidget {
  final String userEmail;

  const SetIdNamePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<SetIdNamePage> createState() => _SetIdNamePageState();
}

class _SetIdNamePageState extends State<SetIdNamePage> {
  // final noFocusColor = Color(0xffCED4DA);
  // final darkGrayColor = Color(0xff495057);
  // final mildGrayColor = Color(0xffADB5BD);

  bool _userIdState = false;
  bool _nameState = false;
  bool _userIdValid = false;

  FocusNode _userIdFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();

  final _userIdFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();

  String userId = '';
  String name = '';

  @override
  void initState() {
    super.initState();

    _userIdFocus.addListener(() {
      setState(() {
        final formKeyState = _userIdFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });

    _nameFocus.addListener(() {
      setState(() {
        final formKeyState = _nameFormKey.currentState!;
        if (formKeyState.validate()) {
          formKeyState.save();
        }
      });
    });
  }

  String? _checknameValid(String? value) {
    if (_nameFocus.hasFocus) {
      return null;
    }
    if (!_userIdValid) {
      //_nameState = true;
      print('valid 출력');
      return '이미 사용중인 아이디 입니다.';
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
        appBar: ProgressBar(progress: 2, totalProgress: 3),
        body: JoinWidget(
            title: '사용자 아이디와\n이름을 정해주세요.',
            firstFieldText: '사용자 아이디',
            firstCustomForm: Form(
              key: _userIdFormKey,
              child: CustomTextFormField(
                hintText: '사용자 아이디를 설정해 주세요.',
                focusNode: _userIdFocus,
                onChanged: (value) {
                  setState(() {
                    userId = value!;
                    value == '' ? _userIdState = false : _userIdState = true;
                  });
                },
                validator: (value) {
                  _checknameValid(value!);
                },
                keyboardType: TextInputType.name,
              ),
            ),
            firstGuideState: true,
            firstGuideText: '영어, 숫자 포함 n자 이내',
            secondFieldText: '이름',
            secondCustomForm: Form(
              key: _nameFormKey,
              child: CustomTextFormField(
                hintText: '이름을 설정해 주세요.',
                focusNode: _nameFocus,
                onChanged: (value) {
                  setState(() {
                    name = value!;
                    value == '' ? _nameState = false : _nameState = true;
                  });
                },
                validator: (value) {},
                keyboardType: TextInputType.name,
              ),
            ),
            secondGuideState: true,
            secondGuideText: '한국어, 영어, 일본어 n자 이내',
            authenticationState: false,
            authenticationButton: null,
            timer: null,
            nextPageButton: NextPageButton(
              firstFieldState: _userIdState,
              secondFieldState: _nameState,
              text: '다음',
              onPressed: () async {
                if (_userIdState && _nameState) {
                  final formKeyState = _nameFormKey.currentState!;
                  if (formKeyState.validate()) {
                    formKeyState.save();
                    _userIdValid = await ApiService.checkname(userId);
                    if (_userIdValid) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetPasswordPage(
                                  userEmail: widget.userEmail,
                                  userId: userId,
                                  name: name)));
                    }
                  }
                }
              },
            )),
      ),
    );
  }
}
