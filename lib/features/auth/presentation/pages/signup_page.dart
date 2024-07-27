import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/widgets/loader.dart';
import 'package:flutter_blog_app/core/theme/app_pallete.dart';
import 'package:flutter_blog_app/core/utils/show_snackbar.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_blog_app/init_dependencies.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCtrl.dispose();
    nameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          bloc: serviceLocator<AuthBloc>(),
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context: context, content: state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 15,
                  top: 50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthField(
                      controller: nameCtrl,
                      hintText: 'Name',
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      controller: emailCtrl,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 15),
                    AuthField(
                      controller: passwordCtrl,
                      hintText: 'Password',
                      isObscureText: true,
                    ),
                    const SizedBox(height: 20),
                    AuthGradientButton(
                      title: 'Signup',
                      onTap: submitForm,
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: handleGoToLogIn,
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Log In.',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppPallete.gradient1,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignUp(
              name: nameCtrl.text.trim(),
              email: emailCtrl.text.trim(),
              password: passwordCtrl.text.trim(),
            ),
          );
    }
  }

  void handleGoToLogIn() {
    GoRouter.of(context).pop();
  }
}
