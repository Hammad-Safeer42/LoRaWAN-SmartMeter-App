class UserProfile {
  final String fullName;
  final String meterId;
  final String accountId;
  final Map<String, dynamic> extra;
  final String uuid;
  final String email;
  final String image;

  UserProfile({
    required this.fullName,
    required this.meterId,
    required this.accountId,
    required this.extra,
    required this.uuid,
    required this.email,
    required this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json['fullName'],
      meterId: json['meterId'],
      accountId: json['accountId'],
      extra: Map<String, dynamic>.from(json['extra']),
      uuid: json['uuid'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'meterId': meterId,
      'accountId': accountId,
      'extra': extra,
      'uuid': uuid,
      'email': email,
      'image': image,
    };
  }

  static Map<String, dynamic> userProfileToJson(UserProfile userProfile) {
    return userProfile.toJson();
  }

  static UserProfile userProfileFromJson(Map<String, dynamic> json) {
    return UserProfile.fromJson(json);
  }
}
