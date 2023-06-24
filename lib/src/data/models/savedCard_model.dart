class SavedCardModal {
  String id;
  String gifUrl;
  String previewUrl;
  String contentDescription;

  SavedCardModal({
    required this.id,
    required this.gifUrl,
    required this.previewUrl,
    required this.contentDescription,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'gifurl': gifUrl,
      'previewUrl': previewUrl,
      'contentDescription': contentDescription,
    };
  }

  @override
  String toString() {
    return 'SavedCardModal{id: $id, gifUrl: $gifUrl, previewUrl: $previewUrl, $contentDescription: contentDescription}';
  }
}