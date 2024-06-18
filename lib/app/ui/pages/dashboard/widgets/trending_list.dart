import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../domain/presentation/result_presentation.dart';
import '../../../components/components.dart';
import '../dashboard_presenter.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  int groupValue = 0;
  final presenter = Modular.get<DashboardPresenter>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: presenter.isGetTrendingMediaLoading,
      initialData: true,
      builder: (context, snapshot) {
        bool isLoading = snapshot.data ?? false;
        return StreamBuilder<ResultPresentation>(
          stream: presenter.trendingMedia,
          builder: (context, snapshot) {
            final getMediaResult = snapshot.data;

            return HorizontalListView.fromMediaList(
              context: context,
              isLoading: isLoading,
              error: getMediaResult?.message,
              media: getMediaResult?.payload ?? [],
              header: BaseHeader.headerWithFilter(
                context: context,
                isLoading: isLoading,
                title: 'Tendências',
                groupValue: groupValue,
                children: TrendingTimeWindow.values
                    .map(
                      (filter) => filter.description,
                    )
                    .toList(),
                onValueChanged: (i) {
                  if (i != null && i != groupValue) {
                    presenter.getTrendingMedia(
                      trendingTimeWindow: TrendingTimeWindow.values[i],
                    );
                    setState(() {
                      groupValue = i;
                    });
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
