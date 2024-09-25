import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_weather/src/data/data_source/local/open_weather/open_weather_local_data_source.dart';
import 'package:my_weather/src/data/models/entity/geographical_coordinates/geographical_coordinates_entity.dart';
import 'package:my_weather/src/data/models/response/geographical_coordinates/geographical_coordinates_response.dart';

import '../../../../data/data_source/local/open_weather/fake_open_weather_local_data_source.dart';

void main() {
  late OpenWeatherLocalDataSource openWeatherLocalDataSource;
  late ProviderContainer container;

  setUp(() {
    openWeatherLocalDataSource = FakeOpenWeatherLocalDataSource();
    container = ProviderContainer(
      overrides: [
        openWeatherLocalDataSourceProvider
            .overrideWithValue(openWeatherLocalDataSource),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('city landing controller', () {
    test('list empty selected should be add list', () async {
      // Arrange
      GeographicalCoordinatesResponse data = GeographicalCoordinatesResponse(
        name: 'Bangkok',
        lat: 13.7524938,
        lon: 100.4935089,
        state: 'Bangkok',
      );

      // Act
      // container
      //     .read(cityLandingControllerProvider.notifier)
      //     .selectedGeographicalCoordinates(data);

      // Assert
      final list =
          await openWeatherLocalDataSource.getGeographicalCoordinatesAll();
      expect(list.length, 1);
      expect(
        list.firstOrNull,
        GeographicalCoordinatesEntity.fromResponse(data: data),
      );
    });

    test('has list selected should be append list', () async {
      // Arrange
      GeographicalCoordinatesResponse oldData = GeographicalCoordinatesResponse(
        name: 'Bangkok',
        lat: 13.7524938,
        lon: 100.4935089,
        state: 'Bangkok',
      );
      final entity = GeographicalCoordinatesEntity.fromResponse(data: oldData);
      openWeatherLocalDataSource.addGeographicalCoordinates(entity);
      GeographicalCoordinatesResponse newData = GeographicalCoordinatesResponse(
        name: 'Phayao',
        lat: 19.1666313,
        lon: 99.9019423,
        state: 'Phayao Province',
      );

      // Act
      // container
      //     .read(cityLandingControllerProvider.notifier)
      //     .selectedGeographicalCoordinates(newData);

      // Assert
      final list =
          await openWeatherLocalDataSource.getGeographicalCoordinatesAll();
      expect(list.length, 2);
      expect(
        list[0],
        GeographicalCoordinatesEntity.fromResponse(data: oldData),
      );
      expect(
        list[1],
        GeographicalCoordinatesEntity.fromResponse(data: newData),
      );
    });

    test('select one item remove list should be remove one item', () async {
      // Arrange
      GeographicalCoordinatesResponse data1 = GeographicalCoordinatesResponse(
        name: 'Bangkok',
        lat: 13.7524938,
        lon: 100.4935089,
        state: 'Bangkok',
      );
      GeographicalCoordinatesResponse data2 = GeographicalCoordinatesResponse(
        name: 'Phayao',
        lat: 19.1666313,
        lon: 99.9019423,
        state: 'Phayao Province',
      );
      final entity1 = GeographicalCoordinatesEntity.fromResponse(data: data1);
      final entity2 = GeographicalCoordinatesEntity.fromResponse(data: data2);
      openWeatherLocalDataSource.addGeographicalCoordinates(entity1);
      openWeatherLocalDataSource.addGeographicalCoordinates(entity2);
      // final model1 = GeographicalCoordinatesModel.fromResponse(data: data1)
      //     .copyWith(isDelete: false);
      // final model2 = GeographicalCoordinatesModel.fromResponse(data: data2)
      //     .copyWith(isDelete: true);
      // final geographicalCoordinatesList = [
      //   model1,
      //   model2,
      // ];

      // Act
      // container
      //     .read(cityLandingControllerProvider.notifier)
      //     .removeList(geographicalCoordinatesList);

      // Assert
      final list =
          await openWeatherLocalDataSource.getGeographicalCoordinatesAll();
      expect(list.length, 1);
      expect(
        list[0],
        GeographicalCoordinatesEntity.fromResponse(data: data1),
      );
    });

    test('select two item remove list should be remove two item', () async {
      // Arrange
      GeographicalCoordinatesResponse data1 = GeographicalCoordinatesResponse(
        name: 'Bangkok',
        lat: 13.7524938,
        lon: 100.4935089,
        state: 'Bangkok',
      );
      GeographicalCoordinatesResponse data2 = GeographicalCoordinatesResponse(
        name: 'Phayao',
        lat: 19.1666313,
        lon: 99.9019423,
        state: 'Phayao Province',
      );
      final entity1 = GeographicalCoordinatesEntity.fromResponse(data: data1);
      final entity2 = GeographicalCoordinatesEntity.fromResponse(data: data2);
      openWeatherLocalDataSource.addGeographicalCoordinates(entity1);
      openWeatherLocalDataSource.addGeographicalCoordinates(entity2);
      // final model1 = GeographicalCoordinatesModel.fromResponse(data: data1)
      //     .copyWith(isDelete: true);
      // final model2 = GeographicalCoordinatesModel.fromResponse(data: data2)
      //     .copyWith(isDelete: true);
      // final geographicalCoordinatesList = [
      //   model1,
      //   model2,
      // ];

      // Act
      // container
      //     .read(cityLandingControllerProvider.notifier)
      //     .removeList(geographicalCoordinatesList);

      // Assert
      final list =
          await openWeatherLocalDataSource.getGeographicalCoordinatesAll();
      expect(list.length, 0);
      expect(list, isEmpty);
    });
  });
}
