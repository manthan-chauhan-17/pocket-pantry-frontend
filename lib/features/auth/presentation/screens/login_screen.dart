import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/constants/constants.dart';
import 'package:pocket_pantry_frontend/core/router/route_paths.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/util.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_button.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_snackbar.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text_form_field.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/widgets/common_auth_header.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/widgets/forgot_password_bottomsheet.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/widgets/suffix_eye_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is LoginUserSuccess) {
            CustomSnackbar.showSuccessSnackbar(
              context: context,
              message: state.loginUserEntity.message ?? 'Login successful',
            );
            context.pushReplacementNamed(RoutePaths.home);
          }

          if (state is LoginUserFailure) {
            CustomSnackbar.showErrorSnackbar(
              context: context,
              message: state.message,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height:
                  MediaQuery.of(context).size.height -
                  0.04 * MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding,
                vertical: Constants.verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonAuthHeader(),
                      CustomText('Pocket Pantry', fontSize: 26.0),
                    ],
                  ),

                  SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                  CustomText('Welcome back', fontSize: 24.0),
                  SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                  CustomText('Login to your account', fontSize: 12.0),

                  SizedBox(height: 0.07 * MediaQuery.of(context).size.height),

                  Form(
                    key: formKey,
                    child: Column(
                      spacing: 0.03 * MediaQuery.of(context).size.height,
                      children: [
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'Enter your email',
                          validator: Util.emailValidator,
                          isPrefixIconOn: true,
                          prefixIcon: Icon(
                            Constant.mailIcon,
                            color: AppTheme.getColor(context).primary,
                          ),
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final togglePasswordVisibilityState =
                                state as TogglePasswordVisibilityState;
                            return CustomTextFormField(
                              obscureText:
                                  togglePasswordVisibilityState.isVisible,
                              controller: passwordController,
                              hintText: 'Enter your password',
                              isSuffixIconOn: true,
                              suffixIcon: SuffixEyeIcon(
                                confirmPasswordController: passwordController,
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    TogglePasswordVisibilityEvent(
                                      isVisible: togglePasswordVisibilityState
                                          .isVisible,
                                    ),
                                  );
                                },
                                isVisible:
                                    togglePasswordVisibilityState.isVisible,
                              ),
                              suffixIconColor: AppTheme.getColor(
                                context,
                              ).primary,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: true,
                            isDismissible: true,
                            useSafeArea: true,
                            builder: (context) {
                              return ResetPasswordFLow();
                            },
                          );
                        },
                        child: CustomText('Forgot password?', fontSize: 12.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        buttonType: ButtonType.primary,
                        text: 'Login',
                        isEnabled: true,
                        isLoading: state is LoginUserLoading,
                        onPressed: () {
                          // Validate the form
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              LoginUserEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  Spacer(),
                  CustomText('Don\'t have an account?', fontSize: 12.0),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(RoutePaths.signup);
                    },
                    child: CustomText(
                      'Sign up',
                      fontSize: 12.0,
                      color: AppTheme.getColor(context).primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppTheme.getColor(context).primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
