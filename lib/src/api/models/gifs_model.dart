
class GifsModel {
  final List<GifsCardModel> results;

  GifsModel({ required this.results});
}

class GifsCardModel {
  final String id;
  final String contentDescription;
  final List<GifModel> gifs;

  GifsCardModel(  {
    required this.id,
    required this.contentDescription,
    required this.gifs,
  });

  

 
}

class GifModel {
  final String url;
  final String preview;

  GifModel({required this.url, required this.preview});

}
