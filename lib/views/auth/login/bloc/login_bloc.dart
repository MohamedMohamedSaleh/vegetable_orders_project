import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logic/cache_helper.dart';
import '../../../../core/logic/dio_helper.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../home/home_view.dart';
import '../login_model.dart';
part 'login_states.dart';
part 'login_events.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginStates()) {
    on<LoginEvent>(_login);
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: "966132847241864");
  final passwordController = TextEditingController(text: "123456789");
  // bool isLoading = false;

  void _login(LoginEvent event,Emitter<LoginStates> emit) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      final response = await DioHelper().sendData(
        endPoint: "login",
        data: {
          "phone": phoneController.text,
          "password": passwordController.text,
          "type": "android",
          "device_token": "test",
          "user_type": "client",
        },
      );

      if (response.isSuccess) {
        UserData model = UserData.fromJson(response.response!.data);
        await CacheHelper.saveUserData(model.model);
        if (!(navigatorKey.currentContext!.mounted)) return;
        Navigator.of(navigatorKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );

        showMessage(
            message: "تم تسجيل الدخول بنجاح", type: MessageType.success);
        emit(LoginSuccessState());
      } else {
        showMessage(message: response.message);
        emit(LoginFailedState());
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }
}