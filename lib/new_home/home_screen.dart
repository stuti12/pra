import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_stuti/cart/cart_screen.dart';
import 'package:test_stuti/new_home/cubit/page_product_cubit.dart';
import 'package:test_stuti/new_home/cubit/page_product_state.dart';
import 'package:test_stuti/new_home/product_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: context.read<PageProductCubit>(),
        child: BlocBuilder<PageProductCubit, PageProductState>(
          builder: (context, state) {
            // if (state.isLoading == true) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            return ListView.separated(
              controller: context.read<PageProductCubit>().cont,
              padding: EdgeInsets.all(10.w),
              itemCount: state.productList.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < state.productList.length) {
                  final product = state.productList[index];
                  final isSelected = context
                      .read<PageProductCubit>()
                      .selectedProducts
                      .contains(product);

                  return ProductListItem(
                    isSelected: isSelected,
                      onTap: () {
                        context
                            .read<PageProductCubit>()
                            .addProductToCart(isSelected, product);
                      },
                      product: product);
                } else if (state.hasMore) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox();
                }
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10.w,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         context.read<PageProductCubit>().navigateToDetail(context: context);
        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
