import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/responsive.dart';
import 'package:pocket_pantry_frontend/services/storage_service/my_shared_preference.dart';
import 'package:pocket_pantry_frontend/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/widgets/reusable_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    loadNameAndEmailFromPreference();
  }

  String name = "";
  String email = "";

  loadNameAndEmailFromPreference() async {
    name = await MySharedPreference.getUserName();
    email = await MySharedPreference.getUserEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.getColor(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.getColor(context).surface,
        leading: BackButton(),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: getHeight(context),
          padding: EdgeInsets.symmetric(
            vertical: 0.02 * getHeight(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    // To be implemented
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 0.2 * getHeight(context),
                        width: 0.4 * getWidth(context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/images/profile_pic.png",
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 0.05 * getHeight(context),
                          width: 0.05 * getHeight(context),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 0.03 * getHeight(context),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.01 * getHeight(context)),
              Text(
                name,
                style: TextStyle(
                  fontSize: 22 * getResponsiveText(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              ReusableWidgets.getSizedBox(height: 0.001 * getHeight(context)),
              Text(
                email,
                style: TextStyle(
                    fontSize: 16 * getResponsiveText(context),
                    color: AppColors.greenText),
              ),
              ReusableWidgets.getSizedBox(height: 0.02 * getHeight(context)),
              getTitle(context, "Account"),
              ReusableWidgets.getSizedBox(height: 0.01 * getHeight(context)),
              getSubtitle(
                context,
                "Edit Profile",
                () {},
              ),
              getSubtitle(
                context,
                "Change Password",
                () {},
              ),
              ReusableWidgets.getSizedBox(height: 0.02 * getHeight(context)),
              getTitle(context, "Settings"),
              ReusableWidgets.getSizedBox(height: 0.01 * getHeight(context)),
              getSubtitle(context, "Notification", () {}),
              getSubtitle(
                context,
                "Theme",
                () {},
              ),
              getSubtitle(
                context,
                "Language",
                () {},
              ),
              ReusableWidgets.getSizedBox(height: 0.01 * getHeight(context)),
              getTitle(context, "Support"),
              ReusableWidgets.getSizedBox(height: 0.01 * getHeight(context)),
              getSubtitle(
                context,
                "Help & Support",
                () {},
              ),
              getSubtitle(
                context,
                "Terms & Conditions",
                () {},
              ),
              getSubtitle(
                context,
                "Privacy Policy",
                () {},
              ),
              ReusableWidgets.getSizedBox(height: 0.02 * getHeight(context)),
              ElevatedButton(
                onPressed: () {
                  // Add your logout functionality here
                  print("User logged out");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.getColor(context).onPrimary,
                  padding: EdgeInsets.symmetric(
                    vertical: 0.015 * getHeight(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize:
                      Size(0.9 * getWidth(context), 0.04 * getHeight(context)),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18 * getResponsiveText(context),
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSubtitle(
    BuildContext context,
    String subtitle,
    VoidCallback onPressed,
  ) {
    return Row(
      children: [
        ReusableWidgets.getSizedBox(width: 0.03 * getHeight(context)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 18 * getResponsiveText(context),
          ),
        ),
        Spacer(),
        IconButton(
          iconSize: 22 * getResponsive(context),
          icon: Icon(
            Platform.isIOS ? Icons.arrow_forward_ios : Icons.arrow_forward,
          ),
          onPressed: onPressed,
        )
      ],
    );
  }

  Widget getTitle(BuildContext context, String title) {
    return Row(
      children: [
        ReusableWidgets.getSizedBox(width: 0.03 * getHeight(context)),
        Text(
          title,
          style: TextStyle(
            fontSize: 22 * getResponsiveText(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
