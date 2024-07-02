import 'package:test_stuti/new_home/model/product_response.dart';

///Repository for give method of fetch products
abstract class ProductRepository {
  Future<ProductResponse?> getProducts();
}
