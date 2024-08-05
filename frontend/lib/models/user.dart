class UserProps {
  final String displayName;
  final String email;
  final String photoUrl;
  final List<String> leagues;

  UserProps({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.leagues,
  });

  factory UserProps.fromMap(Map<String, dynamic> map) {
    return UserProps(
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      leagues: List<String>.from(map['leagues'] ?? []),
    );
  }
}
