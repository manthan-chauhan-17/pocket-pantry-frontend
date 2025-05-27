import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_event.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_state.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/register_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
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
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo or Title
                  Text(
                    'Pocket Pantry',
                    style: textTheme.displayLarge?.copyWith(
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Welcome back to your pantry!',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  // Email Field
                  CustomTextField(
                    controller: _emailController,
                    fieldType: FieldType.email,
                    labelText: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // Password Field
                  CustomTextField(
                    controller: _passwordController,
                    fieldType: FieldType.password,
                    labelText: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle login logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Logging in...',
                                style: textTheme.bodyMedium),
                            backgroundColor: AppColors.success,
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
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.lightSurface,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text('Login',
                        style: textTheme.labelLarge
                            ?.copyWith(color: AppColors.lightSurface)),
                  ),
                  const SizedBox(height: 16.0),
                  // Navigate to Register
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      'Don\'t have an account? Register',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.accent),
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
