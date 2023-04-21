import 'package:flutter/material.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_management_section.dart';

class SelectNurseScreen extends StatelessWidget {
  const SelectNurseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NurseManagementSection(
        onSelect: (nurse) {
          Navigator.of(context).pop(nurse);
        },
      ),
    );
  }
}
