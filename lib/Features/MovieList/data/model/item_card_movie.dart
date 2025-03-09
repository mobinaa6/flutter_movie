import 'package:flutter_movie/Features/Home/data/model/movie.dart';
import 'package:flutter_movie/Features/category/data/model/category.dart';

class ItemCard {
  List<Category>? categoryList;
  Movie movie;
  ItemCard(this.categoryList, this.movie);
}
