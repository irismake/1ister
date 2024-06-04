import 'package:flutter/material.dart';
import 'package:lister/services/api_service.dart';

import '../../components/custom_ui_kit/custom_next_page_button.dart';
import '../../components/custom_ui_kit/custom_progress_bar.dart';
import '../../components/custom_ui_kit/custom_text_form_field.dart';
import '../../components/widget/sign_widget.dart';
import 'set_password_page.dart';

class SetIdNamePage extends StatefulWidget {
  final String userEmail;

  const SetIdNamePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<SetIdNamePage> createState() => _SetIdNamePageState();
}

class _SetIdNamePageState extends State<SetIdNamePage> {
  bool _userIdFilled = false;
  bool _nameFilled = false;
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

  @override
  void dispose() {
    _userIdFocus.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  String? _checknameValid(String? value) {
    if (_userIdFocus.hasFocus) {
      _userIdValid = true;
      return null;
    }
    if (!_userIdValid && _userIdFilled) {
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
        body: SignWidget(
            title: '사용자 아이디와\n이름을 정해주세요.',
            firstFieldText: '사용자 아이디',
            firstCustomForm: Form(
              key: _userIdFormKey,
              child: CustomTextFormField(
                hintText: '사용자 아이디를 설정해 주세요.',
                focusNode: _userIdFocus,
                onChanged: (value) {
                  setState(() {
                    userId = value;
                    value == '' ? _userIdFilled = false : _userIdFilled = true;
                  });
                },
                validator: (value) {
                  return _checknameValid(value!);
                },
                keyboardType: TextInputType.name,
              ),
            ),
            firstGuideText: '영어, 숫자 포함 n자 이내',
            secondFieldText: '이름',
            secondCustomForm: Form(
              key: _nameFormKey,
              child: CustomTextFormField(
                hintText: '이름을 설정해 주세요.',
                focusNode: _nameFocus,
                onChanged: (value) {
                  setState(() {
                    name = value;
                    value == '' ? _nameFilled = false : _nameFilled = true;
                  });
                },
                keyboardType: TextInputType.name,
              ),
            ),
            secondGuideText: '한국어, 영어, 일본어 n자 이내',
            nextPageButton: NextPageButton(
              firstFieldState: _userIdFilled,
              secondFieldState: _nameFilled,
              text: '다음',
              onPressed: () async {
                if (_userIdFilled && _nameFilled) {
                  _userIdValid =
                      await ApiService.checkDuplicateUserName(userId);
                  final formKeyState = _userIdFormKey.currentState!;
                  if (formKeyState.validate()) {
                    formKeyState.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetPasswordPage(
                            userEmail: widget.userEmail,
                            userId: userId,
                            name: name),
                      ),
                    );
                  }
                }
              },
            )),
      ),
    );
  }
}
