import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

class HomeHeader extends StatelessWidget {
  final String greetingMessage;
  final String userName;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onAddPressed;

  const HomeHeader({
    super.key,
    required this.greetingMessage,
    required this.userName,
    this.onNotificationPressed,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constant.generalPadding,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Picture and Greeting
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.getColor(context).primaryContainer,
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppTheme.getColor(context).primary,
                      size: 30,
                    ),
                  ),
                  // Green active status dot
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF34C759,
                        ), // Green - works for both themes
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.getColor(context).background,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    greetingMessage,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.getColor(context).onSurfaceVariant,
                  ),
                  CustomText(
                    userName,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getColor(context).onBackground,
                  ),
                ],
              ),
            ],
          ),
          // Notification and Add Button
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.bell,
                      color: AppTheme.getColor(context).onSurfaceVariant,
                      size: 24,
                    ),
                    onPressed: onNotificationPressed,
                  ),
                  // Red notification badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF3B30), // Red - works for both themes
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // Yellow/Gold Add Button
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(
                    0xFFFFD700,
                  ), // Yellow/Gold - works for both themes
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: onAddPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
