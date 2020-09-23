class Category {
  final int id;
  final String name;
  final String slug;
  final String image_link;

  Category(this.id, this.name, this.slug, this.image_link);

  Category.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        slug = json["slug"],
        image_link = json["image_link"];
}
