import 'package:ecommerce_app/data/models/category_model.dart';
import 'package:ecommerce_app/data/repositories/category_repository.dart';
import 'package:ecommerce_app/logic/cubits/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _initialize();
  }

  final _categoryRepository = CategoryRepository();

  void _initialize() async {
    emit(CategoryLoadingState(state.categories));

    try {
      List<CategoryModel> categories =
          await _categoryRepository.getAllCategories();

      emit(CategoryLoadedState(categories));
    } catch (ex) {
      emit(CategoryErrortate(ex.toString(), state.categories));
    }
  }
}
