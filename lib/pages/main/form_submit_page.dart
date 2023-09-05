import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ky2/components/Button.dart';
import 'package:ky2/components/TextField.dart' as ky2;
import 'package:ky2/core/base_screen.dart';
import 'package:ky2/models/home/template.dart';
import 'package:ky2/viewmodel/form_submit_viewmodel.dart';
import 'package:ky2/viewmodel/qr_scanner_viewmodel.dart';
import 'package:ky2/viewmodel/main_viewmodel.dart';
import 'package:ky2/components/Card.dart' as ky2;
import 'package:ky2/utils/ky2_color.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';

class FormSubmitPage extends StatelessWidget {
  final Template template;

  const FormSubmitPage({Key? key, required this.template}) : super(key: key);

  static Route route(Template template) {
    return MaterialPageRoute<void>(
        builder: (_) => FormSubmitPage(
              template: template,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<FormSubmitViewModel>(
      onModelReady: (model) {
        model.initState(context);
        Future.delayed(Duration(seconds: 0)).then((_) {
          _settingModalBottomSheet(context, model);
        });
      },
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: _body(context, model),
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        );
      },
    );
  }
}

extension on FormSubmitPage {
  Widget _body(BuildContext context, FormSubmitViewModel model) {
    return RefreshIndicator(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '더 클라임',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '개인정보 동의서',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  template.paymentBlock.replaceAll('<br/>', ''),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ky2Color.subText,
                  ),
                ),
                Text(
                  template.personalinfoBlock.replaceAll('<br/>', ''),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ky2Color.subText,
                  ),
                ),
                Text(
                  template.etcBlock,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ...template.defaultBlock.map(
                  (String e) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: ky2.TextField(
                      labelText: e,
                      controller: e == '이름' ? model.name : (e == '전화번호' ? model.phone : null),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: Colors.black,
                      checkColor: ky2Color.white,
                      value: true,
                      onChanged: (isChecked) => {},
                    ),
                    Text('위 내용을 모두 이해하고 동의합니다.'),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 48,
            right: 24,
            left: 24,
            child: Container(
              child: Button(
                text: '제출하기',
                height: 48,
                fontSize: 16,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                onPressed: () {
                  // _settingModalBottomSheet(context, model);
                },
                positiveColors: ButtonColors(
                  backgroundColor: ky2Color.primary,
                  textColor: ky2Color.white,
                ),
              ),
            ),
          )
        ],
      ),
      onRefresh: () async => model.initState(context),
    );
  }

  void _settingModalBottomSheet(context, FormSubmitViewModel model) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder( // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.all(24),
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 0),
                Text(
                  '자격 선택',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '동의서에 제출할 자격을 선택해주세요',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    model.setVC();
                    Navigator.pop(context);

                  },
                  child: ky2.Card(
                      title: 'nice authentication',
                      rank: '개인정보자격',
                      date: DateTime.now(),
                      backgroundColor: ky2Color.primary
                  ),
                ),

              ],
            ),
          );
        });
  }
}
