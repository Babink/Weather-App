import "package:http/http.dart" show Client;
import "dart:convert";
// import "../bloc/bloc.dart";
// import "../model/weather_model.dart";
import "../repo/repo.dart";

class RequestApi {
  final _repo = Repo();
  Client mClient = Client();
  String api_key = "ngnWVadiDMfVEidH6filJw8ygbhKSGV7";

  final _url = 'http://dataservice.accuweather.com';

  fetchPlacekey(double lat, double long) async {
    final mResponse = await mClient.get(
        '$_url/locations/v1/cities/geoposition/search.json?q=$lat,$long&apikey=$api_key');

    final mResult = json.decode(mResponse.body)['Key'];
    final mParsedResult = int.parse(mResult);

    fetchWeatherData(mParsedResult);

    // bloc.mPlaceKey(mParsedResult);
  }

  fetchWeatherData(placekey) async {
    final mResponse = await mClient
        .get('$_url/forecasts/v1/daily/1day/$placekey?apikey=$api_key');

    Map<String, dynamic> mResult = json.decode(mResponse.body);

    final category = mResult["Headline"]["Category"];
    final text = mResult["Headline"]["Text"];
    final dailyTemp = mResult["DailyForecasts"][0]["Temperature"];
    final minTemp = dailyTemp["Minimum"]["Value"];
    final maxTemp = dailyTemp["Maximum"]["Value"];
    final dailyDay = mResult["DailyForecasts"][0]["Day"]["PrecipitationType"];
    final dailyNight = mResult["DailyForecasts"][0]["Night"]["IconPhrase"];

    Map<String, dynamic> mainResult = {
      "category": category,
      "text": text.replaceAll(",", ""),
      "minTemp": minTemp,
      "maxTemp": maxTemp,
      "day": dailyDay,
      "night": dailyNight.replaceAll("w/", "with")
    };

    // final mMyVal = WeatherModel.fromDB(mainResult);
    Map<String, dynamic> mTry = {
      "category": "thunderstorm",
      "text": "Heavy Thunderstorms",
      "minTemp": 63.0,
      "maxTemp": 83.0,
      "day": "Rain",
      "night": "Partly cloudy"
    };

    _repo.addItem(mTry);
    // return mMyVal;
  }
}

final mRequestApi = RequestApi();
