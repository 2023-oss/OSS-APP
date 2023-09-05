class User {
  final String authNum;
  final String publicKey;
  final String name;
  final String phone;

  User({
    required this.authNum,
    required this.publicKey,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'authNum': authNum,
      'publicKey': publicKey,
      'name': name,
      'phone': phone,
    };
  }
}
