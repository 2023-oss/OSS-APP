import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ky2/core/base_viewmodel.dart';
import 'package:ky2/pages/auth/login_page.dart';
import 'package:ky2/pages/auth/signinfo_page.dart';

import '../services/api/auth/auth_service.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController id = TextEditingController();
  final TextEditingController pwd = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController className = TextEditingController();

  void initState(BuildContext context) async {}

  void onClickNext(BuildContext context) async {
    await authService.sendIdentify(phone.value.text);

    Navigator.of(context).push(SigninfoPage.route(
      id: id.value.text,
      pwd: pwd.value.text,
      name: name.value.text,
      phone: phone.value.text,
      className: className.value.text,
    ));
  }
}
