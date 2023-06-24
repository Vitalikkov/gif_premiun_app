import 'package:gif_premiun_app/src/api/dto/autocomplete_dto.dart';
import 'package:gif_premiun_app/src/api/models/autocomplete_model.dart';


extension AutocompleteMapper on AutocompleteDto {
  AutocompleteModel toMapper() {
    return AutocompleteModel(
      results: results,
    );
  }
}