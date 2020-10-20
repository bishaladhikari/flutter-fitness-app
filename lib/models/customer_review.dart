class CustomerReview {
  int id;
  int reviewedBy;
  int orderAttributeId;
  List<String> images;
  String headline;
  String message;
  String rating;
  String deletedAt;
  String createdAt;
  String updatedAt;
  List<String> imageLink;
  List<int> imageSize;
  List<String> imageThumbnails;
  String reviewedAge;

  CustomerReview(
      {this.id,
        this.reviewedBy,
        this.orderAttributeId,
        this.images,
        this.headline,
        this.message,
        this.rating,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.imageLink,
        this.imageSize,
        this.imageThumbnails,
        this.reviewedAge});

  CustomerReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewedBy = json['reviewed_by'];
    orderAttributeId = json['order_attribute_id'];
    // images = json['images'].cast<String>();
    headline = json['headline'];
    message = json['message'];
    rating = json['rating'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // imageLink = json['image_link'].cast<String>();
    // imageSize = json['image_size'].cast<int>();
    imageThumbnails = json['image_thumbnail'];
    reviewedAge = json['reviewed_age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reviewed_by'] = this.reviewedBy;
    data['order_attribute_id'] = this.orderAttributeId;
    data['images'] = this.images;
    data['headline'] = this.headline;
    data['message'] = this.message;
    data['rating'] = this.rating;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_link'] = this.imageLink;
    data['image_size'] = this.imageSize;
    data['image_thumbnail'] = this.imageThumbnails;
    data['reviewed_age'] = this.reviewedAge;
    return data;
  }
}