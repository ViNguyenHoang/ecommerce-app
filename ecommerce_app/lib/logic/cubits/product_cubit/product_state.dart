import 'package:ecommerce_app/data/models/product_model.dart';

abstract class ProductState {
  final List<ProductModel> products;
  ProductState(this.products);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}

class ProductLoadingState extends ProductState {
  ProductLoadingState(super.products);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(super.products);
}

class ProductErrortate extends ProductState {
  final String message;
  ProductErrortate(this.message, super.products);
}
