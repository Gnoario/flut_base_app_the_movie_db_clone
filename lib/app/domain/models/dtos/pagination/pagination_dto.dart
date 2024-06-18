class PaginationDto {
  final int? totalPages;
  final int? totalResults;
  final int page;

  PaginationDto({
    this.totalPages,
    this.totalResults,
    required this.page,
  });

  PaginationDto copyWith({
    int? totalPages,
    int? totalResults,
    int? page,
  }) {
    return PaginationDto(
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      page: page ?? this.page,
    );
  }

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return PaginationDto(
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPages': totalPages,
      'totalResults': totalResults,
      'page': page,
    };
  }
}
