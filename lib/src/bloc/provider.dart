import "package:flutter/material.dart";
import "./bloc.dart";

class Provider extends InheritedWidget {
  final Bloc bloc;

  Provider({Key key, Widget child})
      : bloc = Bloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => false;

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
