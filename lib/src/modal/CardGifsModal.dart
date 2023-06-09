
class SavedCard {
  final String id;
  final String url;
  final String preview;
  final String contentDescription;

  SavedCard({
    required this.id,
    required this.url,
    required this.preview,
    required this.contentDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'preview': preview,
      'contentDescription': contentDescription,
    };
  }
}
