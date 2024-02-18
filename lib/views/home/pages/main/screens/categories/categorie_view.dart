import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegetable_orders_project/core/widgets/app_image.dart';
import 'package:vegetable_orders_project/core/widgets/custom_app_bar.dart';
import 'package:vegetable_orders_project/features/categori_products/category_products_cubit.dart';
import 'package:vegetable_orders_project/features/categori_products/category_products_states.dart';
import 'package:vegetable_orders_project/features/products/search_category/search_category_cubit.dart';
import 'package:vegetable_orders_project/views/home/widgets/custom_item_product.dart';
import 'package:vegetable_orders_project/views/sheets/filtter_sheet.dart';

import '../../../../../../core/widgets/custom_app_input.dart';
import '../../../../../../features/categoris/category_model.dart';

class VegetablesView extends StatefulWidget {
  const VegetablesView({super.key, required this.id, required this.model});
  final int id;
  final CategoryModel model;

  @override
  State<VegetablesView> createState() => _VegetablesViewState();
}

class _VegetablesViewState extends State<VegetablesView> {
  late GetCategoryProductsCubit cubit;
  late final GetSearchCategoryCubit searchCubit;
  bool isNotFound = false;
 

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of(context)..getData(id: widget.id);
     searchCubit = GetSearchCategoryCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBody: true,
        appBar: CustomAppBar(title: widget.model.name),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20, bottom: 10),
              child: Stack(
                children: [
                  CustomAppInput(
                    controller: searchCubit.textController,
                    onChange: (value) {
                      if (value.isNotEmpty) {
                        searchCubit.getSearch(
                          text: value,
                          id: widget.id,
                        );
                        if (searchCubit.search.isEmpty) {
                          isNotFound = true;
                        }
                      } else {
                        isNotFound = false;
                        searchCubit.getSearch(text: value, id: widget.id);
                        searchCubit.search.clear();
                      }
                    },
                    labelText: "ابحث عن ماتريد؟",
                    prefixIcon: "assets/icon/svg/search.svg",
                    fillColor: const Color(0xff4C8613).withOpacity(.03),
                    paddingBottom: 0,
                  ),
                  Positioned(
                    top: 9.5,
                    left: 8,
                    child: InkWell(
                      onTap: () async {
                          showModalBottomSheet(
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          context: context,
                          builder: (context) => FiltterSheet(id: widget.id,),
                        );
                      },
                      child: const AppImage(
                        'assets/icon/svg/filtter.svg',
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<GetSearchCategoryCubit, GetSearchCategryStates>(
                builder: (context, state) {
                  if (searchCubit.search.isEmpty && !isNotFound) {
                    return BlocBuilder<GetCategoryProductsCubit,
                        GetCategoryProductsStates>(
                      builder: (context, state) {
                        if (state is GetCategoryProductsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetCategoryProductsSuccessState) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 163 / 215,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, top: 10, bottom: 20),
                              itemCount: state.model.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ItemProduct(
                                model: state.model[index],
                              ),
                            ),
                          );
                        } else {
                          return const Text('Failed');
                        }
                      },
                    );
                  } else if (state is GetSearchCategoryLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 163 / 215,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, top: 10, bottom: 20),
                        itemCount: searchCubit.search.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ItemProduct(
                          isSearch: true,
                          searchModel: searchCubit.search[index],
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}