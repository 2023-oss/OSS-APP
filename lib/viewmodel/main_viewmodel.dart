import 'package:dio/dio.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:ky2/core/base_viewmodel.dart';
import 'package:ky2/models/auth/verifiable_crendential.dart';
import 'package:ky2/models/auth/verifiable_presentation.dart';
import 'package:ky2/models/auth/verifiable_proof.dart';
import 'package:ky2/models/home/home.dart';
import 'package:ky2/services/api/auth/auth_service.dart';
import 'package:ky2/utils/secp256k1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainViewModel extends BaseViewModel {
  List<Home> homes = [];

  get storage => null;

  void onRegisterForm(BuildContext context) async {
    final storage = new FlutterSecureStorage();

    String vcString = await storage.read(key: 'vc') ?? '';

    Map<String, dynamic> vcJson = jsonDecode(vcString);


    vcString = vcString.replaceAll('\n', '');
    vcString = vcString.replaceAll(' ', '');
    // vcString = vcString.replaceAll('"', '');
    // vcString = vcString.replaceAll('/', '');
    print(vcString);

    VerifiableCredential verifiableCredential =
        VerifiableCredential.fromJson(vcJson);
    print("========DID========");
    List<int> byteList = utf8.encode(vcString.toString());
    Uint8List bytes = Uint8List.fromList(byteList);

    String privateKey = await storage.read(key: 'rsa') ?? '';

    var result = await RSA.signPKCS1v15Bytes(bytes, Hash.SHA256, privateKey);
    var jws = base64Encode(result);

    VerifiablePresentation verifiablePresentation = VerifiablePresentation(
      verifiableCredential: [verifiableCredential],
      id: "http://example.edu/credentials/1872",
      type: 'VerifiableCredential',
      context: [
        "https://www.w3.org/2018/credentials/v1",
        "https://www.w3.org/2018/credentials/examples/v1"
      ],
      proof: VerifiableProof(
        type: 'RsaSignature2018',
        created: '2017-06-18T21:19:10Z',
        proofPurpose: 'assertionMethod',
        verificationMethod: 'https://example.edu/issuers/565049#key-1',
        challenge: "1",
        domain: "1",
        jws: jws.replaceAll('\n', ''),
      ),
    );

    try{
      await authService.registerForm(verifiablePresentation, 'form');
    }  on DioError catch (e) {
      print(e.response);
    }
  }

  void initState(BuildContext context) async {
    // var prefs = await SharedPreferences.getInstance();
    // String accessToken = prefs.getString('accessToken') ?? "";
    // try{
    //   homes = await authService.home(accessToken);
    //
    //   setState(ViewState.IDLE);
    // } on DioError catch(e){
    //   print(e);
    // }
  }
}
