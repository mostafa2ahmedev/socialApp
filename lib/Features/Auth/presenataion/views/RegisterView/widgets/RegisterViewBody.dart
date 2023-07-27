import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubit.dart';
import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubitStates.dart';
import 'package:firebasepro/Features/Auth/presenataion/views/AuthHome/AuthButton.dart';
import 'package:firebasepro/Features/Auth/presenataion/views/AuthHome/HaveAccountOrNot.dart';
import 'package:firebasepro/core/Clipper.dart';
import 'package:firebasepro/core/globalMethods.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../AuthHome/TextFormField.dart';
import '../../loginview/loginview.dart';

class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({super.key});

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController usercontroller = TextEditingController();

  final TextEditingController phonecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        // if (state is CreateUserSuccessState) {
        //   Navigator.pushReplacement(context,
        //       MaterialPageRoute(builder: (context) {
        //     return const HomeView();
        //   }));
        // }
        if (state is RegisterSuccessState) {
          GlobalMethod.showSnakeBar(context,
              text: 'user created successfuly', backGroundColor: Colors.green);
          Future.delayed(const Duration(milliseconds: 3100), () {
            GlobalMethod.navigatoReb(context, view: const LoginView());
          });
        } else if (state is RegisterFailureState) {
          GlobalMethod.showSnakeBar(
            context,
            text: state.error,
            backGroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        var auth = BlocProvider.of<AuthCubit>(context);

        return Form(
          key: _formKey,
          // autovalidateMode: cubit.autovalidateMode,
          child: Column(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  color: Colors.blue,
                  height: 300,
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 70, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          'Sign Up!',
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
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormFieldAuth(
                          keyboardType: TextInputType.name,
                          controller: usercontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'plz enter your user name';
                            }
                            return null;
                          },
                          hinttext: 'User Name',
                          preicon: Icons.person,
                          label: 'User Name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldAuth(
                          keyboardType: TextInputType.name,
                          controller: emailcontroller,
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[A-zA-Z]+")
                                .hasMatch(value!);
                            if (value.isEmpty) {
                              return 'plz enter your email';
                            } else if (!emailValid) {
                              return "Enter Valid Email";
                            }
                            return null;
                          },
                          hinttext: 'Email Address',
                          preicon: Icons.email,
                          label: 'Email',
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
                            } else if (passwordcontroller.text.length < 6) {
                              return "password Length Should not be less that 6 char";
                            }
                            return null;
                          },
                          ontap: () {
                            auth.changeVisibilityMode();
                          },
                          obscureText: auth.isVisibility,
                          hinttext: 'Password',
                          preicon: Icons.lock,
                          suficon: auth.visibility,
                          label: 'Password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFieldAuth(
                          keyboardType: TextInputType.phone,
                          controller: phonecontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'plz enter your password';
                            }
                            return null;
                          },
                          hinttext: 'Phone',
                          preicon: Icons.phone,
                          label: 'Phone',
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AuthButton(
                          onpressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            if (_formKey.currentState!.validate()) {
                              auth.userRegister(
                                  name: usercontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  phone: phonecontroller.text);
                              if (state is RegisterSuccessState) {
                                emailcontroller.clear();
                                passwordcontroller.clear();
                                usercontroller.clear();
                                phonecontroller.clear();
                              }
                            }
                          },
                          child: state is RegisterLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'SIGN UP',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const HaveAccountOrNot(
                          text: 'Already have an account?',
                          textButton: 'LOG IN ',
                          widget: LoginView(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
