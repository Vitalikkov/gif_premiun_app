import 'package:dio/dio.dart';
import 'package:gif_premiun_app/src/api/dto/autocomplete_dto.dart';
import 'package:gif_premiun_app/src/api/dto/gifs_dto.dart';
import 'package:gif_premiun_app/src/api/models/autocomplete_model.dart';
import 'package:gif_premiun_app/src/api/models/gifsData_model.dart';
import 'package:gif_premiun_app/src/api/models/gifs_model.dart';
import 'package:gif_premiun_app/src/api/mapper/autocomplete_mapper.dart';
import 'package:gif_premiun_app/src/api/mapper/gifs_mapper.dart';



class Api {
  static final Dio _dio = Dio();

  static Future<AutocompleteModel?> fetchAutocomplete(String pattern) async {
      try {
        final response = await _dio.get('https://g.tenor.com/v1/autocomplete?key=LIVDSRZULELA&q=$pattern&limit=5');
        if (response.statusCode == 200) {
          final AutocompleteDto dto = AutocompleteDto.fromJson(response.data as Map<String, dynamic>);
          final AutocompleteModel results = dto.toMapper();
          return results;
          
        }
      } catch (error) {
        print('Error fetching autocomplete: $error');
      }
      return null;
  }

  static Future<GifsData> fetchGifs(String pattern) async {
    final apiKey = 'LIVDSRZULELA';
    final apiUrl = 'https://g.tenor.com/v1/search?q=$pattern&key=$apiKey';
    try {
      final response = await _dio.get(apiUrl);
      final jsonData = response.data as Map<String, dynamic>;
      print(response);
      if (response.statusCode == 200) {
        final results = jsonData['results'] as List<dynamic>;

        List<String> id = [];
        List<String> gifUrl = [];
        List<String> previewUrl = [];
        List<String> contentDescription = [];

        for (var result in results){
          String _id =  result['id'];
          String _contentDescription = result['content_description'];
          String _gifUrl = result['media'][0]['gif']['url'];
          String _previewUrl = result['media'][0]['gif']['preview'];
          id.add(_id);
          contentDescription.add(_contentDescription);
          gifUrl.add(_gifUrl);
          previewUrl.add(_previewUrl);
        }


        // final gifs = gifsList
        //     .map((gif) => GifModel(
        //           url: gif['url'],
        //           preview: gif['preview'],
        //         ))
        //     .toList();

        // final gifCard = GifsCardModel(
        //   id: jsonData['id'],
        //   contentDescription: jsonData['contentDescription'],
        //   gifs: gifs,
        // );

        // return gifCard;
        return  GifsData(
          id: id,
          gifUrl: gifUrl,
          previewUrl: previewUrl,
          contentDescription: contentDescription,
        );
      } else {
        throw Exception('Failed to fetch gifs');
      }
    } catch (e) {
      throw Exception('Failed to fetch gifs: $e');
    }
  }


}


