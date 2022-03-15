import 'package:shop_app/models/change_favourites.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {
  final String error;

  ShopCategoriesErrorState(this.error);
}

class ShopChangeFavouritesState extends ShopStates {}

class ShopChangeFavouritesSuccessState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopChangeFavouritesSuccessState(this.model);
}

class ShopChangeFavouritesErrorState extends ShopStates {
  final String error;

  ShopChangeFavouritesErrorState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateState extends ShopStates {}

class ShopSuccessUpdateState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateState(this.loginModel);
}

class ShopErrorUpdateState extends ShopStates {}
