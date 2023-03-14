import 'package:flutter/material.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_management_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_request_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/payment_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/feedback_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/user_management_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/complaint_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/dashboard_section.dart';

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
        backgroundColor: Color(0xFFAAD013),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Home Screen"),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const DashboardSection(),
          const UserManagementSection(),
          const NurseManagementSection(),
          const NurseRequestSection(),
          const PaymentSection(),
          const FeedbackSection(),
          const ComplaintSection(),
        ],
      ),
      drawer: SizedBox(
        width: 300,
        child: Material(
          color: Color(0xFFAAD013),
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
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawerButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: isSelected ? Colors.white : Color(0xFFAAD013),
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: isSelected ? null : onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isSelected ? Color(0xFFAAD013) : Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
