import 'package:ecommerce_app/core/ui.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const LinkButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: const TextStyle(
            color: AppColors.primaryColor,
          ),
          textAlign: TextAlign.center),
    );
  }
}
