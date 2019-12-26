import "package:flutter/material.dart";
import "../bloc/provider.dart";

class MyForm extends StatelessWidget {
  final TextEditingController mLatitude = TextEditingController();
  final TextEditingController mLongitude = TextEditingController();

  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        mLatField(bloc),
        mLongField(bloc),
        Container(margin: EdgeInsets.only(bottom: 30.0)),
        mButton(bloc),
        mCheckButton(bloc),
      ]),
    );
  }

  Widget mLatField(bloc) {
    return StreamBuilder(
        stream: bloc.mLatitude,
        builder: (context, snapshot) {
          return TextField(
            controller: mLatitude,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Latitude",
              labelText: "Latitude",
              errorText: snapshot.error,
            ),
            onChanged: (value) {
              bloc.mAddLat(double.parse(value));
            },
          );
        });
  }

  Widget mLongField(bloc) {
    return StreamBuilder(
        stream: bloc.mLongitude,
        builder: (context, snapshot) {
          return TextField(
              controller: mLongitude,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Longitude",
                  labelText: "Longitude",
                  errorText: snapshot.error),
              onChanged: (value) {
                bloc.mAddLong(double.parse(value));
              });
        });
  }

  Widget mButton(bloc) {
    return StreamBuilder(
        stream: bloc.mOnSubmit,
        builder: (context, snapshot) {
          return RaisedButton(
            onPressed: () {
              mLatitude.clear();
              mLongitude.clear();

              bloc.onSubmit();
            },
            child: Text("Check"),
            color: Colors.blue,
          );
        });
  }

  Widget mCheckButton(bloc) {
    return RaisedButton(
      onPressed: () {
        print("Hello world");

        bloc.checkDb();
      },
      child: Text("DB"),
      color: Colors.red,
    );
  }
}
