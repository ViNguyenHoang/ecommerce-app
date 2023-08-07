import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_app/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce_app/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce_app/presentation/widgets/gap_widget.dart';
import 'package:ecommerce_app/presentation/widgets/link_button.dart';
import 'package:ecommerce_app/presentation/widgets/primary_button.dart';
import 'package:ecommerce_app/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String routeName = "signin";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Vina"),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSignedinState) {
            Navigator.pushReplacementNamed(context, SplashScreen.routeName);
          } else if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Error"),
              backgroundColor: Colors.red,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Loading"),
              backgroundColor: Colors.yellow,
            ));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    "Đăng nhập",
                    style: AppStyles.h4,
                  ),
                  const GapWidget(),
                  PrimaryTextField(
                    controller: emailController,
                    labelText: "Email",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Vui lòng nhập địa chỉ email!";
                      }

                      if (!EmailValidator.validate(value.trim())) {
                        return "Địa chỉ email sai định dạng!";
                      }

                      return null;
                    },
                  ),
                  const GapWidget(),
                  PrimaryTextField(
                    controller: passwordController,
                    labelText: "Mật khẩu",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Vui lòng nhập mật khẩu!";
                      }

                      return null;
                    },
                    obscureText: true,
                  ),
                  const Wrap(
                    alignment: WrapAlignment.end,
                    children: [LinkButton(text: "Quên mật khẩu?")],
                  ),
                  const GapWidget(),
                  PrimaryButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<UserCubit>(context).signin(
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    },
                    text: "Đăng nhập",
                    isDisabled: state is UserLoadingState,
                  ),
                  const GapWidget(),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text("Bạn chưa có tài khoản?",
                          textAlign: TextAlign.center),
                      LinkButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignUpScreen.routeName);
                          },
                          text: "Đăng kí ngay")
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
