import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/pagination/pagination_dto.dart';

import 'media_item_dto.dart';

class PaginatedMediaDto {
  final PaginationDto pagination;
  final List<MediaItemDto> media;

  PaginatedMediaDto({
    required this.pagination,
    required this.media,
  });

  factory PaginatedMediaDto.fromJson(Map<String, dynamic> json) {
    final content = json['results'] as List;
    return PaginatedMediaDto(
      pagination: PaginationDto.fromJson(json),
      media: content
          .map<MediaItemDto>(
            (media) => MediaItemDto.fromJson(
              media,
            ),
          )
          .toList(),
    );
  }

  List<Map<String, dynamic>> toJsonMoviesList() {
    return media.map((e) => e.toJson()).toList();
  }
}
