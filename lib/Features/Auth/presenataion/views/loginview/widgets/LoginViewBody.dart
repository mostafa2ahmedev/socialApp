import 'package:firebasepro/Features/Auth/data/Cache,.dart';
import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubit.dart';
import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubitStates.dart';

import 'package:firebasepro/core/widgets/TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Feeds/presentation/Views/HomeView.dart';
import '../../RegisterView/RegisterView.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Cache.saveData(key: 'uId', value: state.uId).then(
            (value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomeView();
                  },
                ),
              );
            },
          ).catchError(
            (error) {},
          );
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);

        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 250),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Login now to browse our hot offers',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormFieldAuth(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'plz enter your email';
                      }
                      return null;
                    },
                    hinttext: 'Email Address',
                    preicon: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldAuth(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'plz enter your password';
                      }
                      return null;
                    },
                    ontap: () {
                      cubit.changeVisibilityMode();
                    },
                    obscureText: cubit.isVisibility,
                    hinttext: 'Password',
                    preicon: Icons.lock,
                    suficon: cubit.visibility,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.userLogin(
                            name: emailcontroller.text,
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                            phone: passwordcontroller.text);
                        emailcontroller.clear();
                        passwordcontroller.clear();
                      }
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont\'t have an account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return const RegisterView();
                              }),
                            ),
                          );
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
