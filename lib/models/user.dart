class AppUser {
  final String id;
  //final String spotifyId;
  final String displayName;
  final String? email;
  final String? avatarUrl;

  AppUser({
    required this.id,
    //required this.spotifyId,
    required this.displayName,
    this.email,
    this.avatarUrl,
  });

    factory AppUser.fromSpotify(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      displayName: json['display_name'],
      email: json['email'],
      avatarUrl: json['images']?.isNotEmpty == true
          ? json['images'][0]['url']
          : null,
    );
  }
    Map<String, dynamic> toFirestore() {
    return{
      'displayName' : displayName,
      'email' : email,
      'avatarUrl' : avatarUrl,
    };
  }
}

