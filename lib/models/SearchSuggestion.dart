class SearchSuggestion {
  int id;
  String name;
  String slug;
  String imageThumbnail;

  SearchSuggestion({this.id, this.name, this.slug, this.imageThumbnail});

  SearchSuggestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    imageThumbnail = json['image_thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image_thumbnail'] = this.imageThumbnail;
    return data;
  }
}
