import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecommerce_app/logic/cubits/order_cubit/order_state.dart';
import 'package:ecommerce_app/logic/services/calculation.dart';
import 'package:ecommerce_app/logic/services/formatter.dart';
import 'package:ecommerce_app/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});
  static const String routeName = "my_order_screen";

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đơn hàng của tôi"),
      ),
      body: SafeArea(child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoadingState && state.orders.isEmpty) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is OrderErrorState && state.orders.isEmpty) {
            return Center(
              child: Text(state.message.toString()),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.orders.length,
            separatorBuilder: (context, index) {
              return const GapWidget();
            },
            itemBuilder: (context, index) {
              final order = state.orders[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("# - ${order.sId}"),
                  Text(
                      "Thời gian đặt hàng hàng: ${Formatter.formatDateTime(DateTime.parse(order.createdAt!))}"),
                  Text(
                    "Tổng đơn hàng: ${Formatter.formatPrice(Calculations.cartTotal(order.items!))}đ",
                    style: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order.items!.length,
                    itemBuilder: (context, index) {
                      final item = order.items![index];
                      final product = item.product!;

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading:
                            CachedNetworkImage(imageUrl: product.images![0]),
                        title: Text("${product.title}"),
                        subtitle: Text("Số lượng: ${item.quantity}"),
                        trailing: Text(
                            "${Formatter.formatPrice(product.price! * item.quantity!)}đ"),
                      );
                    },
                  )
                ],
              );
            },
          );
        },
      )),
    );
  }
}
