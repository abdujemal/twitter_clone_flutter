// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String uid;
  final String email;
  final String name;
  final String userName;
  final String bio;
  final String address;
  final String joinedIn;
  final String? imgUrl;
  final bool isVerified;
  final String? backgroundImgUrl;
  final List<String>? following;
  final List<String>? followers;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.userName,
    required this.bio,
    required this.address,
    required this.joinedIn,
    required this.imgUrl,
    required this.isVerified,
    required this.backgroundImgUrl,
    required this.following,
    required this.followers,
  });

  

  Map<String, dynamic> toMap() {
    return
    following == null ?
    <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'userName': userName,
      'bio': bio,
      'address': address,
      'joinedIn': joinedIn,
      'imgUrl': imgUrl,
      'isVerified': isVerified,
      'backgroundImgUrl': backgroundImgUrl,
    }:    
     <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'userName': userName,
      'bio': bio,
      'address': address,
      'joinedIn': joinedIn,
      'imgUrl': imgUrl,
      'isVerified': isVerified,
      'backgroundImgUrl': backgroundImgUrl,
      'following': following,
      'followers': followers,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      userName: map['userName'] as String,
      bio: map['bio'] as String,
      address: map['address'] as String,
      joinedIn: map['joinedIn'] as String,
      imgUrl: map['imgUrl'] as String,
      isVerified: map['isVerified'] as bool,
      backgroundImgUrl: map['backgroundImgUrl'] as String,
      following: List<String>.from(map['following'] as List<dynamic>),
      followers: List<String>.from(map['followers'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? uid,
    String? email,
    String? name,
    String? userName,
    String? bio,
    String? address,
    String? joinedIn,
    String? imgUrl,
    bool? isVerified,
    String? backgroundImgUrl,
    List<String>? following,
    List<String>? followers,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      joinedIn: joinedIn ?? this.joinedIn,
      imgUrl: imgUrl ?? this.imgUrl,
      isVerified: isVerified ?? this.isVerified,
      backgroundImgUrl: backgroundImgUrl ?? this.backgroundImgUrl,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
