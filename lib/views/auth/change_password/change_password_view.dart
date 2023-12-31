import 'package:flutter/material.dart';
import 'package:vegetable_orders_project/core/widgets/custom_app_input.dart';
import 'package:vegetable_orders_project/core/widgets/custom_bottom_navigation.dart';
import 'package:vegetable_orders_project/core/widgets/custom_fill_button.dart';
import 'package:vegetable_orders_project/core/widgets/custom_intoduction.dart';
import '../../../core/logic/helper_methods.dart';
import '../register/register_view.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/splash_bg.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 16,
                  left: 16,
                ),
                child: FormChanegePassword(),
              ),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              text: "ليس لديك حساب ؟",
              buttonText: " تسجيل الدخول",
              paddingBottom: 22,
              onPress: () {
                navegateTo(toPage: const RegisterView());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FormChanegePassword extends StatefulWidget {
  const FormChanegePassword({
    super.key,
  });

  @override
  State<FormChanegePassword> createState() => _FormChanegePasswordState();
}

class _FormChanegePasswordState extends State<FormChanegePassword> {
  String? password;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          const CustomIntroduction(
            mainText: "نسيت كلمة المرور",
            supText: "أدخل كلمة المرور الجديدة",
            paddingHeight: 17,
          ),
          CustomAppInput(
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "كلمة المرور مطلوبه";
              } else if (value!.length <= 6) {
                return "كلمة المرور يجب أن تكون أكبر من 6 أحرف";
              }
              password = value;
              return null;
            },
            labelText: "كلمة المرور",
            prefixIcon: "assets/icon/lock_icon.png",
            isPassword: true,
          ),
          CustomAppInput(
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "تأكيد كلمة المرور مطلوبه";
              } else if (value!.length <= 6) {
                return "كلمة المرور يجب أن تكون أكبر من 6 أحرف";
              } else if (password != value) {
                return "كلمة المرور غير متطابقة";
              } else {
                return null;
              }
            },
            labelText: "تأكيد كلمة المرور",
            prefixIcon: "assets/icon/lock_icon.png",
            isPassword: true,
            paddingBottom: 25,
          ),
          CustomFillButton(
            title: "تغيير كلمة المرور",
            onPress: () {
              FocusScope.of(context).unfocus();
              if (formKey.currentState!.validate()) {
              // navegateTo(toPage: const ConfirmCodeView(isActive: true,),);
              } else {
                autovalidateMode = AutovalidateMode.onUserInteraction;
                setState(() {});
              }
              

            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
