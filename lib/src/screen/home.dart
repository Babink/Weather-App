import "package:flutter/material.dart";
import "../widget/form.dart";
import "../widget/weather_render.dart";

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Column(children: <Widget>[
        MyForm(),
        WeatherRender(),
      ]),
    );
  }
}
