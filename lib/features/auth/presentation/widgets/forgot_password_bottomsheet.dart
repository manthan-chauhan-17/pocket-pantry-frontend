// Use Page View inside bottomsheet for the Reset Password Flow
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constants.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_button.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text_form_field.dart';
import 'package:pocket_pantry_frontend/features/auth/presentation/widgets/drag_holder.dart';

class ForgotPasswordBottomsheet extends StatelessWidget {
  ForgotPasswordBottomsheet({super.key});

  final TextEditingController emailController = TextEditingController();

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
            CustomTextFormField(
              controller: emailController,
              hintText: 'Enter your email',
              // validator: Util.emailValidator,
              prefixIcon: Icon(Icons.email_rounded),
              prefixIconColor: AppTheme.getColor(context).primary,
              isPrefixIconOn: true,
            ),

            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomButton(
              text: 'Send Reset Code',
              onPressed: () {
                // Reset password
              },
              buttonType: ButtonType.secondary,
              suffixIcon: Icon(Icons.arrow_forward_rounded),
            ),
            CustomButton(
              text: 'Cancel',
              textColor: AppTheme.getColor(context).outlineVariant,
              onPressed: () {
                Navigator.pop(context);
              },
              buttonType: ButtonType.text,
              suffixIcon: Icon(Icons.close_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpVerificationBottomsheet extends StatelessWidget {
  OtpVerificationBottomsheet({super.key});

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
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: 'Enter your Otp',
              // validator: Util.emailValidator,
              prefixIcon: Icon(Icons.email_rounded),
              prefixIconColor: AppTheme.getColor(context).primary,
              isPrefixIconOn: true,
            ),

            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
            CustomButton(
              text: 'Verify & Continue',
              onPressed: () {
                // Reset password
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
  ResetPasswordBottomsheet({super.key});

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
              controller: TextEditingController(),
              hintText: 'Create a New Password',
              // validator: Util.emailValidator,
              prefixIcon: Icon(Icons.email_rounded),
              prefixIconColor: AppTheme.getColor(context).primary,
              isPrefixIconOn: true,
            ),

            CustomTextFormField(
              controller: TextEditingController(),
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
