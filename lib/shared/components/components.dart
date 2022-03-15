import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultTextform({
  @required TextEditingController controller,
  @required TextInputType textInputType,
  @required Function validate,
  Function onSubmitted,
  Function onchanged,
  Function onTap,
  @required String labeltext,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      onFieldSubmitted: onSubmitted,
      onChanged: onchanged,
      validator: validate,
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

void showToast({
  @required String message,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

// ignore: non_constant_identifier_names
Widget MyDivider() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildListProducts(
  model,
  context, {
  bool IsOldPrice = true,
}) =>
    Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,
                //fit: BoxFit.cover,
              ),
              if (model.discount != 0 && IsOldPrice)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0 && IsOldPrice)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavourites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            ShopCubit.get(context).favorites[model.id]
                                ? defaultColor
                                : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
