class WeatherModel {
  String category;
  String text;
  double minTemp;
  double maxTemp;
  String day;
  String night;

  WeatherModel(this.category, this.text, this.minTemp, this.maxTemp, this.day,
      this.night);

  WeatherModel.fromDB(Map<String, dynamic> mParsedJson) {
    category = mParsedJson['category'];
    text = mParsedJson['text'];
    minTemp = mParsedJson['minTemp'];
    maxTemp = mParsedJson['maxTemp'];
    day = mParsedJson['day'];
    night = mParsedJson['night'];
  }

  Map<String, dynamic> mapToDB() {
    return <String, dynamic>{
      "category": category,
      "text": text,
      "minTemp": minTemp,
      "maxTemp": maxTemp,
      "day": day,
      "night": night
    };
  }
}
