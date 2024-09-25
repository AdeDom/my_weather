enum AppTemperature {
  celsius('celsius', 'metric'),
  fahrenheit('fahrenheit', 'imperial');

  const AppTemperature(
    this.value,
    this.units,
  );

  final String value;
  final String units;
}
