import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_management_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_request_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/payment_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/feedback_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/user_management_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/complaint_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/dashboard_section.dart';
import 'package:homecare_admin/ui/screens/login_screen.dart';
import 'package:homecare_admin/ui/widgets/change_password.dart';
import 'package:homecare_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/values/values.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/drawer_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 7,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "HomeCare",
          style: GoogleFonts.dynalight(
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: secondaryColor,
                ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DashboardSection(),
          UserManagementSection(),
          NurseManagementSection(),
          NurseRequestSection(),
          PaymentSection(),
          FeedbackSection(),
          ComplaintSection(),
        ],
      ),
      drawer: SizedBox(
        width: 300,
        child: Material(
          color: primaryColor,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "MENU",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDrawerButton(
                label: "Dashboard",
                isSelected: tabController.index == 0,
                onTap: () {
                  tabController.animateTo(0);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "User Management",
                isSelected: tabController.index == 1,
                onTap: () {
                  tabController.animateTo(1);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "Nurse Management",
                isSelected: tabController.index == 2,
                onTap: () {
                  tabController.animateTo(2);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "Nurse Requests",
                isSelected: tabController.index == 3,
                onTap: () {
                  tabController.animateTo(3);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "Payments",
                isSelected: tabController.index == 4,
                onTap: () {
                  tabController.animateTo(4);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "Feedback",
                isSelected: tabController.index == 5,
                onTap: () {
                  tabController.animateTo(5);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "Complaint",
                isSelected: tabController.index == 6,
                onTap: () {
                  tabController.animateTo(6);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "Change Password",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ChangePasswordDialog(),
                  );
                  //Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDrawerButton(
                label: "Logout",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Logout',
                      message: 'Are you sure that you want to logout ?',
                      primaryButtonLabel: 'Logout',
                      primaryOnPressed: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => true,
                        );
                        await Supabase.instance.client.auth.signOut();
                      },
                      secondaryButtonLabel: 'Cancel',
                      secondaryOnPressed: () => Navigator.pop(context),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
