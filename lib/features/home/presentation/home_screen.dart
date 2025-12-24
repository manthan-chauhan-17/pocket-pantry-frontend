import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:pocket_pantry_frontend/core/services/preference_service.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/utils/responsive.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String userName = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String get greetingMessage {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(fetchInitialData);
  }

  void fetchInitialData() async {
    userName = await PreferenceService.getUserName();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(greetingMessage, fontSize: 14),
            CustomText('Manthan'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              // Handle notification icon press
            },
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getColor(context).primary,
            ),
            child: Icon(Icons.add, color: AppTheme.getColor(context).onPrimary),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(Constant.generalPadding),
          child: Column(
            children: [
              CustomTextFormField(
                controller: searchController,
                isPrefixIconOn: true,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for your added item',
              ),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 8,
                children: [
                  GetQuickFilterContainer(),
                  GetQuickFilterContainer(),
                  GetQuickFilterContainer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetQuickFilterContainer extends StatelessWidget {
  const GetQuickFilterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.29 * Responsive.getWidth(context),
      height: 0.15 * Responsive.getHeight(context),
      decoration: BoxDecoration(
        color: Colors.black54,
        border: Border(
          bottom: BorderSide(color: AppTheme.getColor(context).primary),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Icon(CupertinoIcons.clock),
          // Text
          CustomText('Expiring Soon', fontSize: 16.0),
        ],
      ),
    );
  }
}
