class AyahModel {
  int? ayahNumber;
  String? ayahText;
  String? ayahSurah;
  String? source;
  AyahModel(
      {required this.ayahText,
      required this.source,
      required this.ayahNumber,
      required this.ayahSurah});
  AyahModel.fromJson(Map<String, dynamic> json) {
    ayahText = json['text'];
    source = json['edition']['identifier'];
    ayahNumber = json['numberInSurah'];
    ayahSurah = json['surah']['name'];
  }
}
// {
// "number": 131,
// "text": "Remember, when his Lord tried Abraham by a number of commands which he fulfilled, God said to him: \"I will make you a leader among men.\" And when Abraham asked: \"From my progeny too?\" the Lord said: \"My pledge does not include transgressors.\"",
// "edition": {
// "identifier": "en.ahmedali",
// "language": "en",
// "name": "Ahmed Ali",
// "englishName": "Ahmed Ali",
// "type": "translation"
// },
// "surah": {
// "number": 2,
// "name": "سُورَةُ البَقَرَةِ",
// "englishName": "Al-Baqara",
// "englishNameTranslation": "The Cow",
// "revelationType": "Medinan"
// },
// "numberInSurah": 124
// },
