import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/love_tweet_model.dart';
import '../data/love_tweet_data.dart';

class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(18.5),
            child: SvgPicture.asset(
              "icons/menu.svg",
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: SvgPicture.asset(
                "icons/notifications.svg",
                height: 20.44,
                width: 16.79,
              ),
            ),
          ),
        ],
        elevation: 0,
        title: Image.asset(
          "Images/LamLogo.png",
          height: 32.r,
          width: 32.r,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
              ),
              child: LoveTweet(
                loveTweetModel: LoveTweetModel(
                  isVerified: loveTweet[index]["verified"],
                  loveText: loveTweet[index]["love tweet"],
                  loveImages: loveTweet[index]["love images"],
                  name: loveTweet[index]["name"],
                  time: loveTweet[index]["time"],
                  comment: loveTweet[index]["comments"],
                  likes: loveTweet[index]["likes"],
                  username: loveTweet[index]["username"],
                  profileImage: loveTweet[index]["profile picture"],
                ),
              ),
            );
          },
          separatorBuilder: (context, int index) {
            return const Divider(
              color: Color(0xffB7B0B0),
              thickness: 0.2,
              height: 20,
            );
          },
          itemCount: loveTweet.length,
        ),
      ),
    );
  }
}

class LoveTweet extends StatelessWidget {
  const LoveTweet({Key? key, required this.loveTweetModel}) : super(key: key);
  final LoveTweetModel loveTweetModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  child: loveTweetModel.profileImage,
                  radius: 20.r,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            SizedBox(
              width: 6.w,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loveTweetModel.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      getVerifiedWidget(),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "@" + loveTweetModel.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "." + loveTweetModel.time,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    loveTweetModel.loveText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 11.2.h,
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10.r),
                  //   child: Image.asset("Images/Lam post.jpg"),
                  // ),
                  getImagesWidget(),

                  loveTweetModel.loveImages!.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: 11.2.h,
                        ),
                  Row(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(
                              "icons/favs.svg",
                              height: 13.17,
                              width: 14.27,
                            ),
                          ),
                          SizedBox(
                            width: 9.7.w,
                          ),
                          Text(
                            loveTweetModel.likes.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            width: 17.3.w,
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(
                              "icons/comment.svg",
                              height: 11.6,
                              width: 15.74,
                            ),
                          ),
                          SizedBox(
                            width: 9.7.w,
                          ),
                          Text(
                            loveTweetModel.comment!.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            width: 17.3.w,
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(
                              "icons/share.svg",
                              height: 11.6,
                              width: 15.74,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getVerifiedWidget() {
    if (loveTweetModel.isVerified) {
      return Image.asset(
        "Images/LamLogo.png",
        height: 15.r,
        width: 15.r,
      );
    } else {
      return SizedBox(
        width: 5.w,
      );
    }
  }

  Widget getImagesWidget() {
    if (loveTweetModel.loveImages!.isEmpty) {
      return const SizedBox();
    } else {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: loveTweetModel.loveImages!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: loveTweetModel.loveImages![index],
            borderRadius: BorderRadius.circular(10.r),
          );
        },
      );
    }
  }
}
