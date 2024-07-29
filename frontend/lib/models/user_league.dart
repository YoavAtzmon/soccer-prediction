class UserLeagueProps {
  final String leagueId;
  final String leagueName;
  final String userId;
  final String? leaguePhotoURL;
  // final String createdAt;

  UserLeagueProps({
    required this.leagueId,
    required this.leagueName,
    required this.userId,
    // required this.createdAt,
    this.leaguePhotoURL,
    // Add other required properties
  });

  factory UserLeagueProps.fromMap(Map<String, dynamic> map) {
    return UserLeagueProps(
      leagueId: map['leagueId'] ?? '',
      leagueName: map['leagueName'] ?? '',
      userId: map['userId'] ?? '',
      // createdAt: map['createdAt'] ?? '',
      leaguePhotoURL: map['leaguePhotoURL'] ?? '',
      // Parse other properties, handling potential null values
    );
  }
}
