import 'package:json_annotation/json_annotation.dart';


part 'autocomplete_dto.g.dart';

@JsonSerializable()
class AutocompleteDto {
  final List<String> results;

  AutocompleteDto({required this.results}); 

  factory AutocompleteDto.fromJson(Map<String, dynamic> json) => _$AutocompleteDtoFromJson(json);
}