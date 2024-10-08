// Name the class MyUser to avoid duplicating the name of User class
// in Firebase Authentication
class MyUser {
  final FullName fullName;
  final Map<String, bool> followers;
  final Map<String, bool> following;
  final SocialLinks socialLinks;

  MyUser({
    required this.fullName,
    required this.followers,
    required this.following,
    required this.socialLinks,
  });

  MyUser.newUser()
      : fullName = FullName.empty(),
        followers = {},
        following = {},
        socialLinks = SocialLinks();

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
        fullName: map['fullName'], followers: map['followers'], following: map['following'], socialLinks: map['socialLinks']);
  }

  // Map<String, dynamic> toMap() {
  //   return {'fullname': fullname, 'isMale': isMale, 'isDarkTheme': isDarkTheme};
  // }

  // MyUser copyWith({String? fullname, bool? isMale, bool? isDarkTheme}) {
  //   return MyUser(
  //       fullname: fullname ?? this.fullname,
  //       isMale: isMale ?? this.isMale,
  //       isDarkTheme: isDarkTheme ?? this.isDarkTheme);
  // }
}

class FullName {
  final String firstName;
  final String lastName;

  FullName({required this.firstName, required this.lastName});

  FullName.empty()
      : firstName = '',
        lastName = '';
}

class SocialLinks {
  String? instagramLink;
  String? twitterLink;
  String? personalWebsiteLink;
  String? paypalLink;
  String? facebookLink;

  SocialLinks(
      {this.instagramLink,
      this.twitterLink,
      this.personalWebsiteLink,
      this.facebookLink,
      this.paypalLink});
}
