import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:ky2/core/base_viewmodel.dart';
import 'package:ky2/models/auth/verifiable_crendential.dart';
import 'package:ky2/models/auth/verifiable_presentation.dart';
import 'package:ky2/models/auth/verifiable_proof.dart';
import 'package:ky2/models/home/home.dart';
import 'package:ky2/models/home/template.dart';
import 'package:ky2/services/api/auth/auth_service.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';


class FormSubmitViewModel extends BaseViewModel {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  void initState(BuildContext context) async {

  }

  void setVC() {
    print("ddd");
    name.value = TextEditingValue(
      text: '박박박'
    );
    phone.value = TextEditingValue(
        text: '01011111111'
    );
    setState(ViewState.IDLE);
  }
}
