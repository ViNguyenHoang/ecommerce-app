import 'package:ecommerce_app/core/ui.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});
  static const String routeName = "order_placed_screen";

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đơn hàng của tôi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.view_in_ar_outlined,
                color: AppColors.lightGrey,
                size: 90,
              ),
              Text(
                "Đặt hàng thành công!",
                style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              const Text(
                "Bạn có thể kiểm tra đơn hàng theo cách sau Thông tin > Đơn hàng của tôi",
                style: AppStyles.h5,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
