import '../category.dart';

class CategoryResponse {
  final List<Category> categories;
  final String error;

  CategoryResponse(this.categories, this.error);

  CategoryResponse.fromJson(Map<String, dynamic> json)
      : categories = (json["data"] as List)
            .map((i) => new Category.fromJson(i))
            .toList(),
        error = "";

  CategoryResponse.withError(String errorValue)
      : categories = List(),
        error = errorValue;
}
