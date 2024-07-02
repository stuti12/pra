// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:test_stuti/new_home/model/product_response.dart';
// import 'package:hive/hive.dart';
// class HiveDatabaseHelper {
//   static late Box<Product> _productBox;
//   static final HiveDatabaseHelper instance = HiveDatabaseHelper._();
//
//   HiveDatabaseHelper._();
//
//   static Future<void> init() async {
//     final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
//     Hive.init(appDocumentDir.path);
//     if(!Hive.isAdapterRegistered(0)){
//       Hive.registerAdapter(ProductAdapter());
//     }
//     _productBox = await Hive.openBox<Product>('products');
//   }
//
//   static Future<void> insertProduct(Product product) async {
//     await _productBox.put(product.id, product);
//   }
//
//   static Future<List<Product>> getProducts() async {
//     return _productBox.values.toList();
//   }
//
//   static Future<void> updateProduct(Product product) async {
//     await _productBox.put(product.id, product);
//   }
//
//   static Future<void> deleteProduct(Product product) async {
//     await _productBox.delete(product);
//   }
// }
