import 'package:flutter/widgets.dart';

class LoveTweetModel {
  final Image? profileImage;
  final String name;
  final String username;
  final String time;
  final bool isVerified;
  final List? loveImages;
  final List? comment;
  final int likes;

  final String loveText;
  LoveTweetModel({
    this.profileImage,
    required this.isVerified,
    required this.loveText,
    required this.loveImages,
    required this.name,
    required this.time,
    required this.comment,
    required this.likes,
    required this.username,
  });
}
