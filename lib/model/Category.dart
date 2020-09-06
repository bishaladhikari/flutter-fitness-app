class Category {
  final int id;
  final String name;
  final String image_link;

  Category(this.id, this.name, this.image_link);

  Category.fromJson(Map<String, dynamic> json)
      :
        id = json["id"],
        name = json["name"],
        image_link = json["image_link"];
}