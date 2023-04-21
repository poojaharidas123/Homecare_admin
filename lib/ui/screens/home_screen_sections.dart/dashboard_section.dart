import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/dashboard_count/dashboard_count_bloc.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_request_section.dart';
import 'package:homecare_admin/ui/widgets/dashcard.dart';

import '../../widgets/custom_alert_dialog.dart';

class DashboardSection extends StatefulWidget {
  const DashboardSection({super.key});

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {
  final DashboardCountBloc dashboardCountBloc = DashboardCountBloc();
  @override
  void initState() {
    super.initState();
    dashboardCountBloc.add(DashboardCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocProvider<DashboardCountBloc>.value(
          value: dashboardCountBloc,
          child: BlocConsumer<DashboardCountBloc, DashboardCountState>(
            listener: (context, state) {
              if (state is DashboardCountFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Retry',
                    primaryOnPressed: () {
                      dashboardCountBloc.add(DashboardCountEvent());
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
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
                      if (state is DashboardCountSuccessState)
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            DashCard(
                              label: 'Nurse Bookings',
                              value: state.dashbordCount['nurse_requests']
                                  .toString(),
                              iconData: Icons.book_outlined,
                            ),
                            DashCard(
                              label: 'Nurses',
                              value: state.dashbordCount['nurses'].toString(),
                              iconData: Icons.medical_information_outlined,
                            ),
                            DashCard(
                              label: 'Patients',
                              value: state.dashbordCount['patients'].toString(),
                              iconData: Icons.person_outline,
                            ),
                            DashCard(
                              label: 'Complaints',
                              value:
                                  state.dashbordCount['complaints'].toString(),
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
                      const Expanded(
                        child: NurseRequestSection(
                          fromDashboard: true,
                        ),
                      ),
                    ],
                  ));
            },
          ),
        )
      ],
    );
  }
}
