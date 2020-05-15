Map<String, dynamic> genHeader(String query) {
  Map<String, dynamic> header = {
    'q': query,
    'bbox': '5.87,47.27,15.04,55.1',
    'osm_tag': null,
    'lang': 'de',
    'limit': 5,
  };

  if (query.length < 4) {
    header['osm_tag'] = 'place:city';
  } else if (query.length < 6) {
    header['osm_tag'] = 'place:region';
  } else if (query.length < 14) {
    header['osm_tag'] = 'highway:primary';
  }

  return header;
}
