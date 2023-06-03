import 'dart:convert';

class Tweet {
  final String? id;
  final String userImg;
  final String tweetType;
  final String? img;
  final List<String> tags;
  final String dataTime;
  final String text;
  final String? replyId;
  final String? retweetId;
  Tweet({
    required this.id,
    required this.userImg,
    required this.tweetType,
    this.img,
    required this.tags,
    required this.dataTime,
    required this.text,
    this.replyId,
    this.retweetId,
  });

  Tweet copyWith({
    String? id,
    String? userImg,
    String? tweetType,
    String? img,
    List<String>? tags,
    String? dataTime,
    String? text,
    String? replyId,
    String? retweetId,
  }) {
    return Tweet(
      id: id ?? this.id,
      userImg: userImg ?? this.userImg,
      tweetType: tweetType ?? this.tweetType,
      img: img ?? this.img,
      tags: tags ?? this.tags,
      dataTime: dataTime ?? this.dataTime,
      text: text ?? this.text,
      replyId: replyId ?? this.replyId,
      retweetId: retweetId ?? this.retweetId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      
      'userImg': userImg,
      'tweetType': tweetType,
      'img': img,
      'tags': tags,
      'dataTime': dataTime,
      'text': text,
      'replyId': replyId,
      'retweetId': retweetId,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map, String id) {
    return Tweet(
      id: id,
      userImg: map['userImg'] as String,
      tweetType: map['tweetType'] as String,
      img: map['img'] != null ? map['img'] as String : null,
      tags: List<String>.from(map['tags'] as List<String>),
      dataTime: map['dataTime'] as String,
      text: map['text'] as String,
      replyId: map['replyId'] != null ? map['replyId'] as String : null,
      retweetId: map['retweetId'] != null ? map['retweetId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tweet.fromJson(String source, String id) =>
      Tweet.fromMap(json.decode(source) as Map<String, dynamic>, id);
}

class TweetType {
  static const normal = "normal";
  static const retweet = "retweet";
  static const replay = 'replay';
}
