import 'package:ecommerce_app/data/models/cart_item_model.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/data/repositories/cart_repository.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;

  CartCubit(this._userCubit) : super(CartInitialState()) {
    _handleUserState(_userCubit.state);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserSignedinState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserSignoutState) {
      emit(CartInitialState());
    }
  }

  final _cartRepository = CartRepository();

  void sortAndLoad(List<CartItemModel> items) {
    items.sort((a, b) => b.product!.title!.compareTo(a.product!.title!));
    emit(CartLoadedState(items));
  }

  void _initialize(String userId) async {
    emit(CartLoadingState(state.items));

    try {
      List<CartItemModel> items = await _cartRepository.getCartForUser(userId);

      sortAndLoad(items);
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void removeFromCart(ProductModel product) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserSignedinState) {
        UserSignedinState userState = _userCubit.state as UserSignedinState;

        final items = await _cartRepository.removeFromCart(
            product.sId!, userState.userModel.sId!);

        sortAndLoad(items);
      } else {
        throw "Error";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserSignedinState) {
        UserSignedinState userState = _userCubit.state as UserSignedinState;

        CartItemModel newItem =
            CartItemModel(product: product, quantity: quantity);
        final items =
            await _cartRepository.addToCart(newItem, userState.userModel.sId!);

        sortAndLoad(items);
      } else {
        throw "Error";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void clearCart() {
    emit(CartLoadedState([]));
  }
}
