import "../database/weather_db.dart";
import "../model/weather_model.dart";

class Repo {
  WeatherDB mWeatherDB = WeatherDB();

  Future<int> addItem(Map<String, dynamic> mParsedJson) async {
    WeatherModel mRealData = WeatherModel.fromDB(mParsedJson);

    var mResult = mWeatherDB.addItem(mRealData);

    return mResult;
  }

  Future<int> deleteItem(int id) async {
    final mMap = await mWeatherDB.fetchAllItem();

    if (mMap.length > 0) {
      return mWeatherDB.deleteItem(id);
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> fetchAllItem() async {
    return await mWeatherDB.fetchAllItem();
  }

  Future<WeatherModel> fetchItem(int id) async {
    final mMap = await mWeatherDB.fetchAllItem();

    if (mMap.length > 0) {
      return mWeatherDB.fetchItem(id);
    }

    return null;
  }
}
