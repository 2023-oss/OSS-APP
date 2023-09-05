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
import 'package:ky2/pages/main/form_submit_page.dart';
import 'package:ky2/services/api/auth/auth_service.dart';
import 'package:ky2/utils/secp256k1.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class QRScannerViewModel extends BaseViewModel {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    // super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController qrViewController){
        onQRViewCreated(qrViewController, context);
      },
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }


  void onQRViewCreated(QRViewController controller, BuildContext context)  {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData)async {
      setState(ViewState.BUSY);


      print(scanData.code);
      controller!.stopCamera();

      Template template = await authService.viewTemplate(scanData.code ?? '');



      Navigator.of(context).push(FormSubmitPage.route(template));
      setState(ViewState.IDLE);
    });
  }


  void initState(BuildContext context) async {

  }
}
