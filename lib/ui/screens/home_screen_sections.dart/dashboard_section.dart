import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_request_section.dart';
import 'package:homecare_admin/ui/widgets/dashcard.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 1000,
            child: Column(
              children: [
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: const [
                    DashCard(
                      label: 'Nurse Bookings',
                      value: '2345',
                      iconData: Icons.book_outlined,
                    ),
                    DashCard(
                      label: 'Nurses',
                      value: '3452',
                      iconData: Icons.medical_information_outlined,
                    ),
                    DashCard(
                      label: 'Patients',
                      value: '4231',
                      iconData: Icons.person_outline,
                    ),
                    DashCard(
                      label: 'Complaints',
                      value: '100',
                      iconData: Icons.masks_outlined,
                    ),
                  ],
                ),
                const Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Pending Requests',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: NurseRequestSection(
                    fromDashboard: true,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
