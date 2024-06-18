import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flutter/material.dart';

class MediaInfo extends StatelessWidget {
  final MediaItemDto mediaItem;
  const MediaInfo({
    super.key,
    required this.mediaItem,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard.viewMediaInfo(
      context: context,
      title: mediaItem.name,
      posterPath: mediaItem.posterPath ?? '',
      backdropPath: mediaItem.backdropPath ?? '',
      overview: mediaItem.overview ?? '',
      voteAverage: mediaItem.voteAverage ?? 0,
      releaseDate: mediaItem.releaseDate?.year.toString(),
    );
  }
}
