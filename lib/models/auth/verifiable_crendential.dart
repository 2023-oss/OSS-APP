import 'dart:ffi';

import 'package:ky2/models/auth/credential_subject.dart';

class VerifiableCredential {
  final CredentialSubject credentialSubject;
  final String id;
  final List<String> type;
  final List<String> context;

  VerifiableCredential({
    required this.credentialSubject,
    required this.id,
    required this.type,
    required this.context,
  });

  factory VerifiableCredential.fromJson(Map<String, dynamic> json) {

    return VerifiableCredential(
        credentialSubject: CredentialSubject.fromJson(json['credentialSubject']),
        id: json['id'],
        type: (List<String>.from(json['type'])),
        context: (List<String>.from(json['@context'])),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'credentialSubject': credentialSubject.toJson(),
      'id': id,
      'type': type,
      '@context': context,
    };
  }
}
