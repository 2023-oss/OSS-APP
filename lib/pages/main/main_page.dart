import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ky2/components/Button.dart';
import 'package:ky2/components/TextField.dart' as ky2;
import 'package:ky2/core/base_screen.dart';
import 'package:ky2/pages/main/qr_scanner_page.dart';
import 'package:ky2/viewmodel/main_viewmodel.dart';
import 'package:ky2/components/Card.dart' as ky2;
import 'package:ky2/utils/ky2_color.dart';
import 'package:intl/intl.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<MainViewModel>(
      onModelReady: (model) {
        model.initState(context);
      },
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: _body(context, model),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,

            onPressed: () {
              Navigator.of(context).push(QRScannerPage.route());
            },
          ),
        );
      },
    );
  }
}

extension on MainPage {
  Widget _body(BuildContext context, MainViewModel model) {
    return RefreshIndicator(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        'assets/ic_notification.svg',
                        width: 24,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 18),
              const Text(
                '강은솔님의',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '개의 자격',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              model.homes.length != 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100),
                        Text(
                          '아직 발급받은 자격이 없습니다.\n평가에 응시하고 자격을 발급받으세요!',
                          style: TextStyle(
                            fontSize: 16,
                            color: ky2Color.placeholder,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : SizedBox(),
              // ...model.homes.map((e) => Column(
              //       children: [
              //         ky2.Card(
              //           title: e.issue_subject,
              //           rank: e.result,
              //           date: DateTime.now(),
              //           backgroundColor: ky2Color.primary
              //         ),
              //         const SizedBox(
              //           height: 15,
              //         )
              //       ],
              //     ))
              ky2.Card(
                  title: 'nice authentication',
                  rank: '개인정보자격',
                  date: DateTime.now(),
                  backgroundColor: ky2Color.primary),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        onRefresh: () async => model.initState(context));
  }
}
