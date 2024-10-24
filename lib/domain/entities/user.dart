// Name the class UserModel to avoid duplicating the name of User class
// in Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String lastName;
  final String location;
  final String category;
  final String avatar;
  bool emailChanged;
  final Map<String, String> socialAccounts;

  UserModel({
    required this.name,
    required this.lastName,
    required this.location,
    required this.category,
    required this.avatar,
    required this.email,
    required this.socialAccounts,
    this.emailChanged = false,
  });

  UserModel.newUser(String categoryID, String? userAvatar, String? userEmail)
      : name = '',
        lastName = '',
        location = '',
        emailChanged = false,
        category = categoryID,
        avatar = userAvatar!,
        email = userEmail!,
        socialAccounts = {};

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      emailChanged: false,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      lastName: map['lastname'] ?? '',
      location: map['location'] ?? '',
      category: map['category'] is DocumentReference // Checking if it's a single DocumentReference
          ? (map['category'] as DocumentReference).id // Convert the reference to a list containing the ID
          : '', // Default to an empty list if it's not a reference
      avatar: map['avatar'] ?? '',
      socialAccounts: Map<String, String>.from(map['socials'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastName,
      'email': email,
      'location': location,
      'category': category,
      'avatar': avatar,
      'socials': socialAccounts,
    };
  }

  UserModel copyWith({
    String? name,
    String? newEmail,
    String? lastName,
    String? location,
    String? category,
    String? avatar,
    Map<String, String>? socialAccounts,
    List<String>? followers,
    List<String>? followingUsers,
  }) {
    if(newEmail != null && newEmail != email){
      this.emailChanged = true;
    }
    return UserModel(
      emailChanged: emailChanged,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      category: category ?? this.category,
      socialAccounts: socialAccounts ?? this.socialAccounts,
      email: newEmail ?? this.email,
    );
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

  Map<String, String?> toMap() {
    return {
      'instagramLink': instagramLink,
      'twitterLink': twitterLink,
      'personalWebsiteLink': personalWebsiteLink,
      'facebookLink': facebookLink,
      'paypalLink': paypalLink,
    };
  }
}
