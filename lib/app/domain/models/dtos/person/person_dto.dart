import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';

import '../../enums/enums.dart';

class PersonDto extends MediaItemDto {
  final String? knownForDepartment;
  final String? profilePath;
  final Gender? gender;
  final List<MediaItemDto> knownFor;
  final String? character;

  PersonDto({
    required super.id,
    required super.originalName,
    required super.mediaType,
    required super.adult,
    required super.name,
    required super.popularity,
    required this.gender,
    required this.knownForDepartment,
    required this.profilePath,
    required this.knownFor,
    this.character,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) {
    return PersonDto(
      id: BigInt.from(json['id']),
      originalName: json['original_name'],
      mediaType: MediaType.person,
      adult: json['adult'],
      name: json['name'],
      popularity: json['popularity'],
      character: json['character'],
      gender: EGender.fromInt(json['gender']),
      knownForDepartment: json['known_for_department'],
      profilePath: json['profile_path'],
      knownFor: (json['known_for'] as List? ?? [])
          .map((e) => MediaItemDto.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_name': originalName,
      'media_type': mediaType,
      'adult': adult,
      'name': name,
      'popularity': popularity,
      'gender': gender?.index,
      'known_for_department': knownForDepartment,
      'profile_path': profilePath,
      'known_for': knownFor.map((e) => e.toJson()).toList(),
    };
  }
}
