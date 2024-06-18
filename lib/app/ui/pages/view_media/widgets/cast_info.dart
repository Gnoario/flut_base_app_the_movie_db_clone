import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/view_media/view_media_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../components/components.dart';

class CastInfo extends StatelessWidget {
  const CastInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Modular.get<ViewMediaPresenter>();
    return StreamBuilder<bool>(
      initialData: true,
      stream: presenter.isGetMediaCreditsLoading,
      builder: (context, snapshot) {
        final isLoading = snapshot.data ?? false;
        return StreamBuilder<ResultPresentation>(
            stream: presenter.mediaCredits,
            builder: (context, snapshot) {
              final mediaCredits = snapshot.data;
              return HorizontalListView.fromCastList(
                context: context,
                isLoading: isLoading,
                error: mediaCredits?.message,
                media: mediaCredits?.payload ?? [],
                header: BaseHeader.header(
                  title: 'Elenco',
                ),
              );
            });
      },
    );
  }
}
