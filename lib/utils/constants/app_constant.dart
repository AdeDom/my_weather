class AppConstant {
  /// Key
  static const appIdApiKey = 'appid';

  /// Secrets
  static const appIdApi = '306f0dcc2edb2b416b6578b5156e9966';
  static const baseUrl = 'https://api.openweathermap.org/';

  /// Database
  static const databaseName = 'weather_database.db';
  static const geographicalCoordinatesTableName = 'geographical_coordinates';
  static const createTable = '''
    CREATE TABLE geographical_coordinates (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      lat REAL,
      lon REAL,
      state TEXT NOT NULL
    );
  ''';
}
