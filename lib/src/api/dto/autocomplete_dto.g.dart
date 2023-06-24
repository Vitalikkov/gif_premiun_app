// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteDto _$AutocompleteDtoFromJson(Map<String, dynamic> json) =>
    AutocompleteDto(
      results:
          (json['results'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AutocompleteDtoToJson(AutocompleteDto instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
