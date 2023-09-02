import 'dart:ffi';

import 'package:ky2/models/auth/alumni_of.dart';

class CredentialSubject {
  final AlumniOf alumniOf;

  CredentialSubject({
    required this.alumniOf,
  });

factory CredentialSubject.fromJson(Map<String, dynamic> json) {
  return CredentialSubject(
    alumniOf: AlumniOf.fromJson(json['alumniOf']),
  );
}

Map<String, dynamic> toJson() {
  return {
    'alumniOf': alumniOf,
  };
}
}
