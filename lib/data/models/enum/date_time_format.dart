enum DateTimeFormat {
  date('d/M/yyyy'),
  time('HH:mm'),
  dateTime('d/M/yyyy HH:mm');

  const DateTimeFormat(this.value);

  final String value;
}
