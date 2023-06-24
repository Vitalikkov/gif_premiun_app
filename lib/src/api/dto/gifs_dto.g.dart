// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gifs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GifsDto _$GifsDtoFromJson(Map<String, dynamic> json) => GifsDto(
      results: (json['results'] as List<dynamic>)
          .map((e) => GifsCardDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GifsDtoToJson(GifsDto instance) => <String, dynamic>{
      'results': instance.results,
    };

GifsCardDto _$GifsCardDtoFromJson(Map<String, dynamic> json) => GifsCardDto(
      id: json['id'] as String,
      contentDescription: json['content_description'] as String,
      gifs: (json['gifs'] as List<dynamic>)
          .map((e) => GifDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GifsCardDtoToJson(GifsCardDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content_description': instance.contentDescription,
      'gifs': instance.gifs,
    };

GifDto _$GifDtoFromJson(Map<String, dynamic> json) => GifDto(
      url: json['url'] as String,
      preview: json['preview'] as String,
    );

Map<String, dynamic> _$GifDtoToJson(GifDto instance) => <String, dynamic>{
      'url': instance.url,
      'preview': instance.preview,
    };
