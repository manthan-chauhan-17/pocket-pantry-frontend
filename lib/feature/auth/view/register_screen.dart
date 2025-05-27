import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_event.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_state.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/login_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
import 'package:pocket_pantry_frontend/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            // color: AppColors.lightIcon,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                ),
              ),
            );
          }

          if (state is AuthRegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "User Registered Successfully",
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
          if (state is AuthRegisterLoadingState) {
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
                  // App Title
                  Text(
                    'Join Pocket Pantry',
                    style: textTheme.displayLarge?.copyWith(
                      color: AppColors.lightPrimaryGreen,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Create an account to start organizing!',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  // Name Field
                  CustomTextField(
                    controller: _nameController,
                    fieldType: FieldType.name,
                    labelText: "Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
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
                  // Register Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle registration logic here
                        context.read<AuthBloc>().add(
                              AuthRegisterEvent(
                                  name: _nameController.text,
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
                    child: state is AuthRegisterLoadingState
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Register',
                            style: textTheme.labelLarge?.copyWith(
                                // color: AppColors.lightSurface,
                                ),
                          ),
                  ),
                  const SizedBox(height: 16.0),
                  // Navigate to Login
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: textTheme.bodyMedium?.copyWith(
                          // color: AppColors.accent,
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
