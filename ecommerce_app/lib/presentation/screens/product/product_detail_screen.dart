import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/logic/services/formatter.dart';
import 'package:ecommerce_app/presentation/widgets/gap_widget.dart';
import 'package:ecommerce_app/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  static const String routeName = "product_detail";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.productModel.title}"),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(height: 400.0),
                  items: widget.productModel.images?.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(
                            width: MediaQuery.of(context).size.width / 3,
                            imageUrl: item);
                      },
                    );
                  }).toList(),
                ),
              ),
              Text(
                "${widget.productModel.title}",
                style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "${Formatter.formatPrice(widget.productModel.price!)}đ",
                style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              const GapWidget(),
              PrimaryButton(
                  onPressed: () {
                    BlocProvider.of<CartCubit>(context)
                        .addToCart(widget.productModel, 1);
                  },
                  text: "Thêm vào giỏ hàng"),
              const GapWidget(),
              const Text(
                "Thông tin",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${widget.productModel.description}"),
            ],
          ),
        ));
  }
}
