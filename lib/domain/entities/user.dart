// Name the class UserModel to avoid duplicating the name of User class
// in Firebase Authentication
class UserModel {
  final String name;
  final String lastName;
  final String location;
  final String category;
  final String avatar;
  final Map<String, String> socialAccounts;
  final List<String> popularPosts;
  final List<String> followers;
  final List<String> followingUsers;

  UserModel({
    required this.name,
    required this.lastName,
    required this.location,
    required this.category,
    required this.avatar,
    required this.socialAccounts,
    required this.followers,
    required this.followingUsers,
    required this.popularPosts,
  });

  UserModel.newUser(String categoryID, String userAvatar)
      : name = '',
        lastName = '',
        location = '',
        category = categoryID,
        avatar = userAvatar, // Khởi tạo avatar
        socialAccounts = {},
        followers = [],
        followingUsers = [],
        popularPosts = [];

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      lastName: map['lastname'] ?? '',
      location: map['location'] ?? '',
      category: map['category'] is DocumentReference // Checking if it's a single DocumentReference
          ? (map['category'] as DocumentReference).id // Convert the reference to a list containing the ID
          : '', // Default to an empty list if it's not a reference
      avatar: map['avatar'] ?? '',
      socialAccounts: Map<String, String>.from(map['socials'] ?? {}),
      followers: (map['followers'] as List<dynamic>?)
          ?.map((ref) => (ref as DocumentReference).id)
          .toList() ??
          [],
      followingUsers: (map['followingUsers'] as List<dynamic>?)
          ?.map((ref) => (ref as DocumentReference).id)
          .toList() ??
          [],
      popularPosts: (map['popular_posts'] as List<dynamic>?)
          ?.map((ref) => (ref as DocumentReference).id)
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastName,
      'location': location,
      'category': category,
      'avatar': avatar,
      'socialAccounts': socialAccounts,
      'followers': followers,
      'followingUsers': followingUsers,
      'popular_posts': popularPosts,
    };
  }

  UserModel copyWith({
    String? name,
    String? lastName,
    String? location,
    String? category,
    String? avatar, // Thêm avatar vào copyWith
    Map<String, String>? socialAccounts, // Cập nhật tên trường
    List<String>? followers,
    List<String>? followingUsers,
    List<String>? popularPosts, // Cập nhật tên trường
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      category: category ?? this.category,
      avatar: avatar ?? this.avatar,
      socialAccounts: socialAccounts ?? this.socialAccounts,
      followers: followers ?? this.followers,
      followingUsers: followingUsers ?? this.followingUsers,
      popularPosts: popularPosts ?? this.popularPosts,
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
