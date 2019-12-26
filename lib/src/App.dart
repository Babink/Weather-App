import "package:flutter/material.dart";
import "./screen/home.dart";
import "./bloc/provider.dart";

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: "Weather App",
        home: Home(),
      ),
    );
  }
}

// kE8GRTGWJAK3uM5vZ1l2YiniA8128Oxw
// 1.Use accuweather Location api , pass lat and long , it will return placekey
// - create a form which will take lat and long from user
// - store that lat and long somewhere
// - take that data and make network request to get placekey

// 2.Use that placekey in accuweather Forecast api , it will return us temperature json
// take that current placekey
// make network request to forecast api
// get list of data
// render in screen
