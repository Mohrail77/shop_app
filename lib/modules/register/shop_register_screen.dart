import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CashHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                  (route) => false,
                );
              });
            } else {
              print(state.loginModel.message);

              showToast(
                message: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextform(
                          controller: nameController,
                          textInputType: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            } else {
                              return null;
                            }
                          },
                          labeltext: "User name",
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultTextform(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          labeltext: "Email Address",
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextform(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmitted: (value) {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          labeltext: "Password",
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextform(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            } else {
                              return null;
                            }
                          },
                          labeltext: "Phone",
                          prefix: Icons.phone_android_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: "register",
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
