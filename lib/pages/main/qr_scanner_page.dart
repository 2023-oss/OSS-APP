import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ky2/components/Button.dart';
import 'package:ky2/components/TextField.dart' as ky2;
import 'package:ky2/core/base_screen.dart';
import 'package:ky2/viewmodel/qr_scanner_viewmodel.dart';
import 'package:ky2/viewmodel/main_viewmodel.dart';
import 'package:ky2/components/Card.dart' as ky2;
import 'package:ky2/utils/ky2_color.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const QRScannerPage());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<QRScannerViewModel>(
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

extension on QRScannerPage {
  Widget _body(BuildContext context, QRScannerViewModel model) {
    return RefreshIndicator(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            Expanded(flex: 4, child: model.buildQrView(context)),
          ],
        ),
      ),
      onRefresh: () async => model.initState(context),
    );
  }
}
