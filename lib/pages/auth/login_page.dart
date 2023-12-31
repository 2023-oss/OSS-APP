import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ky2/components/Button.dart';
import 'package:ky2/components/TextField.dart' as ky2;
import 'package:ky2/core/base_screen.dart';
import 'package:ky2/core/base_viewmodel.dart';
import 'package:ky2/pages/auth/signup_page.dart';
import 'package:ky2/utils/ky2_color.dart';
import 'package:ky2/viewmodel/login_viewmodel.dart';
import 'package:ky2/viewmodel/main_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<LoginViewModel>(
      onModelReady: (model) {
        model.initState(context);
      },
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: _body(context, model),
        );
      },
    );
  }
}

extension on LoginPage {
  Widget _body(BuildContext context, LoginViewModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 82),
            Image.asset('assets/splash_logo.png', width: 238,),
            const SizedBox(height: 21),
            ky2.TextField(
              textSize: 16,
              hintText: "아이디를 입력해주세요",
              controller: model.id,
            ),
            const SizedBox(height: 14),
            ky2.TextField(
              textSize: 16,
              hintText: "비밀번호를 입력해주세요",
              controller: model.pwd,
              type: ky2.TextFieldType.password,
            ),
            const SizedBox(height: 18),
            model.state == ViewState.BUSY ? Container(
              decoration: BoxDecoration(
                color: ky2Color.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 48,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(color: ky2Color.white, strokeWidth: 2.0,),
                ),
              ),
            ) :
            Button(
              text: '로그인',
              height: 48,
              fontSize: 16,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              onPressed: () {
                model.onClickLogin(context);
              },
              positiveColors: ButtonColors(
                backgroundColor: ky2Color.primary,
                textColor: ky2Color.white,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('계정이 없으신가요'),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(SignupPage.route());
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: ky2Color.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
