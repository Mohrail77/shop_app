import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({
    bool fromShared,
  }) {
    if (fromShared == true) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = false;
      CashHelper.putBoolean(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
