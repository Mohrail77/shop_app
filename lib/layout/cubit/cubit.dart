import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favourites.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());

    Diohelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel.data.banners[0].image);

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      emit(ShopHomeSuccessState());
    }).catchError((error) {
      emit(ShopHomeErrorState(error));
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    Diohelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopCategoriesErrorState(error));
    });
  }

  ChangeFavouritesModel changeFavouritesModel;

  void changeFavourites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavouritesState());

    Diohelper.postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavouritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopChangeFavouritesSuccessState(changeFavouritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopChangeFavouritesErrorState(error));
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    Diohelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('error.toString()');
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    Diohelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //print(userModel.data.name.toString());
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateState());
    Diohelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //print(userModel.data.name.toString());
      emit(ShopSuccessUpdateState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateState());
    });
  }
}
