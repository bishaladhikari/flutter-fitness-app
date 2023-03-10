class Category {
  final int id;
  final String name;
  final String slug;
  final String imageLink;
  List<Category> subCategories;
  final String imageThumbnail;

  Category(this.id, this.name, this.slug, this.imageLink, this.imageThumbnail,
      this.subCategories);

  Category.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        slug = json["slug"],
        imageLink = json["image_link"],
        imageThumbnail = json["image_thumbnail"],
        subCategories = (json["sub_categories"] as List)
            ?.map((i) => new Category.fromJson(i))
            ?.toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image_link'] = this.imageLink;
    data['image_thumbnail'] = this.imageThumbnail;
    data['sub_categories'] =
        this.subCategories != null ? this.subCategories : null;
    return data;
  }
}
