class BibleVersion {
  final String bibleId;
  final String versionName;
  final String language;
  final String abbreviation;

  const BibleVersion({
    required this.bibleId,
    required this.abbreviation,
    required this.versionName,
    required this.language,
  });

  factory BibleVersion.fromJson(json) {
    return BibleVersion(
        bibleId: json["id"],
        abbreviation: json["abbreviation"],
        versionName: json["name"],
        language: json["language"]["nameLocal"]);
  }

  static List<BibleVersion> bibleVersionListFromJson(List<dynamic> list) {
    List<BibleVersion> bibleVersionList =
        List<BibleVersion>.from(list.map((e) => BibleVersion.fromJson(e)));

    bibleVersionList.sort(
      (a, b) {
        return a.versionName.compareTo(b.versionName);
      },
    );

    return bibleVersionList;
  }
}
