import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/models/cart_item_model.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/logic/services/formatter.dart';
import 'package:ecommerce_app/presentation/widgets/link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;

  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: noScroll ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: item.product!.images![0].toString(),
            width: 50,
          ),
          title: Text(item.product!.title.toString()),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                " ${Formatter.formatPrice(item.product!.price!)} x ${Formatter.formatPrice(item.quantity!)} = ${(Formatter.formatPrice(item.quantity! * item.product!.price!))}"),
            LinkButton(
              text: "Xóa",
              onPressed: () {
                BlocProvider.of<CartCubit>(context)
                    .removeFromCart(item.product!);
              },
            )
          ]),
          trailing: InputQty(
            maxVal: 99,
            initVal: item.quantity!,
            minVal: 1,
            showMessageLimit: false,
            onQtyChanged: (value) {
              if (value == item.quantity) return;
              BlocProvider.of<CartCubit>(context)
                  .addToCart(item.product!, value as int);
            },
          ),
        );
      },
    );
  }
}
