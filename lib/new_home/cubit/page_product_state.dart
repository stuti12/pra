import 'package:equatable/equatable.dart';
import 'package:test_stuti/new_home/model/product_response.dart';
class PageProductState extends Equatable {
  final List<Product> productList;
  final int? currentPage;
  final bool? isLoading;
  final bool hasMore;

  const PageProductState({
    this.productList = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [productList,isLoading,hasMore];

  PageProductState copyWith(
      {List<Product>? productList, bool? isLoading, int? pageIndex, bool? hasMore}) {
    return PageProductState(
      productList: productList ?? this.productList,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
