enum HomeCategory {
  news,
  music,
  sport,
  tech,
  videogames,
  kids,
  auto,
  lifestyle;

  String get name => toString().split('.').last;
  String get upperName => name.toUpperCase();
}
