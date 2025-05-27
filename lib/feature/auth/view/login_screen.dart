import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_event.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_state.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/register_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final isDark = false; // make it toggle with bloc in future

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                ),
              ),
            );
          }

          if (state is AuthLoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "User Logged In Successfully",
                ),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoginLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: 0.9 * getHeight(context),
            padding: EdgeInsets.symmetric(
              horizontal: 16 * getResponsive(context),
              vertical: 20 * getResponsive(context),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 25 * getResponsive(context),
                    ),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25 * getResponsive(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.04 * getHeight(context),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 25 * getResponsive(context),
                    ),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                      controller: _emailController,
                      fieldType: FieldType.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Add more email validation if needed
                        return null;
                      },
                      hintText: 'Enter your email'),
                  SizedBox(
                    height: 0.02 * getHeight(context),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 25 * getResponsive(context),
                    ),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    fieldType: FieldType.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Add more password validation if needed
                      return null;
                    },
                    hintText: 'Enter your password',
                    maxlines: 1,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 22 * getResponsive(context)),
                    child: Text('Forgot Password?',
                        style: TextStyle(
                          color: AppColors.greenText,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  SizedBox(
                    height: 0.08 * getHeight(context),
                  ),
                  Center(
                    child: SizedBox(
                      width: 0.87 * getWidth(context),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle login logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Logging in...',
                                    style: textTheme.bodyMedium),
                                // backgroundColor: AppColors.success,
                              ),
                            );

                            context.read<AuthBloc>().add(
                                  AuthLoginEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lightPrimaryGreen,
                          // foregroundColor: AppColors.lightSurface,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  // Navigate to Register
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Don\'t have an account? Register',
                        style: TextStyle(color: AppColors.greenText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
