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
    phone: json['phone'],
    name: json['name'],
    id: json['id'],
  );
}

Map<String, dynamic> toJson() {
  return {
    'phone': phone,
    'name': name,
    'id': id,
  };
}
}
