import 'package:dio/dio.dart';
import 'package:test_stuti/new_home/model/product_response.dart';
import 'package:test_stuti/new_home/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<ProductResponse?> getProducts({int? limit}) async {
    final Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/products?limit=$limit');
    if (response.statusCode == 200) {
      var productResponse = ProductResponse.fromJson(response.data);
      if (productResponse.products != null) {
        return productResponse;
      } else {}
    } else {}
    return null;
  }
}
