import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/colors.dart';
import 'package:pocket_pantry_frontend/responsive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
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
              SizedBox(
                height: 0.01 * getHeight(context),
              ),
              Text(
                'Manthan Chauhan',
                style: TextStyle(
                  fontSize: 22 * getResponsiveText(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 0.001 * getHeight(context),
              ),
              Text(
                'manthanchauhan062@gmail.com',
                style: TextStyle(
                    fontSize: 16 * getResponsiveText(context),
                    color: AppColors.greenText),
              ),
              SizedBox(
                height: 0.02 * getHeight(context),
              ),
              getTitle(context, "Account"),
              SizedBox(
                height: 0.01 * getHeight(context),
              ),
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
              SizedBox(
                height: 0.02 * getHeight(context),
              ),
              getTitle(context, "Settings"),
              SizedBox(
                height: 0.01 * getHeight(context),
              ),
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
              SizedBox(
                height: 0.02 * getHeight(context),
              ),
              getTitle(context, "Support"),
              SizedBox(
                height: 0.01 * getHeight(context),
              ),
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
              SizedBox(
                height: 0.02 * getHeight(context),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your logout functionality here
                  print("User logged out");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greenTextField,
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
        SizedBox(
          width: 0.05 * getWidth(context),
        ),
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
        SizedBox(
          width: 0.05 * getWidth(context),
        ),
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
