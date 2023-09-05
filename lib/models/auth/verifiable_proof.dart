import 'dart:ffi';

import 'package:ky2/models/auth/credential_subject.dart';
import 'package:ky2/models/auth/verifiable_crendential.dart';

class VerifiableProof {
  final String type;
  final String created;
  final String proofPurpose;
  final String verificationMethod;
  final String challenge;
  final String domain;
  final String jws;

  VerifiableProof({
    required this.type,
    required this.created,
    required this.proofPurpose,
    required this.verificationMethod,
    required this.challenge,
    required this.domain,
    required this.jws,
  });

  factory VerifiableProof.fromJson(Map<String, dynamic> json) {
    return VerifiableProof(
      type: json['type'],
      created: json['created'],
      proofPurpose: json['proofPurpose'],
      verificationMethod: json['verificationMethod'],
      challenge: json['challenge'],
      domain: json['domain'],
      jws: json['jws'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'created': created,
      'proofPurpose': proofPurpose,
      'verificationMethod': verificationMethod,
      'challenge': challenge,
      'domain': domain,
      'jws': jws
    };
  }
}
