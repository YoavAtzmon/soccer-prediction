class UserLeagueProps {
  final String leagueId;
  final String leagueName;
  final String userId;
  final bool isAdmin;
  final String? leaguePhotoURL;
  // final String createdAt;

  UserLeagueProps({
    required this.leagueId,
    required this.leagueName,
    required this.userId,
    required this.isAdmin,
    this.leaguePhotoURL,
    // required this.createdAt,
  });

  factory UserLeagueProps.fromMap(Map<String, dynamic> map) {
    return UserLeagueProps(
      leagueId: map['leagueId'] ?? '',
      leagueName: map['leagueName'] ?? '',
      userId: map['userId'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      leaguePhotoURL: map['leaguePhotoURL'] ?? '',
      // createdAt: map['createdAt'] ?? '',
    );
  }
}
