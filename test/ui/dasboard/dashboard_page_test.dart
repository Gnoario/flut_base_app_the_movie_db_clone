import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/dashboard/dashboard_page.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/client_https/client_https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/mocks/mocks.dart';
import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late DashboardPresenterSpy presenter;
  late ClientHttpsSpy clientHttpsSpy;
  late MovieMock paginatedMock;

  setUpAll(() {
    HttpOverrides.global = null;
    Modular.bindModule(AppModuleSpy());
  });

  setUp(() {
    clientHttpsSpy = ClientHttpsSpy();
    presenter = DashboardPresenterSpy();
    Modular.replaceInstance<ClientHttps>(clientHttpsSpy);
    Modular.replaceInstance<DashboardPresenter>(presenter);
    paginatedMock = MovieMock();
  });

  Future<void> loadPage(WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        makePage(
          page: const DashboardPage(),
        ),
      );
    });
  }

  tearDown(() {
    presenter.dispose();
    Modular.dispose<DashboardPresenter>();
  });

  tearDownAll(() {
    Modular.dispose();
  });

  group('Success Cases', () {
    testWidgets('Should start normally without error on init page',
        (tester) async {
      await loadPage(tester);

      await tester.pump();
      final textError = find.byKey(
        const Key('CustomBanner.error'),
      );
      expect(textError, findsNothing);
    });

    testWidgets(
        'Should show Circular Progress Indicator on loading trending media in HorizontalListView',
        (tester) async {
      await loadPage(tester);
      presenter.emitTrendingMediaLoading(true);

      await tester.pump();
      final loading = find.descendant(
        of: find.byType(HorizontalListView),
        matching: find.byType(CircularProgressIndicator),
      );
      expect(loading, findsWidgets);
    });

    testWidgets(
        'Should show Circular Progress Indicator on loading movies in HorizontalListView',
        (tester) async {
      await loadPage(tester);
      presenter.emitMoviesLoading(true);

      await tester.pump();
      final loading = find.descendant(
        of: find.byType(HorizontalListView),
        matching: find.byType(CircularProgressIndicator),
      );
      expect(loading, findsWidgets);
    });

    testWidgets(
        'Should do not show Circular Progress Indicator after loading lists',
        (tester) async {
      await loadPage(tester);
      presenter.emitLoadings();
      await tester.pump();
      presenter.emitLoadings(loading: false);
      await tester.pump();

      final loading = find.byType(CircularProgressIndicator);
      expect(loading, findsNothing);
    });

    testWidgets('Should return a ResultPresentation on call getMovies',
        (tester) async {
      await loadPage(tester);
      final mockList = paginatedMock.createMoviesMockList();
      presenter.emitLoadings(loading: false);
      presenter.emitMovies(
        ResultPresentation(payload: mockList),
      );

      await tester.pumpAndSettle();
      final getMoviesResult = find.descendant(
        of: find.byType(HorizontalListView),
        matching: find.byType(CustomCard),
      );
      expect(getMoviesResult, findsAny);
    });

    testWidgets('Should return a ResultPresentation on call getTrendingMedia',
        (tester) async {
      await loadPage(tester);
      final mockList = paginatedMock.createMoviesMockList();
      presenter.emitLoadings(loading: false);
      presenter.emitTrendingMedia(
        ResultPresentation(payload: mockList),
      );

      await tester.pumpAndSettle();
      final getTrendingMediaResult = find.descendant(
        of: find.byType(HorizontalListView),
        matching: find.byType(CustomCard),
      );
      expect(getTrendingMediaResult, findsAny);
    });

    testWidgets('Should call start functions on Load Page', (tester) async {
      await loadPage(tester);
      await tester.pump();

      expect(presenter.getMoviesCalled, isTrue);
      expect(presenter.getTrendingMediaCalled, isTrue);
    });

    testWidgets('Should call correct loadings lifecycle', (tester) async {
      await loadPage(tester);
      final loading = find.byType(CircularProgressIndicator);

      presenter.emitLoadings();
      await tester.pump();
      expect(loading, findsAny);

      presenter.emitLoadings(loading: false);
      await tester.pump();
      expect(loading, findsNothing);

      presenter.emitLoadings();
      await tester.pump();
      expect(loading, findsAny);
    });
  });

  group('Error Cases', () {
    testWidgets('Should show error message on Domain error on getMovies',
        (tester) async {
      await loadPage(tester);
      final error = faker.lorem.word();
      presenter.emitLoadings(loading: false);
      presenter.emitMovies(
        ResultPresentation(
          error: error,
          message: error,
          success: false,
        ),
      );

      await tester.pumpAndSettle();
      final banner = find.descendant(
        of: find.byType(HorizontalListView),
        matching: find.byType(CustomBanner),
      );
      expect(banner, findsOne);
    });

    testWidgets('Should show error message on Domain error on getTrendingMedia',
        (tester) async {
      await loadPage(tester);
      final error = faker.lorem.word();
      presenter.emitLoadings(loading: false);
      presenter.emitTrendingMedia(
        ResultPresentation(
          error: error,
          message: error,
          success: false,
        ),
      );

      await tester.pumpAndSettle();
      final banner = find.descendant(
        of: find.byType(HorizontalListView),
        matching: find.byType(CustomBanner),
      );
      expect(banner, findsOne);
    });
  });
}
