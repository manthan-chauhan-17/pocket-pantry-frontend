import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_event.dart';
import 'package:pocket_pantry_frontend/feature/auth/bloc/auth_state.dart';
import 'package:pocket_pantry_frontend/feature/auth/view/register_screen.dart';
import 'package:pocket_pantry_frontend/feature/home/view/home_screen.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/widgets/custom_text_field.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

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
    return Scaffold(
      // backgroundColor: AppTheme.getColor(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.getColor(context).surface,
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
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Error",
                message: state.error,
                contentType: ContentType.failure);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }

          if (state is AuthLoginSuccessState) {
            final snackbar = ReusableWidgets.getSnackBar(
                title: "Success",
                message: "Successfully Logged In",
                contentType: ContentType.success);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
                      padding:
                          EdgeInsets.only(right: 22 * getResponsive(context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppTheme.getColor(context).onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
                              context.read<AuthBloc>().add(
                                    AuthLoginEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.getColor(context).primary,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.getColor(context).onPrimary),
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
                          style: TextStyle(
                              color: AppTheme.getColor(context).onSurface),
                        ),
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
