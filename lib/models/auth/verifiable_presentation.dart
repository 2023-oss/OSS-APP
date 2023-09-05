import 'dart:ffi';

import 'package:ky2/models/auth/credential_subject.dart';
import 'package:ky2/models/auth/verifiable_crendential.dart';
import 'package:ky2/models/auth/verifiable_proof.dart';

class VerifiablePresentation {
  final List<VerifiableCredential> verifiableCredential;
  final String id;
  final String type;
  final List<String> context;
  final VerifiableProof proof;

  VerifiablePresentation({
    required this.proof,
    required this.verifiableCredential,
    required this.id,
    required this.type,
    required this.context,
  });

  factory VerifiablePresentation.fromJson(Map<String, dynamic> json) {
    return VerifiablePresentation(
        verifiableCredential: (json['verifiableCredential'] as List).map((e) => VerifiableCredential.fromJson(e)).toList(),
        id: json['id'],
        type: json['type'],
        context: (List<String>.from(json['@context'])),
        proof: VerifiableProof.fromJson(json['proof'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      '@context': context,
      'verifiableCredential': verifiableCredential.map((e) => e.toJson()).toList(),
      'proof': proof.toJson()
    };
  }
}
