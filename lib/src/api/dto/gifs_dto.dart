import 'package:json_annotation/json_annotation.dart';


part 'gifs_dto.g.dart';

@JsonSerializable()
class GifsDto {
  final List<GifsCardDto> results;

  GifsDto({ required this.results});

  factory GifsDto.fromJson(Map<String, dynamic> json) => _$GifsDtoFromJson(json);
}

@JsonSerializable()
class GifsCardDto {
  final String id;
   @JsonKey(name: 'content_description')
  final String contentDescription;
  final List<GifDto> gifs;

  GifsCardDto(  {
    required this.id,
    required this.contentDescription,
    required this.gifs,
  });

   factory GifsCardDto.fromJson(Map<String, dynamic> json) => _$GifsCardDtoFromJson(json);

   Map<String, dynamic> toJson() => _$GifsCardDtoToJson(this);

}


@JsonSerializable()
class GifDto {
  final String url;
  final String preview;

  GifDto({required this.url, required this.preview});

  factory GifDto.fromJson(Map<String, dynamic> json) => _$GifDtoFromJson(json);
}
