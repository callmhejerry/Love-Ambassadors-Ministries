import 'dart:async';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lam/Models/bible_models.dart';
import 'package:lam/Screens/loginPage.dart';
import 'package:lam/Services/bible_services.dart';
import 'package:lam/constant.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lam/firebase/fire_base_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'Screens/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("First time", true);
  runApp(
    MyApp(
      sharedPreferences: prefs,
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () {
        return MaterialApp(
          title: 'Lam',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            fontFamily: "Nunito",
          ),
          home: const Bible(),
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        );
      },
    );
  }
}

class HomeController extends StatefulWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  void initState() {
    Future(() async {
      await AuthService.firebaseAuth.currentUser?.reload();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.authState(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Text("No internet connection"),
          );
        }
        if (snapshot.data != null && snapshot.data!.emailVerified) {
          return const DiscoverScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 28.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: const SearchBar(),
              ),
              SizedBox(height: 40.h),
              const DiscoverCartegory(
                cartegoryName: "Devotions",
              ),
              SizedBox(height: 30.h),
              const DiscoverCartegory(
                cartegoryName: "Books",
              ),
              SizedBox(height: 30.h),
              const DiscoverCartegory(
                cartegoryName: "New creation",
              ),
              SizedBox(height: 30.h),
              Emotions(),
            ],
          ),
        ),
      ),
    );
  }
}

class Emotions extends StatelessWidget {
  final List<String> emotions = [
    "Anger",
    "Depression",
    "Guilt",
    "Anxious",
    "Fear",
    "Confused",
    "Lost",
    "Love",
    "Worried",
    "Temptaion",
  ];

  Emotions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Emotions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    const Text(
                      "SEE ALL",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    SizedBox(
                      width: 9.2.w,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 12,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              mainAxisExtent: 52,
              crossAxisSpacing: 17,
            ),
            itemCount: emotions.length,
            itemBuilder: (context, int index) {
              return Container(
                height: 44,
                alignment: Alignment.center,
                child: Text(
                  emotions[index],
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class DiscoverCartegory extends StatelessWidget {
  final String cartegoryName;
  const DiscoverCartegory({Key? key, required this.cartegoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cartegoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    const Text(
                      "SEE ALL",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    SizedBox(
                      width: 9.2.w,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 12,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0.w),
            child: Row(
              children: [
                Container(
                  height: 90.r,
                  width: 90.r,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage("Images/Lam post.jpg"),
                    ),
                  ),
                ),
                Container(
                  height: 90.r,
                  width: 90.r,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage("Images/Lam post.jpg"),
                    ),
                  ),
                ),
                Container(
                  height: 90.r,
                  width: 90.r,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage("Images/Lam post.jpg"),
                    ),
                  ),
                ),
                Container(
                  height: 90.r,
                  width: 90.r,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage("Images/Lam post.jpg"),
                    ),
                  ),
                ),
                Container(
                  height: 90.r,
                  width: 90.r,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage("Images/Lam post.jpg"),
                    ),
                  ),
                ),
                Container(
                  height: 90.r,
                  width: 90.r,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage("Images/Lam post.jpg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        color: Colors.white.withOpacity(0.02),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Search anything",
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(.4),
            fontSize: 12,
          ),
          border: InputBorder.none,
          // filled: true,
          prefixIcon: const Icon(
            Icons.search,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Bible extends StatelessWidget {
  const Bible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: BibleService.getBibleVersions(),
        builder: (context, AsyncSnapshot<List<BibleVersion>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text(
              "no connection....",
              style: TextStyle(color: Colors.white),
            );
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    snapshot.data![index].versionName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    snapshot.data![index].abbreviation,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    snapshot.data![index].language,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Oops,something went wrong 😓",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
