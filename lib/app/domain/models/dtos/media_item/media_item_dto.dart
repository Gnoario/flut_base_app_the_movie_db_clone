import '../../enums/enums.dart';

class MediaItemDto {
  final bool adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final BigInt id;
  final String? originalLanguage;
  final String originalName;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final MediaType mediaType;
  final DateTime? releaseDate;
  final String name;
  final bool? video;
  final double? voteAverage;
  final BigInt? voteCount;

  MediaItemDto({
    required this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originalLanguage,
    required this.originalName,
    this.overview,
    required this.popularity,
    this.posterPath,
    required this.mediaType,
    this.releaseDate,
    required this.name,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MediaItemDto.fromJson(Map<String, dynamic> json) {
    final mediaType = json['media_type'] != null
        ? EMediaType.fromString(json['media_type'])
        : MediaType.movie;
    final mediaName =
        mediaType == MediaType.movie ? json['title'] : json['name'];
    final mediaOriginalName = mediaType == MediaType.movie
        ? json['original_title']
        : json['original_name'];
    return MediaItemDto(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: BigInt.from(json['id']),
      originalLanguage: json['original_language'],
      originalName: mediaOriginalName,
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      mediaType: mediaType,
      releaseDate:
          DateTime.tryParse(json['release_date'] ?? json['first_air_date']),
      name: mediaName,
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: BigInt.from(json['vote_count']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      if (releaseDate != null) 'release_date': releaseDate!.toIso8601String(),
      'title': name,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
