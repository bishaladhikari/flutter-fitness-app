import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/models/wish.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class WishListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<WishlistResponse> _subject =
      BehaviorSubject<WishlistResponse>();
  WishlistResponse response;

  getWishlist() async {
    response = await _repository.getWishlist();
    _subject.sink.add(response);
  }

  deleteWishList(id) async {
    await _repository.deleteWishlist(id);
    response.removeWish(id);
    _subject.sink.add(response);

    print("response:" + response.toString());
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<WishlistResponse> get subject => _subject;
//  Stream<WishlistResponse> get subject => _subject.stream;
}

final WishListBloc wishListBloc = WishListBloc();
