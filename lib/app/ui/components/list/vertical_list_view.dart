import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/app_routes.dart';
import '../components.dart';

class VerticalListView extends StatelessWidget {
  final List<Widget> children;
  final Widget? header;
  final bool isLoading;
  final String? error;
  final EdgeInsetsGeometry? padding;

  const VerticalListView({
    super.key,
    required this.children,
    this.header,
    this.isLoading = false,
    this.error,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) header!,
        if (isLoading)
          const SizedBox(
            height: 380,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (error != null)
          SizedBox(
            height: 380,
            child: Center(
              child: CustomBanner.error(
                text: error!,
              ),
            ),
          )
        else
          SingleChildScrollView(
            padding: padding,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: children,
            ),
          ),
      ],
    );
  }

  factory VerticalListView.fromMediaList({
    required BuildContext context,
    required List<MediaItemDto> media,
    Widget? header,
    bool isLoading = false,
    String? error,
  }) {
    return VerticalListView(
      header: header,
      isLoading: isLoading,
      padding: context.spacer.x.xs,
      error: error,
      children: media
          .map<Widget>(
            (media) => CustomCard.midia(
              context: context,
              margin: context.spacer.y.xxs,
              name: media.name,
              releaseDate: media.releaseDate?.formatReleaseDatePtBr(),
              posterPath: media.posterPath ?? '',
              originalName: media.originalName,
              overview: media.overview ?? '',
              onTap: () => AppRoutes.goToViewMedia(
                media: media,
              ),
            ),
          )
          .toList(),
    );
  }
}
