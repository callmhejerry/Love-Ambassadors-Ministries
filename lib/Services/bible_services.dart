import 'package:dio/dio.dart';
import 'package:lam/Models/bible_models.dart';

class BibleService {
  static const String apiKey = "2ed9e92fce57fdbab0768a007516ebd8";
  static String version = "de4e12af7f28f599-01";
  static Dio dio = Dio();

  static Future<List<BibleVersion>?> getBibleVersions() async {
    try {
      Response response = await dio.get(
        "https://api.scripture.api.bible/v1/bibles",
        options: Options(headers: {
          "api-key": apiKey,
        }),
      );
      return BibleVersion.bibleVersionListFromJson(response.data["data"]);
    } on DioError catch (e) {
      print(e.error.toString());
      return null;
    }
  }
}
