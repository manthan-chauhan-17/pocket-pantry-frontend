// Use Page View inside bottomsheet for the Reset Password Flow
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constants.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/util.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_button.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text_form_field.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/widgets/drag_holder.dart';

class ForgotPasswordBottomsheet extends StatelessWidget {
  ForgotPasswordBottomsheet({super.key, required this.onNextPage});

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Function(double) onNextPage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).surfaceContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Constants.borderRadius),
            topRight: Radius.circular(Constants.borderRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10.0,
          children: [
            const DragHolder(),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).primaryContainer,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                size: 30,
                color: AppTheme.getColor(context).primary,
              ),
            ),
            CustomText(
              'Forgot password?',
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomText(
              'don\'t worry! It happens . Enter your  email associated with your account',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            Form(
              key: formKey,
              child: CustomTextFormField(
                controller: emailController,
                hintText: 'Enter your email',
                validator: Util.emailValidator,
                prefixIcon: Icon(Icons.email_rounded),
                prefixIconColor: AppTheme.getColor(context).primary,
                isPrefixIconOn: true,
              ),
            ),

            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomButton(
              text: 'Send Reset Code',
              onPressed: () {
                // Reset password
                if (formKey.currentState!.validate()) {
                  // API CALL to send OTP to email : TO DO
                  onNextPage(
                    450,
                  ); // 450 is the height of the reset password bottomsheet
                }
              },
              buttonType: ButtonType.secondary,
              suffixIcon: Icon(Icons.arrow_forward_rounded),
            ),
            CustomButton(
              text: 'Cancel',
              textColor: AppTheme.getColor(context).primary,
              backgroundColor: AppTheme.getColor(context).surfaceContainer,
              borderColor: AppTheme.getColor(context).primary,
              borderWidth: 1.0,
              onPressed: () {
                Navigator.pop(context);
              },
              buttonType: ButtonType.secondary,
              suffixIcon: Icon(
                Icons.close_rounded,
                color: AppTheme.getColor(context).primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpVerificationBottomsheet extends StatelessWidget {
  OtpVerificationBottomsheet({super.key, required this.onNextPage});

  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Function(double) onNextPage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).surfaceContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Constants.borderRadius),
            topRight: Radius.circular(Constants.borderRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10.0,
          children: [
            const DragHolder(),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).primaryContainer,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                size: 30,
                color: AppTheme.getColor(context).primary,
              ),
            ),
            CustomText(
              'Enter Verification Code',
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomText(
              'We have sent a verification code to your email',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            Form(
              key: formKey,
              child: CustomTextFormField(
                controller: otpController,
                hintText: 'Enter your Otp',
                // validator: Util.emailValidator,
                prefixIcon: Icon(Icons.email_rounded),
                prefixIconColor: AppTheme.getColor(context).primary,
                isPrefixIconOn: true,
              ),
            ),

            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomButton(
              text: 'Verify & Continue',
              onPressed: () {
                // Reset password
                if (formKey.currentState!.validate()) {
                  // API CALL to verify OTP : TO DO
                  onNextPage(600);
                }
              },
              buttonType: ButtonType.secondary,
              suffixIcon: Icon(Icons.arrow_forward_rounded),
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: [
                CustomText(
                  'Didn\'t receive the code?',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.getColor(context).primary,
                ),
                CustomText(
                  'Resend',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.getColor(context).primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.getColor(context).primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordBottomsheet extends StatelessWidget {
  ResetPasswordBottomsheet({super.key, required this.onNextPage});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final Function(double) onNextPage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).surfaceContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Constants.borderRadius),
            topRight: Radius.circular(Constants.borderRadius),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10.0,
          children: [
            const DragHolder(),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).primaryContainer,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                size: 30,
                color: AppTheme.getColor(context).primary,
              ),
            ),
            CustomText(
              'Set New Password',
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomText(
              'Create a new password to access your pantry',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomTextFormField(
              controller: newPasswordController,
              hintText: 'Create a New Password',
              // validator: Util.emailValidator,
              prefixIcon: Icon(Icons.email_rounded),
              prefixIconColor: AppTheme.getColor(context).primary,
              isPrefixIconOn: true,
            ),

            CustomTextFormField(
              controller: confirmPasswordController,
              hintText: 'Confirm new Password',
              // validator: Util.emailValidator,
              prefixIcon: Icon(Icons.email_rounded),
              prefixIconColor: AppTheme.getColor(context).primary,
              isPrefixIconOn: true,
            ),

            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomButton(
              text: 'Reset Password',
              onPressed: () {
                // Reset password
                // onNextPage(
                //   600,
                // ); // 600 is the height of the reset password bottomsheet
              },
              buttonType: ButtonType.secondary,
              suffixIcon: Icon(Icons.arrow_forward_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordFLow extends StatefulWidget {
  const ResetPasswordFLow({super.key});

  @override
  State<ResetPasswordFLow> createState() => _ResetPasswordFLowState();
}

class _ResetPasswordFLowState extends State<ResetPasswordFLow> {
  final PageController pageController = PageController();

  // To handle dynamic height changes smoothly
  double height = 480;
  int currentPage = 0;

  void _nextPage(double newHeight) {
    setState(() => height = newHeight); // Adjust height for next view
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: MediaQuery.of(context).viewInsets.bottom + height,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ForgotPasswordBottomsheet(onNextPage: _nextPage),
              OtpVerificationBottomsheet(onNextPage: _nextPage),
              ResetPasswordBottomsheet(onNextPage: _nextPage),
            ],
          ),
          Positioned(
            top: 10,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.getColor(context).primary,
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(16),
              ),
              child: CustomText(
                '${currentPage + 1}/3',
                color: AppTheme.getColor(context).onPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
