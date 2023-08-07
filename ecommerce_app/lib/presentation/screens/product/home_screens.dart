import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/logic/cubits/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/logic/cubits/product_cubit/product_state.dart';
import 'package:ecommerce_app/logic/services/formatter.dart';
import 'package:ecommerce_app/presentation/screens/product/product_detail_screen.dart';
import 'package:ecommerce_app/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is ProductErrortate && state.products.isEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final product = state.products[index];

            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProductDetailScreen.routeName,
                    arguments: product);
              },
              child: Row(
                children: [
                  CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 3,
                      imageUrl: "${product.images?[0]}"),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title.toString(),
                          style: AppStyles.h4
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          product.description.toString(),
                          style:
                              AppStyles.h5.copyWith(color: AppColors.lightGrey),
                        ),
                        const GapWidget(),
                        Text(
                          "${Formatter.formatPrice(product.price!)}đ",
                          style: AppStyles.h5
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.shopping_cart))
                ],
              ),
            );
          },
        );
      },
    ));
  }
}
