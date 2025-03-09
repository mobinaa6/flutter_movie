import 'package:flutter_movie/Features/MovieList/bloc/get_item_card_from_category_home.dart';
import 'package:flutter_movie/util/enum/category_enum.dart';

extension CategoryTypeEnumExtention on CategorytypeEnum {
  MovieListClass getClass() {
    switch (this) {
      case CategorytypeEnum.Genre:
        return MovieListGenreType();

      case CategorytypeEnum.Country:
        return MovieListCountryType();

      case CategorytypeEnum.TIME:
        return MovieListTimeType();

      case CategorytypeEnum.ACTION:
        return MovieListActionGenre();

      case CategorytypeEnum.ROMANCE:
        return MovieListRomanceGenre();

      case CategorytypeEnum.HORROR:
        return MovieListHorrorGenre();

      case CategorytypeEnum.CRIMINAL:
        return MovieListCriminaGenre();

      case CategorytypeEnum.ANIME:
        return MovieListAnime();

      case CategorytypeEnum.CARTOON:
        return MovieListCartoon();
    }
  }
}
