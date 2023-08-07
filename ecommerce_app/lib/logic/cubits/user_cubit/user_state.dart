import 'package:ecommerce_app/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSignedinState extends UserState {
  final UserModel userModel;
  UserSignedinState(this.userModel);
}

class UserSignoutState extends UserState {}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
