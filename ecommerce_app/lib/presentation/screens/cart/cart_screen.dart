import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_app/logic/services/calculation.dart';
import 'package:ecommerce_app/logic/services/formatter.dart';
import 'package:ecommerce_app/presentation/screens/order/order_detail_screen.dart';
import 'package:ecommerce_app/presentation/widgets/cart_list_view.dart';
import 'package:ecommerce_app/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
      ),
      body: SafeArea(child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState && state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is CartErrorState && state.items.isEmpty) {
            return Center(
              child: Text(state.message.toString()),
            );
          }

          if (state is CartLoadedState && state.items.isEmpty) {
            return const Center(
              child: Text("Giỏ hàng đang trống..."),
            );
          }

          return Column(children: [
            Expanded(child: CartListView(items: state.items)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.items.length} món hàng",
                        style:
                            AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Tổng cộng: ${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                        style:
                            AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: PrimaryButton(
                      text: "Đặt hàng",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, OrderDetailScreen.routeName);
                      },
                    ),
                  )
                ],
              ),
            )
          ]);
        },
      )),
    );
  }
}
