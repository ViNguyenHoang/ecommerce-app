import 'package:ecommerce_app/logic/cubits/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/logic/cubits/category_cubit/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState && state.categories.isEmpty) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is CategoryErrortate && state.categories.isEmpty) {
            return Center(
              child: Text(state.message.toString()),
            );
          }

          return ListView.builder(
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                leading: const Icon(Icons.category),
                title: Text(state.categories[index].title.toString()),
                trailing: const Icon(Icons.keyboard_arrow_right),
              );
            },
          );
        },
      ),
    );
  }
}
