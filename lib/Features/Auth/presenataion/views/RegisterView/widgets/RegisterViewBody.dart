import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubit.dart';
import 'package:firebasepro/Features/Auth/presenataion/Manger/AuthCubitStates.dart';
import 'package:firebasepro/Features/Auth/presenataion/views/loginview/loginview.dart';

import 'package:firebasepro/core/widgets/TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Feeds/presentation/Views/HomeView.dart';

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
        if (state is CreateUserSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const HomeView();
          }));
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);

        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 250),
          child: Form(
            key: _formKey,
            // autovalidateMode: cubit.autovalidateMode,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Register now to browse our hot offers',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
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
                      cubit.changeVisibilityMode();
                    },
                    obscureText: cubit.isVisibility,
                    hinttext: 'Password',
                    preicon: Icons.lock,
                    suficon: cubit.visibility,
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
                    hinttext: 'Phone Number',
                    preicon: Icons.phone,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.userRegister(
                            name: usercontroller.text,
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                            phone: phonecontroller.text);
                        emailcontroller.clear();
                        passwordcontroller.clear();
                        usercontroller.clear();
                        phonecontroller.clear();
                      }
                      // cubit.changeValidatorMode(a: AutovalidateMode.always);
                    },
                    child: const Text(
                      'Register',
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
                        'Already have an account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: ((context) {
                                  return const LoginView();
                                }),
                              ),
                            );
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
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
