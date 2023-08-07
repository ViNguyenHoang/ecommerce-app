import 'package:ecommerce_app/core/ui.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_app/presentation/screens/auth/signin_screen.dart';
import 'package:ecommerce_app/presentation/widgets/gap_widget.dart';
import 'package:ecommerce_app/presentation/widgets/link_button.dart';
import 'package:ecommerce_app/presentation/widgets/primary_button.dart';
import 'package:ecommerce_app/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = "signup";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordRetypeController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Vina"),
          automaticallyImplyLeading: false),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
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
                    "Đăng kí tài khoản",
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
                    controller: phoneController,
                    labelText: "Số điện thoại",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Vui lòng nhập số điện thoại!";
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
                  const GapWidget(),
                  PrimaryTextField(
                    controller: passwordRetypeController,
                    labelText: "Nhập lại mật khẩu",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Vui lòng nhập lại mật khẩu!";
                      }

                      if (value.trim() != passwordController.text) {
                        return "Mật khẩu không trùng khớp!";
                      }

                      return null;
                    },
                    obscureText: true,
                  ),
                  const GapWidget(),
                  PrimaryButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<UserCubit>(context).signup(
                            email: emailController.text,
                            password: passwordRetypeController.text,
                            phone: phoneController.text);
                      }
                    },
                    text: "Đăng kí",
                    isDisabled: state is UserLoadingState,
                  ),
                  const GapWidget(),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text("Bạn đã có tài khoản?",
                          textAlign: TextAlign.center),
                      LinkButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                          text: "Đăng nhập ngay")
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
