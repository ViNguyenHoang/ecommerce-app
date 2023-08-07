import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/presentation/screens/chat/chat_screen.dart';
import 'package:ecommerce_app/presentation/screens/order/my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ChatScreen.routeName);
            },
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.chat),
            title: const Text(
              "Chat với shop",
              style: AppStyles.h5,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, MyOrderScreen.routeName);
            },
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.view_in_ar_sharp),
            title: const Text(
              "Đơn hàng của tôi",
              style: AppStyles.h5,
            ),
          ),
          ListTile(
            onTap: () {
              BlocProvider.of<UserCubit>(context).signout();
            },
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Đăng xuất",
              style: AppStyles.h5,
            ),
          )
        ],
      ),
    );
  }
}
