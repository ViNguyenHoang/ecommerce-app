import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/data/repositories/product_repository.dart';
import 'package:ecommerce_app/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit(ProductLoadingState(state.products));

    try {
      List<ProductModel> products = await _productRepository.getAllProducts();

      emit(ProductLoadedState(products));
    } catch (ex) {
      emit(ProductErrortate(ex.toString(), state.products));
    }
  }
}
