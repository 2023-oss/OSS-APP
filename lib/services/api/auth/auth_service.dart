import 'package:dio/dio.dart';
import 'package:ky2/models/auth/issue.dart';
import 'package:ky2/models/auth/user.dart';
import 'package:ky2/models/auth/verifiable_crendential.dart';
import 'package:ky2/models/auth/verifiable_presentation.dart';
import 'package:ky2/models/home/home.dart';
import 'package:ky2/models/home/template.dart';
import 'package:ky2/services/api/auth/auth_api.dart';
import 'package:ky2/services/api/service.dart';

final _AuthService authService = _AuthService();

class _AuthService extends APIService with AuthAPI {
  @override
  Future<String> signIn(String id, String pwd) async {
    Response res =
        await dio.post('/auth/signin/', data: {'id': id, 'pwd': pwd});

    return res.data['token'];
  }

  @override
  Future<void> signup(User user) async {
    Response res = await dio.post('/auth/signup/', data: user.toJson());
  }

  @override
  Future<List<Home>> home(String accessToken) async {
    Response res = await dio.get('/home',
        options: Options(headers: {"Authorization": accessToken}));
    print('머임' );
    print(res.data['testList'] );
    return (res.data['usersData'] as List)
        .map((e) => Home.fromJson(e))
        .toList();
  }

  @override
  Future<void> createBlock(
      String accessToken, String userId, String issueId, String record) async {
    Response res = await dio.post(
      '/block/push',
      options: Options(headers: {"Authorization": accessToken}),
      data: {
        'record': record,
        'user': userId,
        'issue_id': issueId,
      },
    );
  }

  @override
  Future<List<Issue>> issueList(String accessToken)async {
    Response res = await dio.get('/home',
        options: Options(headers: {"Authorization": accessToken}));

    return (res.data['testList'] as List)
        .map((e) => Issue.fromJson(e))
        .toList();
  }

  @override
  Future<void> sendIdentify(String phone) async{
    Response res = await dio.post(
      '/auth/identify',
      // options: Options(headers: {"Authorization": accessToken}),
      data: {
        'to': phone,
      },
    );
    print("phone auth");
    print(res.data);
  }

  @override
  Future<VerifiableCredential> getVerifiableCredential(String authNum, String publicKey, String name, String phone) async{
    Response res = await dio.post(
      '/auth/issue/vc',
      // options: Options(headers: {"Authorization": accessToken}),
      data: {
        'authNum': authNum,
        'publicKey': publicKey,
        'name': name,
        'phone': phone
      },
    );

    return VerifiableCredential.fromJson(res.data);
  }

  @override
  Future<void> registerForm(VerifiablePresentation verifiablePresentation, String form) async{
    Response res = await orgDio.post(
      '/form/register/c8a632bf-1a20-4b94-8857-f41bf7335708',
      data: {
        'vp': verifiablePresentation.toJson(),
        'form': 'form'
      },
    );

    print(res.data);
  }

  @override
  Future<Template> viewTemplate(String did) async{
    Response res = await orgDio.get(
      '/template/view/$did',
    );

    return Template.fromJson(res.data);
  }
}
