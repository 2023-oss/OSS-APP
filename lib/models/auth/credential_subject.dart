import 'dart:ffi';

import 'package:ky2/models/auth/alumni_of.dart';

class CredentialSubject {
  final AlumniOf alumniOf;
  final String id;
  CredentialSubject({
    required this.id,
    required this.alumniOf,
  });

factory CredentialSubject.fromJson(Map<String, dynamic> json) {
  return CredentialSubject(
    alumniOf: AlumniOf.fromJson(json['alumniOf']),
    id: json['id'],
  );
}

Map<String, dynamic> toJson() {
  return {
    'alumniOf': alumniOf.toJson(),
    'id': id,
  };
}
}
