import "package:sqflite/sqflite.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart";
import "dart:io";

import "../model/weather_model.dart";

class WeatherDB {
  Database db;

  WeatherDB() {
    init();
  }

  void init() async {
    Directory mDirectory = await getApplicationDocumentsDirectory();
    final path = join(mDirectory.path, "tempe.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
            CREATE TABLE temp
            (
              id INTEGER NOT NULL AUTOINCREMENT PRIMARY KEY,
              category TEXT,
              text TEXT,
              minTemp REAL,
              maxTemp REAL,
              day TEXT,
              night TEXT
            )
          """);
    });
  }

  // Fetching all item
  Future<List<Map<String, dynamic>>> fetchAllItem() async {
    List<Map<String, dynamic>> mWeather =
        await db.rawQuery("SELECT * FROM temp");
    return mWeather;
  }

  // Fetch individual item
  Future<WeatherModel> fetchItem(int id) async {
    final mWeatherItem =
        await db.query("temp", columns: null, where: "id = ?", whereArgs: [id]);

    if (mWeatherItem.length > 0) {
      return WeatherModel.fromDB(mWeatherItem.first);
    }

    return null;
  }

  // Adding Data in database
  Future<int> addItem(WeatherModel weather) async {
    return await db.insert("temp", weather.mapToDB(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  // Deleting weather in database
  Future<int> deleteItem(int id) async {
    return await db.delete("temp", where: "id = ?", whereArgs: [id]);
  }
}

final mWeatherDB = WeatherDB();
