import 'package:ecommerce_app/data/models/cart_item_model.dart';
import 'package:ecommerce_app/data/models/order_model.dart';
import 'package:ecommerce_app/data/repositories/order_repository.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/logic/cubits/order_cubit/order_state.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;

  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    _handleUserState(_userCubit.state);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserSignedinState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserSignoutState) {
      emit(OrderInitialState());
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit(OrderLoadedState(state.orders));

    try {
      List<OrderModel> orders = await _orderRepository.getOrderForUser(userId);

      emit(OrderLoadedState(orders));
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
    }
  }

  Future<bool> createOrder(
      {required List<CartItemModel> items,
      required String paymentMethod}) async {
    emit(OrderLoadedState(state.orders));

    try {
      if (_userCubit.state is! UserSignedinState) {
        return false;
      }
      UserSignedinState userState = _userCubit.state as UserSignedinState;

      OrderModel newOrder = OrderModel(
          items: items,
          user: userState.userModel,
          status: paymentMethod == "payReceive"
              ? "order-placed"
              : "payment-pending");

      final order = await _orderRepository.createOrder(newOrder);

      List<OrderModel> orders = [order, ...state.orders];

      emit(OrderLoadedState(orders));

      _cartCubit.clearCart();

      return true;
    } catch (ex) {
      emit(OrderErrorState(ex.toString(), state.orders));
      return false;
    }
  }
}
