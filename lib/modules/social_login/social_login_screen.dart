import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_social_app/layout/social_layout.dart';
import 'package:udemy_social_app/modules/social_login/social_login_cubit/cubit.dart';
import 'package:udemy_social_app/modules/social_login/social_login_cubit/state.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/components/app_string.dart';
import '../../shared/components/components.dart';
import '../social_register/social_register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
            if (state is SocialLoginErrorState) {
              showToast(text: state.error, state: ToastStates.error);
            }
            if (state is SocialLoginSuccessState) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                navigateAndFinish(
                  context,
                  const SocialLayout(),
                );
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            AppString.loginQuote,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            isPassword:
                                SocialLoginCubit.get(context).isPassword,
                            type: TextInputType.visiblePassword,
                            suffixIcon:
                                SocialLoginCubit.get(context).suffixIcon,
                            suffixPressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            label: 'Password',
                            prefixIcon: Icons.lock_outline,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                              return null;
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => loginButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Login',
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account',
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                text: 'register',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
