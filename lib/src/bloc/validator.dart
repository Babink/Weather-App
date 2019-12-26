import "dart:async";


class Validator {
  final mLatValidator =
      StreamTransformer<double, double>.fromHandlers(handleData: (lat, sink) {
    if (lat is double) {
      sink.add(lat);
    } else {
      sink.addError("Latitude need to be Double you dummy");
    }
  });

  final mLongValidator =
      StreamTransformer<double, double>.fromHandlers(handleData: (long, sink) {
    if (long is double) {
      sink.add(long);
    } else {
      sink.addError("Longitude need to be Double you dummy");
    }
  });
}
