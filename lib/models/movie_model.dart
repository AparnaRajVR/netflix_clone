class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releasedate;
  final bool adult;
  final String language;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releasedate,
    required this.adult,
    required this.language,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releasedate: json['release_date'],
      adult: json['adult'],
      language: json['original_language'],
    );
  }
}

/////////////////////////////examples/////////////////////////////////
    // {
    //   "adult": false,
    //   "backdrop_path": "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg",
    //   "genre_ids": [
    //     878,
    //     12,
    //     28
    //   ],
    //   "id": 653346,
    //   "original_language": "en",
    //   "original_title": "Kingdom of the Planet of the Apes",
    //   "overview": "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
    //   "popularity": 5120.32,
    //   "poster_path": "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
    //   "release_date": "2024-05-08",
    //   "title": "Kingdom of the Planet of the Apes",
    //   "video": false,
    //   "vote_average": 6.896,
    //   "vote_count": 833
    // },
    ///////////////////////////////////////////////////////////
    