import 'package:ky2/models/auth/user.dart';
import 'package:ky2/models/auth/verifiable_crendential.dart';

abstract class AuthAPI {
  Future<String> signIn(String id, String pwd);

  Future<void> signup(User user);

  Future<void> home(String accessToken);

  Future<void> issueList(String accessToken);

  Future<void> createBlock(String accessToken, String userId, String issueId, String record);

  Future<void> sendIdentify(String phone);

  Future<VerifiableCredential> getVerifiableCredential(String authNum, String publicKey, String name, String phone);
}
