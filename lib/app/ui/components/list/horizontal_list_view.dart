import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/core/routes/app_routes.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/dtos/person/person_dto.dart';
import '../components.dart';

class HorizontalListView extends StatefulWidget {
  final List<Widget> children;
  final Widget? header;
  final bool isLoading;
  final String? error;

  const HorizontalListView({
    super.key,
    required this.children,
    this.header,
    this.isLoading = false,
    this.error,
  });

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();

  factory HorizontalListView.fromMediaList({
    required BuildContext context,
    required List<MediaItemDto> media,
    Widget? header,
    bool isLoading = false,
    String? error,
  }) {
    return HorizontalListView(
      header: header,
      isLoading: isLoading,
      error: error,
      children: media
          .map<Widget>(
            (media) => CustomCard.shortMidia(
              context: context,
              margin: context.spacer.x.xs,
              name: media.name,
              releaseDate: media.releaseDate?.formatReleaseDatePtBr(),
              posterPath: media.posterPath ?? '',
              voteAverage: media.voteAverage ?? 0,
              onTap: () => AppRoutes.goToViewMedia(
                media: media,
              ),
            ),
          )
          .toList(),
    );
  }

  factory HorizontalListView.fromCastList({
    required BuildContext context,
    required List<PersonDto> media,
    Widget? header,
    bool isLoading = false,
    String? error,
  }) {
    return HorizontalListView(
      header: header,
      isLoading: isLoading,
      error: error,
      children: media
          .map<Widget>(
            (media) => CustomCard.person(
              context: context,
              name: media.name,
              character: media.character ?? '',
              profilePath: media.profilePath ?? '',
            ),
          )
          .toList(),
    );
  }
}

class _HorizontalListViewState extends State<HorizontalListView> {
  final ScrollController _scrollController = ScrollController();
  bool _showLeftShadow = false;
  bool _showRightShadow = true;

  _onScroll() {
    if (!_scrollController.hasClients) return;

    setState(() {
      _showLeftShadow = _scrollController.position.pixels > 0;
      _showRightShadow = _scrollController.position.pixels <
          _scrollController.position.maxScrollExtent;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header != null) widget.header!,
        if (widget.isLoading)
          const SizedBox(
            height: 380,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (widget.error != null)
          SizedBox(
            height: 380,
            child: Center(
              child: CustomBanner.error(
                text: widget.error!,
              ),
            ),
          )
        else
          Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: widget.children,
                ),
              ),
              if (_showLeftShadow)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: _buildShadow(
                    showShadow: _showLeftShadow,
                    isLeft: true,
                  ),
                ),
              if (_showRightShadow)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: _buildShadow(
                    showShadow: _showRightShadow,
                    isLeft: false,
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Container _buildShadow({
    required bool showShadow,
    required bool isLeft,
  }) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isLeft
              ? [
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.1),
                ]
              : [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.8),
                ],
        ),
      ),
    );
  }
}
