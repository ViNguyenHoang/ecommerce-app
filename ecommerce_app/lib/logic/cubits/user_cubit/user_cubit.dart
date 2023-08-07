import 'package:ecommerce_app/data/models/user_model.dart';
import 'package:ecommerce_app/data/repositories/user_repository.dart';
import 'package:ecommerce_app/logic/cubits/user_cubit/user_state.dart';
import 'package:ecommerce_app/logic/services/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _initialize();
  }

  final UserRepository _userRepository = UserRepository();

  void _initialize() async {
    final userInfo = await Preferences.getUserInformations();

    String? email = userInfo["email"];
    String? password = userInfo["password"];

    if (email == null || password == null) {
      emit(UserSignoutState());
    } else {
      signin(email: email, password: password);
    }
  }

  void _emitSignedInState(
      {required UserModel userModel,
      required String email,
      required String password}) async {
    await Preferences.saveUserInformations(email, password);
    emit(UserSignedinState(userModel));
  }

  void signin({required String email, required String password}) async {
    try {
      UserModel userModel =
          await _userRepository.signin(email: email, password: password);

      _emitSignedInState(
          userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void signup(
      {required String email,
      required String password,
      required String phone}) async {
    try {
      UserModel userModel = await _userRepository.signup(
          email: email, password: password, phone: phone);

      emit(UserSignedinState(userModel));
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void signout() async {
    await Preferences.clear();
    emit(UserSignoutState());
  }
}
