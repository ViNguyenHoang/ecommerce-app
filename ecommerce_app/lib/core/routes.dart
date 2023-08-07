import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/screens/auth/signin_screen.dart';
import 'package:ecommerce_app/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce_app/presentation/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/presentation/screens/chat/chat_screen.dart';
import 'package:ecommerce_app/presentation/screens/order/my_order_screen.dart';
import 'package:ecommerce_app/presentation/screens/order/order_detail_screen.dart';
import 'package:ecommerce_app/presentation/screens/home/wrap_screen.dart';
import 'package:ecommerce_app/presentation/screens/order/order_placed_screeen.dart';
import 'package:ecommerce_app/presentation/screens/product/product_detail_screen.dart';
import 'package:ecommerce_app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SignInScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case ProductDetailScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            productModel: settings.arguments as ProductModel,
          ),
        );
      case CartScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
        );
      case OrderDetailScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OrderDetailScreen(),
        );
      case OrderPlacedScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OrderPlacedScreen(),
        );
      case MyOrderScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MyOrderScreen(),
        );
      case ChatScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        );
      case WrapScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const WrapScreen(),
        );
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      default:
        return null;
    }
  }
}
