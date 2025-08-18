import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_event.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_state.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/login_screen.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/widgets/custom_text_field.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

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
    return Scaffold(
      // backgroundColor: AppTheme.getColor(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.getColor(context).surface,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterErrorState) {
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Error",
                message: state.error,
                contentType: ContentType.failure);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
          if (state is AuthRegisterSuccessState) {
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Success",
                message: "User Registered Successfully",
                contentType: ContentType.success);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
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

          return SingleChildScrollView(
            child: Container(
              height: 0.9 * getHeight(context),
              padding: EdgeInsets.symmetric(
                horizontal: 16 * getResponsive(context),
                vertical: 20 * getResponsive(context),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.02 * getHeight(context),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 25 * getResponsive(context),
                      ),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Name Field
                    CustomTextField(
                      controller: _nameController,
                      fieldType: FieldType.name,
                      hintText: "Enter your name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 0.02 * getHeight(context),
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
                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      fieldType: FieldType.email,
                      hintText: "Enter your email",
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
                      hintText: "Enter your password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      maxlines: 1,
                    ),
                    SizedBox(
                      height: 0.02 * getHeight(context),
                    ),
                    // Register Button
                    Center(
                      child: SizedBox(
                        width: 0.87 * getWidth(context),
                        child: ElevatedButton(
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
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    Spacer(),
                    // Navigate to Login
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text('Already have an account? Login',
                            style: TextStyle(
                              color: AppColors.greenText,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
