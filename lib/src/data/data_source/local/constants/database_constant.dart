class DatabaseConstant {
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
