import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import 'package:pocket_pantry_frontend/features/auth/presentation/widgets/suffix_eye_icon.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is RegisterUserSuccess) {
              CustomSnackbar.showSuccessSnackbar(
                context: context,
                message:
                    state.registerUserEntity.message ??
                    'Registration successful',
              );
              context.pushNamed(RoutePaths.login);
            }

            if (state is RegisterUserFailure) {
              CustomSnackbar.showErrorSnackbar(
                context: context,
                message: state.message,
              );
            }
          },
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
                  CustomText('Create an account', fontSize: 24.0),
                  SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                  CustomText(
                    'Join us to manage your kitchen inventory smartly',
                    fontSize: 12.0,
                  ),
                  SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                  Form(
                    key: formKey,
                    child: Column(
                      spacing: 0.03 * MediaQuery.of(context).size.height,
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          hintText: 'Enter your name',
                        ),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'Enter your email',
                          validator: Util.emailValidator,
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
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final togglePasswordVisibilityState =
                                state as TogglePasswordVisibilityState;
                            return CustomTextFormField(
                              obscureText:
                                  togglePasswordVisibilityState.isVisible,
                              controller: confirmPasswordController,
                              hintText: 'Confirm your password',
                              isSuffixIconOn: true,
                              suffixIcon: SuffixEyeIcon(
                                confirmPasswordController:
                                    confirmPasswordController,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required!';
                                } else if (value != passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Sign up',
                        buttonType: ButtonType.primary,
                        isEnabled: true,
                        isLoading: state is RegisterUserLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Sign up the user
                            context.read<AuthBloc>().add(
                              RegisterUserEvent(
                                name: nameController.text,
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

                  CustomText('Already have an account?', fontSize: 12.0),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(RoutePaths.login);
                    },
                    child: CustomText(
                      'Login',
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
