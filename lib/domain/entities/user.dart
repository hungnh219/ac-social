// Name the class UserModel to avoid duplicating the name of User class
// in Firebase Authentication
class UserModel {
  final String name;
  final String lastName;
  final String category;
  final String paypal;
  final String trendingPostId;
  final SocialLinks socialLinks;
  final List<String> collections;
  final List<String> followers;
  final List<String> followingUsers;

  UserModel({
    required this.name,
    required this.lastName,
    required this.category,
    required this.paypal,
    required this.trendingPostId,
    required this.collections,
    required this.followingUsers,
    required this.followers,
    required this.socialLinks,
  });

  UserModel.newUser(String categoryID)
      : name = '',
        lastName = '',
        category = categoryID,
        paypal = '',
        trendingPostId = '',
        socialLinks = SocialLinks(),
        collections = [],
        followingUsers = [],
        followers = [];


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      lastName: map['lastName'] ?? '',
      category: map['category'] ?? 'Uncategorized',
      paypal: map['paypal'] ?? '',
      trendingPostId: map['trendingPostId'] ?? '',
      collections: List<String>.from(map['collections'] ?? []),
      followers: List<String>.from(map['followers'] ?? []),
      followingUsers: List<String>.from(map['followingUsers'] ?? []),
      socialLinks: SocialLinks.fromMap(map['socialLinks'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'category': category,
      'paypal': paypal,
      'trendingPostId': trendingPostId,
      'collections': collections,
      'followers': followers,
      'followingUsers': followingUsers,
      'socialLinks': socialLinks.toMap(),
    };
  }

  UserModel copyWith({
    String? name,
    String? lastName,
    String? category,
    String? paypal,
    String? trendingPostId,
    SocialLinks? socialLinks,
    List<String>? collections,
    List<String>? followers,
    List<String>? followingUsers,
  }) {
    return UserModel(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      category: category ?? this.category,
      paypal: paypal ?? this.paypal,
      trendingPostId: trendingPostId ?? this.trendingPostId,
      socialLinks: socialLinks ?? this.socialLinks,
      collections: collections ?? this.collections,
      followers: followers ?? this.followers,
      followingUsers: followingUsers ?? this.followingUsers,
    );
  }

  int? getNumberOfFollowers() {
    return followers.length;
  }

  int? getNumberOfFollowing() {
    return followingUsers.length;
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
