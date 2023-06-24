import 'package:gif_premiun_app/src/api/models/gifs_model.dart';
import 'package:gif_premiun_app/src/api/dto/gifs_dto.dart';


extension GifsMapper on GifsDto {
  GifsModel toMapper() {
    return GifsModel(
      results: results.map((GifsCardDto e) => e.toMapper()).toList(),
    );
  }
}

extension GifsCardMapper on GifsCardDto {
  GifsCardModel toMapper(){
    return GifsCardModel(
      id: id,
      contentDescription: contentDescription,
      gifs: gifs.map((GifDto e) => e.toMapper()).toList(),
      //media: media.map((dynamic e) => MediaDto.fromJson(e).toMapper()).toList(),
    );
  }
}

extension GidMapper on GifDto {
  GifModel toMapper() {
    return GifModel (
      url: url,
      preview: preview,
    );
  }
}