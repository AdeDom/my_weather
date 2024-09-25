import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_weather/src/data/data_source/local/open_weather/open_weather_local_data_source.dart';
import 'package:my_weather/src/data/data_source/remote/open_weather/open_weather_remote_data_source.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/src/data/repositories/app_settings/app_settings_repository.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';

import '../../data_source/local/open_weather/fake_open_weather_local_data_source.dart';
import '../../data_source/remote/open_weather/mock_open_weather_remote_data_source.dart';
import '../app_settings/fake_app_settings_repository.dart';

void main() {
  late OpenWeatherRepository openWeatherRepository;
  late OpenWeatherLocalDataSource openWeatherLocalDataSource;
  late OpenWeatherRemoteDataSource openWeatherRemoteDataSource;
  late AppSettingsRepository appSettingsRepository;

  setUp(() {
    openWeatherLocalDataSource = FakeOpenWeatherLocalDataSource();
    openWeatherRemoteDataSource = MockOpenWeatherRemoteDataSource();
    appSettingsRepository = FakeAppSettingsRepository();
    openWeatherRepository = OpenWeatherRepositoryImpl(
      openWeatherLocalDataSource: openWeatherLocalDataSource,
      openWeatherRemoteDataSource: openWeatherRemoteDataSource,
      appSettingsRepository: appSettingsRepository,
    );
  });

  group('open weather repository', () {
    test('fetch geographical coordinates', () async {
      // Arrange
      const search = 'bangkok';
      final data1 = GeographicalCoordinatesResponse(
        name: 'Bangkok',
        lat: 13.7524938,
        lon: 100.4935089,
        state: 'Bangkok',
      );
      final data2 = GeographicalCoordinatesResponse(
        name: 'Bangkok',
        lat: -7.3300335,
        lon: 110.6666887,
        state: 'Central Java',
      );
      final geographicalCoordinatesList = [data1, data2];
      when(
        () => openWeatherRemoteDataSource.fetchGeographicalCoordinates(
          any(),
          any(),
        ),
      ).thenAnswer((_) async => geographicalCoordinatesList);

      // Act
      final result = await openWeatherRepository.fetchGeographicalCoordinates(
        search,
      );

      // Assert
      expect(result, geographicalCoordinatesList);
      expect(result.length, 2);
      verify(
        () => openWeatherRemoteDataSource.fetchGeographicalCoordinates(
          any(),
          any(),
        ),
      ).called(1);
    });
  });
}
