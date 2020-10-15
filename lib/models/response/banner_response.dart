
import '../banner.dart';

class BannerResponse {
  List<Banner> banners;
  final String error;

  BannerResponse(this.banners, this.error);

  BannerResponse.fromJson(Map<String, dynamic> json)
      : banners =
            (json["data"] as List).map((i) => new Banner.fromJson(i)).toList(),
        error = null;

  BannerResponse.withError(String errorValue)
      : banners = List(),
        error = errorValue;
}
