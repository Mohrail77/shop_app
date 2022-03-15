import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextform(
                      controller: searchController,
                      textInputType: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Enter text to search';
                        } else {
                          return null;
                        }
                      },
                      labeltext: "Search",
                      prefix: Icons.search,
                      onSubmitted: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (state is SearchLoadingState)
                      const Center(
                        child: LinearProgressIndicator(),
                      ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProducts(
                            SearchCubit.get(context).model.data.data[index],
                            context,
                            IsOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => MyDivider(),
                          itemCount:
                              SearchCubit.get(context).model.data.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
