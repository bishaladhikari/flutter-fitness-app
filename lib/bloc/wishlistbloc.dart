import 'package:ecapp/repository/wishlistrepository.dart';

class WishListBloc {
  final _wishListRepository = WishListRepository();

  fetchWishList() async {
    try {
      final response = await _wishListRepository.fetchWishList();
      print("Response:" + response.toString());
    } catch (error) {
      print("ErrorFetchingData:" + error.toString());
    }
  }
}

final WishListBloc wishListBloc = WishListBloc();
