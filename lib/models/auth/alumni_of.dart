import 'dart:ffi';

class AlumniOf {
  final String id;
  final String name;
  final String phone;


  AlumniOf({
    required this.id, required this.name, required this.phone,
  });

factory AlumniOf.fromJson(Map<String, dynamic> json) {
  return AlumniOf(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
  );
}

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'phone': phone,
    'name': name,
  };
}
}
