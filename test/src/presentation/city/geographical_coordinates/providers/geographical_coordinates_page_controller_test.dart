import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';
import 'package:my_weather/src/data/repositories/open_weather/open_weather_repository.dart';
import 'package:my_weather/src/presentation/city/geographical_coordinates/providers/geographical_coordinates_page_controller.dart';

import '../../../../data/data_source/remote/interceptor/test_exception.dart';
import '../../../../utils/provider_container.dart';

void main() {
  group('geographical coordinates page controller', () {
    test('init geographical coordinates page should be null', () async {
      // Act
      final container = createContainer();
      final result = await container
          .read(geographicalCoordinatesPageControllerProvider.future);

      // Assert
      expect(result, null);
    });

    test('fetch geographical coordinates should be success', () async {
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
      final container = createContainer(
        overrides: [
          fetchGeographicalCoordinatesProvider(search: search)
              .overrideWith((ref) => geographicalCoordinatesList),
        ],
      );

      // Act
      await container
          .read(geographicalCoordinatesPageControllerProvider.notifier)
          .fetchGeographicalCoordinates(search);

      // Assert
      final result = await container
          .read(geographicalCoordinatesPageControllerProvider.future);
      expect(result, isNotEmpty);
      expect(result, geographicalCoordinatesList);
    });

    test('fetch geographical coordinates should be empty', () async {
      // Arrange
      const search = 'bangkok';
      List<GeographicalCoordinatesResponse> geographicalCoordinatesList = [];
      final container = createContainer(
        overrides: [
          fetchGeographicalCoordinatesProvider(search: search)
              .overrideWith((ref) => geographicalCoordinatesList),
        ],
      );

      // Act
      await container
          .read(geographicalCoordinatesPageControllerProvider.notifier)
          .fetchGeographicalCoordinates(search);

      // Assert
      final result = await container
          .read(geographicalCoordinatesPageControllerProvider.future);
      expect(result, isEmpty);
      expect(result, geographicalCoordinatesList);
    });

    test('fetch geographical coordinates should be error', () async {
      // Arrange
      const search = 'bangkok';
      const errorMessage = 'Api error!!!';
      final exception = TestException(errorMessage);
      final container = createContainer(
        overrides: [
          fetchGeographicalCoordinatesProvider(search: search)
              .overrideWith((ref) => throw exception),
        ],
      );

      // Act
      await container
          .read(geographicalCoordinatesPageControllerProvider.notifier)
          .fetchGeographicalCoordinates(search);

      // Assert
      final result =
          container.read(geographicalCoordinatesPageControllerProvider);
      expect(result.error, isA<Exception>());
      expect(result.hasError, true);
      expect(result.error.toString(), errorMessage);
    });
  });
}
