class Template {
  final String responsibilityBlock;
  final String paymentBlock;
  final String personalinfoBlock;
  final String safetyBlock;
  final String etcBlock;
  final List<String> defaultBlock;

  Template({
    required this.responsibilityBlock,
    required this.paymentBlock,
    required this.personalinfoBlock,
    required this.safetyBlock,
    required this.etcBlock,
    required this.defaultBlock,
  });

  factory Template.fromJson(Map<String, dynamic> json) {
    print(json);
    return Template(
      responsibilityBlock: json['responsibilityBlock'],
      paymentBlock: json['paymentBlock'],
      personalinfoBlock: json['personalinfoBlock'],
      safetyBlock: json['safetyBlock'],
      etcBlock: json['etcBlock'],
      defaultBlock: List.from(json['defaultBlock']),
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
