import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubit.dart';
import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubitStates.dart';
import 'package:firebasepro/Features/Auth/presenataion/views/AuthHome/AuthButton.dart';

import 'package:firebasepro/Features/Auth/presenataion/views/AuthHome/TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/Clipper.dart';
import '../../AuthHome/HaveAccountOrNot.dart';
import '../../RegisterView/RegisterView.dart';
import 'ListenerLogin.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        ListenerLogin(state, context, emailcontroller, passwordcontroller);
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.blue,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 70, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back,',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          'Log In!',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 40),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormFieldAuth(
                          label: 'Email',
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
                          label: 'Password',
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
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                              child: Checkbox(
                                value: cubit.isLogin,
                                onChanged: (value) {
                                  cubit.changeRemeberState();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Remember me',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AuthButton(
                          onpressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              await cubit.userLogin(
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                              );
                            }
                          },
                          child: state is LoginLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'LOGIN',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const HaveAccountOrNot(
                          text: 'Dont have an account?',
                          textButton: 'SIGN UP ',
                          widget: RegisterView(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
