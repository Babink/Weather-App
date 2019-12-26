import "package:flutter/material.dart";
import "../bloc/provider.dart";
import "../model/weather_model.dart";

class WeatherRender extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return StreamBuilder(
        stream: bloc.myWeather,
        builder: (context, AsyncSnapshot<Future<WeatherModel>> snapshot) {
          return snapshot.hasData
              ? mFutureBuilder(snapshot)
              : CircularProgressIndicator();
        });
  }

  Widget mFutureBuilder(AsyncSnapshot<Future<WeatherModel>> snapshot) {
    return FutureBuilder(
        future: snapshot.data,
        builder: (context, itemSnapshot) {
          return ListTile(
            title: Text("My Name is ${itemSnapshot.data.category}"),
          );
        });
  }
}

// return snapshot.hasData
//             ? FutureBuilder(
//                 future: snapshot.data,
//                 builder: (context, itemSnapshot) {
//                   return RaisedButton(onPressed: () {
//                     print(itemSnapshot);
//                   });
//                 })
//             : CircularProgressIndicator();
