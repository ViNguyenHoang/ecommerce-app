import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/data/models/user_model.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_app/logic/cubits/order_cubit/order_cubit.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_app/presentation/screens/order/order_placed_screeen.dart';
import 'package:ecommerce_app/presentation/widgets/cart_list_view.dart';
import 'package:ecommerce_app/presentation/widgets/gap_widget.dart';
import 'package:ecommerce_app/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});
  static const String routeName = "order_detail_screen";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String paymentMethod = "payNow";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đơn hàng"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const CircularProgressIndicator();
                }

                if (state is UserSignedinState) {
                  UserModel user = state.userModel;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.fullName}",
                        style:
                            AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Email: ${user.email}",
                        style: AppStyles.h5,
                      ),
                      Text(
                        "Phone: ${user.phoneNumber}",
                        style: AppStyles.h5,
                      ),
                      Text(
                        "Address: ${user.address}, ${user.city}",
                        style: AppStyles.h5,
                      ),
                    ],
                  );
                }

                if (state is UserErrorState) {
                  return Text(state.message);
                }

                return const SizedBox();
              },
            ),
            const GapWidget(),
            Text(
              "Món hàng",
              style: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<CartCubit, CartState>(
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

                return CartListView(
                  items: state.items,
                  shrinkWrap: true,
                  noScroll: true,
                );
              },
            ),
            const GapWidget(),
            Text(
              "Phương thức thanh toán",
              style: AppStyles.h5.copyWith(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: "payReceive",
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
              title: const Text(
                "Thanh toán khi nhận hàng",
                style: AppStyles.h5,
              ),
            ),
            RadioListTile(
              value: "payNow",
              groupValue: paymentMethod,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value.toString();
                });
              },
              title: const Text(
                "Thanh toán ngay",
                style: AppStyles.h5,
              ),
            ),
            const GapWidget(),
            PrimaryButton(
              text: "Đặt hàng",
              onPressed: () async {
                bool success = await BlocProvider.of<OrderCubit>(context)
                    .createOrder(
                        items: BlocProvider.of<CartCubit>(context).state.items,
                        paymentMethod: paymentMethod);

                if (success) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
