import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'view_media_presenter.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/widgets.dart';

class ViewMediaPage extends StatefulWidget {
  final MediaItemDto mediaItem;
  const ViewMediaPage({
    super.key,
    required this.mediaItem,
  });

  @override
  createState() => _ViewMediaPageState();
}

class _ViewMediaPageState extends State<ViewMediaPage> {
  final _controller = Modular.get<ViewMediaPresenter>();
  @override
  void initState() {
    _controller.startStreams();
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentRoute: '/view_media',
      showDrawer: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            MediaInfo(
              mediaItem: widget.mediaItem,
            ),
            const CastInfo(),
          ],
        ),
      ),
    );
  }

  _loadData() {
    _controller
        .getMediaCredits(
      mediaId: widget.mediaItem.id,
      mediaType: widget.mediaItem.mediaType,
    )
        .then((value) {
      if (!value.success) {
        Toast.error(context, message: value.message ?? '');
      }
    });
  }
}
