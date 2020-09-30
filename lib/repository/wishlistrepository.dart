import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/repository/apibaseresponse.dart';

class WishListRepository {
  ApiResponse _apiResponse = ApiResponse();

  List<Attribute> attributeList;
  fetchWishList() async {
    attributeList = [];
    final headers = {};
    final response = await _apiResponse.get("/wishlist", headers: headers);
    for (Map item in response['data']) {
      attributeList.add(Attribute.fromJson(item));
    }
    return attributeList;
  }
}
