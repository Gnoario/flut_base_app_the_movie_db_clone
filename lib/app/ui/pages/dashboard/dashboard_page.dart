import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../components/components.dart';
import 'widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final presenter = Modular.get<DashboardPresenter>();
  final _focusNode = FocusNode();

  @override
  void initState() {
    presenter.startStreams();
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentRoute: '/',
      child: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                await _loadData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    SearchComponent(
                      focusNode: _focusNode,
                    ),
                    const MovieList(),
                    const TrendingList(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _loadData({bool showError = true}) {
    presenter.getMovies().then((value) {
      if (!value.success && showError) {
        Toast.error(
          context,
          message: value.message!,
        );
      }
    });
    presenter.getTrendingMedia().then((value) {
      if (!value.success && showError) {
        Toast.error(
          context,
          message: value.message!,
        );
      }
    });
  }
}
