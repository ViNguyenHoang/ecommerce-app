import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/logic/cubits/cart_cubit/cart_state.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_app/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/presentation/screens/category/category_screen.dart';
import 'package:ecommerce_app/presentation/screens/profile/profile_screen.dart';
import 'package:ecommerce_app/presentation/screens/product/home_screens.dart';
import 'package:ecommerce_app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WrapScreen extends StatefulWidget {
  const WrapScreen({super.key});

  static const String routeName = "home_route";

  @override
  State<WrapScreen> createState() => _WrapScreenState();
}

class _WrapScreenState extends State<WrapScreen> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const ProfileScreen(),
  ];

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onItemTapped(int i) {
    _pageController.jumpToPage((i));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSignoutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Vina app"),
          actions: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }, icon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Badge(
                    label: Text(state.items.length.toString()),
                    child: const Icon(Icons.shopping_cart));
              },
            ))
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Mặt hàng"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Thông tin"),
          ],
          onTap: onItemTapped,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
