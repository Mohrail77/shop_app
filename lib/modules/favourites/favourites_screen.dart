import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProducts(
                ShopCubit.get(context).favoritesModel.data.data[index].product,
                context),
            separatorBuilder: (context, index) => MyDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
