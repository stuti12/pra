// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test_stuti/cart/cart_screen.dart';
// import 'package:test_stuti/new_home/cubit/page_product_state.dart';
// import 'package:test_stuti/new_home/db/database_helper.dart';
// import 'package:test_stuti/new_home/hive/database_helper.dart';
// import 'package:test_stuti/new_home/model/product_response.dart';
// import 'package:test_stuti/new_home/repository/product_repository_impl.dart';
//
// class PageProductCubit extends Cubit<PageProductState> {
//   PageProductCubit() : super(const PageProductState()) {
//     _callProductFetchApi(currentPage);
//     _initializeScrollListener();
//   }
//
//   static PageProductCubit instance() => PageProductCubit();
//   final ScrollController cont = ScrollController();
//
//  //final DatabaseHelper databaseHelper = DatabaseHelper.instance;
//
//   // final HiveDatabaseHelper databaseHelper = HiveDatabaseHelper.instance;
//   Product? product;
//   List<Product>? productLit = [];
//   List<Product> selectedProducts = [];
//   bool hasMore = false;
//   int currentPage=0;
//
//   void _initializeScrollListener() {
//     cont.addListener(() async {
//       if (cont.position.pixels == cont.position.maxScrollExtent && hasMore) {
//         currentPage++;
//         await _callProductFetchApi(currentPage);
//       }
//     });
//   }
//
//   Future<List<Product>> fetchProductFromDatabase() async {
//     emit(state.copyWith(isLoading: true));
//
//    // List<Product>? localProducts = await databaseHelper.getProducts();
//     // await HiveDatabaseHelper.init();
//     // List<Product>? localProducts = await HiveDatabaseHelper.getProducts();
//
//     emit(state.copyWith(productList: [], isLoading: false));
//    // return localProducts;
//     return [];
//   }
//
//   Future<void> _callProductFetchApi(int currentPage) async {
//     emit(state.copyWith(isLoading: true));
//     try {
//      // List<Product>? localProducts = [];
//      List<Product>? localProducts = await fetchProductFromDatabase();
//       if (localProducts.isEmpty) {
//         final productResponse =
//             await ProductRepositoryImpl().getProducts(limit: 5*currentPage);
//         if (productResponse != null) {
//           hasMore = productResponse.products!.length < productResponse.total!;
//           productLit?.addAll(productResponse.products ?? []);
//           emit(state.copyWith(productList: productLit, hasMore: hasMore));
//           debugPrint("Total>>${productResponse.total}");
//           for (Product product in productResponse.products ?? []) {
//             // await HiveDatabaseHelper.insertProduct(product);
//             // await databaseHelper.insertData(
//             //     tableName: 'product', data: product);
//           }
//         }
//       }
//     } catch (e) {
//       throw Exception("Error fetching products: $e");
//     } finally {
//       emit(state.copyWith(isLoading: false));
//     }
//   }
//
//   addProductToCart(bool isSelected,Product product){
//     if(isSelected){
//       selectedProducts.remove(product);
//     }else{
//       selectedProducts.add(product);
//     }
//   }
//
//   ///navigation
//   navigateToDetail({required BuildContext context}) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: context.read<PageProductCubit>(),
//           child: CartScreen(productList: selectedProducts,),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void onChange(Change<PageProductState> change) {
//     super.onChange(change);
//   }
//
//   deleteProduct({required Product product}) {
//     final updatedList = [...state.productList];
//     emit(state.copyWith(productList: updatedList));
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_stuti/cart/cart_screen.dart';
import 'package:test_stuti/new_home/cubit/page_product_state.dart';
import 'package:test_stuti/new_home/db/database_helper.dart';
import 'package:test_stuti/new_home/hive/database_helper.dart';
import 'package:test_stuti/new_home/model/product_response.dart';
import 'package:test_stuti/new_home/repository/product_repository_impl.dart';

class PageProductCubit extends Cubit<PageProductState> {
  PageProductCubit() : super(const PageProductState()) {
    _callProductFetchApi(currentPage);
    _initializeScrollListener();
  }

  static PageProductCubit instance() => PageProductCubit();
  final ScrollController cont = ScrollController();

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  // final HiveDatabaseHelper databaseHelper = HiveDatabaseHelper.instance;
  Product? product;
  List<Product>? productLit = [];
  List<Product> selectedProducts = [];
  bool hasMore = false;
  int currentPage=0;

  void _initializeScrollListener() {
    cont.addListener(() async {
      if (cont.position.pixels == cont.position.maxScrollExtent && hasMore) {
        currentPage++;
        await _callProductFetchApi(currentPage);
      }
    });
  }

  Future<List<Product>> fetchProductFromDatabase() async {
    emit(state.copyWith(isLoading: true));

     List<Product>? localProducts = await databaseHelper.getProducts();
    // await HiveDatabaseHelper.init();
    // List<Product>? localProducts = await HiveDatabaseHelper.getProducts();

    emit(state.copyWith(productList: localProducts, isLoading: false));
     return localProducts;
    //return [];
  }

  Future<void> _callProductFetchApi(int currentPage) async {
    emit(state.copyWith(isLoading: true));
    try {
      // List<Product>? localProducts = [];
      List<Product>? localProducts = await fetchProductFromDatabase();
      if (localProducts.isEmpty) {
        final productResponse =
        await ProductRepositoryImpl().getProducts(limit: 5*currentPage);
        if (productResponse != null) {
          hasMore = productResponse.products!.length < productResponse.total!;
          productLit?.addAll(productResponse.products ?? []);
          emit(state.copyWith(productList: productLit, hasMore: hasMore));
          debugPrint("Total>>${productResponse.total}");
          for (Product product in productResponse.products ?? []) {
            // await HiveDatabaseHelper.insertProduct(product);
            await databaseHelper.insertData(
                tableName: 'product', data: product);
          }
        }
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  addProductToCart(bool isSelected,Product product){
    if(isSelected){
      selectedProducts.remove(product);
    }else{
      selectedProducts.add(product);
    }
  }

  ///navigation
  navigateToDetail({required BuildContext context}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<PageProductCubit>(),
          child: CartScreen(productList: selectedProducts,),
        ),
      ),
    );
  }

  @override
  void onChange(Change<PageProductState> change) {
    super.onChange(change);
  }

  deleteProduct({required Product product}) {
    final updatedList = [...state.productList];
    emit(state.copyWith(productList: updatedList));
  }
}
