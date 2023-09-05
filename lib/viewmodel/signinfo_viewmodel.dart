import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ky2/core/base_viewmodel.dart';
import 'package:ky2/models/auth/verifiable_crendential.dart';
import 'package:ky2/pages/auth/bio_auth_page.dart';
import 'package:ky2/pages/auth/login_page.dart';
import 'package:ky2/pages/auth/signinfo_page.dart';
import 'package:ky2/services/api/auth/auth_service.dart';

import '../models/auth/user.dart';
import '../utils/secp256k1.dart';

class SignInfoViewModel extends BaseViewModel {
  String? id;
  String? pwd;
  String? name;
  String? className;
  String? phone;
  final TextEditingController authNum = TextEditingController();

  void initState(
    BuildContext context,
    String _id,
    String _pwd,
    String _name,
    String _phone,
    String _className,
  ) async {
    print(_id);
    print(_pwd);
    print(_name);
    print(_phone);
    print(_className);
    id = _id;
    pwd = _pwd;
    name = _name;
    phone = _phone;
    className = _className;
    setState(ViewState.IDLE);
  }

  void onClickNext(BuildContext context) async {
    print(id);
    print(pwd);
    print(name);
    print(phone);
    print(className);
    if (id != null &&
        pwd != null &&
        name != null &&
        phone != null &&
        className != null) {
      try {
        setState(ViewState.BUSY);

        final storage = new FlutterSecureStorage();
        bool isPrivateKey = await storage.containsKey(key: 'rsa');

        if (!isPrivateKey) {
          var result = await RSA.generate(2048);

          await storage.write(key: 'rsa', value: result.privateKey);

          VerifiableCredential verifiableCredential = await authService.getVerifiableCredential(authNum.value.text,
              result.publicKey, name ?? '', phone ?? '');

          await storage.write(key: 'vc', value: jsonEncode(verifiableCredential.toJson()));
        }else{
          String privateKey = await storage.read(key: 'rsa') ?? '';
          String publicKey = await RSA.convertPrivateKeyToPublicKey(privateKey);

          VerifiableCredential verifiableCredential = await authService.getVerifiableCredential(authNum.value.text,
              publicKey, name ?? '', phone ?? '');

          await storage.write(key: 'vc', value: jsonEncode(verifiableCredential.toJson()));
        }

        setState(ViewState.IDLE);
        Navigator.of(context).push(BioAuthPage.route());

      } on DioError catch (e) {
        print(e);
      }
    } else {
      print('???');
    }
  }
}
