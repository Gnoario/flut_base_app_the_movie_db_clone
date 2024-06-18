// Mocks generated by Mockito 5.4.4 from annotations
// in flut_base_app_the_movie_db_clone/test/domain/usecases/get_trending_media/get_trending_media_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flut_base_app_the_movie_db_clone/app/data/datasources/get_trending_media/get_trending_media_datasource.dart'
    as _i3;
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePaginatedMediaDto_0 extends _i1.SmartFake
    implements _i2.PaginatedMediaDto {
  _FakePaginatedMediaDto_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTrendingMediaDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTrendingMediaDatasource extends _i1.Mock
    implements _i3.GetTrendingMediaDatasource {
  MockGetTrendingMediaDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.PaginatedMediaDto> call({required String? query}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#query: query},
        ),
        returnValue:
            _i4.Future<_i2.PaginatedMediaDto>.value(_FakePaginatedMediaDto_0(
          this,
          Invocation.method(
            #call,
            [],
            {#query: query},
          ),
        )),
      ) as _i4.Future<_i2.PaginatedMediaDto>);
}
