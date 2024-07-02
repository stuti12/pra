//import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "products")
  List<Product>? products;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "skip")
  int? skip;
  @JsonKey(name: "limit")
  int? limit;

  ProductResponse({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

//@HiveType(typeId: 0)
@JsonSerializable()
class Product {
 //@HiveField(0)
  @JsonKey(name: "id")
  int? id;
 //@HiveField(1)
  @JsonKey(name: "title")
  String? title;
  //@HiveField(2)
  @JsonKey(name: "description")
  String? description;
  //@HiveField(3)
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "discountPercentage")
  double? discountPercentage;
  //@HiveField(4)
  @JsonKey(name: "rating")
  double? rating;
  //@HiveField(5)
  @JsonKey(name: "stock")
  //@HiveField(6)
  int? stock;
  //@HiveField(7)
  @JsonKey(name: "brand")
  String? brand;
  //@HiveField(8)
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "images")
  List<String>? images;
  DateTime? lastUpdated;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
    };
  }
}
