import 'package:dartz/dartz.dart';
import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/MovieList/data/model/item_card_movie.dart';

extension ListMovieExtention on List<Movie> {
  Either<String, List<ItemCard>> getEitherItemCardMovie() {
    Either<String, List<ItemCard>> eitherItemCard;
    List<ItemCard> itemcardList = [];
    for (var element in this) {
      itemcardList.add(ItemCard(null, element));
    }
    eitherItemCard = Right(itemcardList);

    return eitherItemCard;
  }
}
