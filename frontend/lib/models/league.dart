class LeagueProps {
  String leagueId;
  String leagueName;
  String userId;
  List<Object?> admins;
  bool withPayment;
  String? paymentLink;
  String? leaguePhotoURL;

  LeagueProps({
    required this.leagueId,
    required this.leagueName,
    required this.userId,
    required this.admins,
    required this.withPayment,
    this.paymentLink,
    this.leaguePhotoURL,
  });
  factory LeagueProps.fromMap(Map<String, dynamic> map) {
    return LeagueProps(
      leagueId: map['leagueId'] ?? '',
      leagueName: map['leagueName'] ?? '',
      userId: map['userId'] ?? '',
      admins: map['admins'] ?? [],
      leaguePhotoURL: map['leaguePhotoURL'] ?? '',
      withPayment: map['withPayment'] ?? false,
      paymentLink: map['paymentLink'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'leagueName': leagueName,
      'withPayment': withPayment,
      'paymentLink': paymentLink,
      'leaguePhotoURL': leaguePhotoURL,
      'admins': admins,
      'userId': userId,
      'leagueId': leagueId,
    };
  }
}
