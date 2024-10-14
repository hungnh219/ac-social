// Name the class UserModel to avoid duplicating the name of User class
// in Firebase Authentication
class UserModel {
  final FullName fullName;
  List<String> followers;
  List<String> following;
  final SocialLinks socialLinks;

  UserModel({
    required this.fullName,
    required this.followers,
    required this.following,
    required this.socialLinks,
  });

  UserModel.newUser()
      : fullName = FullName.empty(),
        followers = [],
        following = [],
        socialLinks = SocialLinks();

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: FullName.fromMap(map['fullName']),
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      socialLinks: SocialLinks.fromMap(map['socialLinks']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName.toMap(),
      'followers': followers,
      'following': following,
      'socialLinks': socialLinks.toMap(),
    };
  }

  UserModel copyWith({
    FullName? fullName,
    List<String>? followers,
    List<String>? following,
    SocialLinks? socialLinks,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }

  int? getNumberOfFollowers() {
    return followers.length;
  }

  int? getNumberOfFollowing() {
    return following.length;
  }
}

class FullName {
  final String firstName;
  final String lastName;

  FullName({required this.firstName, required this.lastName});

  factory FullName.fromMap(Map<String, dynamic> map) {
    return FullName(
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  FullName.empty()
      : firstName = '',
        lastName = '';

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class SocialLinks {
  String? instagramLink;
  String? twitterLink;
  String? personalWebsiteLink;
  String? paypalLink;
  String? facebookLink;

  SocialLinks({
    this.instagramLink,
    this.twitterLink,
    this.personalWebsiteLink,
    this.facebookLink,
    this.paypalLink,
  });

  factory SocialLinks.fromMap(Map<String, dynamic> map) {
    return SocialLinks(
      instagramLink: map['instagramLink'],
      twitterLink: map['twitterLink'],
      personalWebsiteLink: map['personalWebsiteLink'],
      facebookLink: map['facebookLink'],
      paypalLink: map['paypalLink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'instagramLink': instagramLink,
      'twitterLink': twitterLink,
      'personalWebsiteLink': personalWebsiteLink,
      'facebookLink': facebookLink,
      'paypalLink': paypalLink,
    };
  }
}
