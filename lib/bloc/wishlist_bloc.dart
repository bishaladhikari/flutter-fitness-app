
import 'package:ecapp/models/attribute.dart';
import 'package:ecapp/models/response/wishlist_response.dart';
import 'package:ecapp/models/wish.dart';
import 'package:ecapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class WishListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<WishlistResponse> _subject =
  BehaviorSubject<WishlistResponse>();

  List<Wish> wishes;

  getWishlist() async {
    WishlistResponse response = await _repository.getWishlist();
    wishes = response.wishes;
    _subject.sink.add(response);
  }

//  remove(id) async {
//
//    WishlistResponse response = await _repository.removeWishlist();
//    wishes.pop(id)
//    _subject.sink.add(response)
//
//  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<WishlistResponse> get subject => _subject;
//  Stream<WishlistResponse> get subject => _subject.stream;
}

final WishListBloc wishListBloc = WishListBloc();
