class AppBasis {
  final double unitRate;
  final String apiToken;
  final Map<String, dynamic> extra;
  final String helpAddress;
  final String email;
  final String phone;
  final String aboutLink;
  final String duplicateBill;

  AppBasis({
    required this.unitRate,
    required this.apiToken,
    required this.extra,
    required this.helpAddress,
    required this.email,
    required this.phone,
    required this.aboutLink,
    required this.duplicateBill,
  });

  factory AppBasis.fromJson(Map<String, dynamic> json) {
    return AppBasis(
      unitRate: double.parse(json['unitRate'].toString()),
      apiToken: json['apiToken'],
      extra: Map<String, dynamic>.from(json['extra']),
      helpAddress: json['helpAddress'],
      email: json['email'],
      phone: json['phone'],
      aboutLink: json['aboutLink'],
      duplicateBill: json['duplicateBill'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitRate': unitRate,
      'apiToken': apiToken,
      'extra': extra,
      'helpAddress': helpAddress,
      'email': email,
      'phone': phone,
      'aboutLink': aboutLink,
      'duplicateBill': duplicateBill,
    };
  }
}
