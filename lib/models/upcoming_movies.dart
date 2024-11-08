// class UpcomingModel {
//   final int id;
//   final String title;
//   final String overview;
//   final String posterPath;
//   final String releaseDate;
//   final bool adult;
//   final String language;
//   final String? backdropPath;
//   final List<int>? genreIds;
//   final double? popularity;
//   final bool? video;
//   final double? voteAverage;
//   final int? voteCount;

//   UpcomingModel({
//     required this.id,
//     required this.title,
//     required this.overview,
//     required this.posterPath,
//     required this.releaseDate,
//     required this.adult,
//     required this.language,
//     this.backdropPath,
//     this.genreIds,
//     this.popularity,
//     this.video,
//     this.voteAverage,
//     this.voteCount,
//   });

//   factory UpcomingModel.fromJson(Map<String, dynamic> json) {
//     return UpcomingModel(
//       id: json['id'],
//       title: json['title'],
//       overview: json['overview'],
//       posterPath: json['poster_path'],
//       releaseDate: json['release_date'],
//       adult: json['adult'],
//       language: json['original_language'],
//       backdropPath: json['backdrop_path'],
//       genreIds: List<int>.from(json['genre_ids'] ?? []),
//       popularity: (json['popularity'] as num?)?.toDouble(),
//       video: json['video'],
//       voteAverage: (json['vote_average'] as num?)?.toDouble(),
//       voteCount: json['vote_count'],
//     );
//   }
// }
