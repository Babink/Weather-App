import "package:rxdart/rxdart.dart";
import "./validator.dart";
import "../repo/repo.dart";
import "../api/accu_api_request.dart";
import "../model/weather_model.dart";

class Bloc extends Object with Validator {
  final _repo = Repo();
  final _mApi = RequestApi();
  final _latitude = BehaviorSubject<double>();
  final _longitude = BehaviorSubject<double>();
  final _mPlacekey = PublishSubject<int>();
  final _mWeatherData = BehaviorSubject<Future<WeatherModel>>();

  // Stream
  Stream<double> get mLatitude => _latitude.stream.transform(mLatValidator);
  Stream<double> get mLongitude => _longitude.stream.transform(mLongValidator);
  Observable<Future<WeatherModel>> get myWeather => _mWeatherData.stream;

  Stream<bool> get mOnSubmit =>
      Observable.combineLatest2(mLatitude, mLongitude, (lat, long) => true);

  // Sink
  Function(double) get mAddLat => _latitude.sink.add;
  Function(int) get mPlaceKey => _mPlacekey.sink.add;
  Function(double) get mAddLong => _longitude.sink.add;
  Function(Future<WeatherModel>) get mAddItem => _mWeatherData.sink.add;

  // Bloc() {
  //   _mPlacekey.stream.transform(_itemTransformer()).pipe(_mWeatherData);
  // }

  onSubmit() {
    final myLat = _latitude.value;
    final myLong = _longitude.value;
    Map<String, dynamic> mTry = {
      "category": "thunderstorm",
      "text": "Heavy Thunderstorms",
      "minTemp": 63.0,
      "maxTemp": 83.0,
      "day": "Rain",
      "night": "Partly cloudy"
    };

    _repo.addItem(mTry);

    print(mTry);
    // _mApi.fetchPlacekey(myLat, myLong);
  }

  checkDb() {
    final mVal = _repo.fetchAllItem();

    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
    print(mVal);
    print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
  }
  // _itemTransformer() {
  //   return ScanStreamTransformer(
  //       (Future<WeatherModel> mWeather, int placeKey, int index) {
  //     print(placeKey);
  //     print(index);

  //     mWeather = _mApi.fetchWeatherData(placeKey);

  //     mWeather.then((WeatherModel mItem) => {print(mItem.category)});

  //     return mWeather;
  //   });
  // }

  // dispose
  dispose() async {
    _latitude.close();
    _longitude.close();
    _mPlacekey.close();
    await _mWeatherData.drain();
    _mWeatherData.close();
  }
}

// Get Value from _mWeatherData
final bloc = Bloc();
