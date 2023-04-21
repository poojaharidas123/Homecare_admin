import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/manage_nurse_requests/manage_nurse_request_bloc.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/user_management_section.dart';
import 'package:homecare_admin/ui/widgets/custom_button.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/ui/widgets/custom_search.dart';
import 'package:homecare_admin/ui/widgets/label_with_text.dart';
import 'package:homecare_admin/util/get_age.dart';
import 'package:homecare_admin/util/postgres_time_to_time_of_day.dart';
import 'package:homecare_admin/values/values.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_alert_dialog.dart';

class NurseRequestSection extends StatefulWidget {
  final bool fromDashboard;
  const NurseRequestSection({
    super.key,
    this.fromDashboard = false,
  });

  @override
  State<NurseRequestSection> createState() => _NurseRequestSectionState();
}

class _NurseRequestSectionState extends State<NurseRequestSection> {
  String _selectedStatus = 'pending';
  String? query;
  final ManageNurseRequestBloc manageNurseRequestBloc =
      ManageNurseRequestBloc();

  @override
  void initState() {
    super.initState();
    getNurseRequests();
  }

  void getNurseRequests() {
    manageNurseRequestBloc.add(
      GetAllNurseRequestEvent(
        status: _selectedStatus,
        query: query,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocProvider<ManageNurseRequestBloc>.value(
          value: manageNurseRequestBloc,
          child: BlocConsumer<ManageNurseRequestBloc, ManageNurseRequestState>(
            listener: (context, state) {
              if (state is ManageNurseRequestFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Retry',
                    primaryOnPressed: () {
                      getNurseRequests();
                      Navigator.pop(context);
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!widget.fromDashboard)
                      const SizedBox(
                        height: 60,
                      ),
                    if (!widget.fromDashboard)
                      const Text(
                        'Home Nurse Request Management',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (!widget.fromDashboard)
                      const SizedBox(
                        height: 20,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomSearch(
                            onSearch: (q) {
                              query = q;
                              getNurseRequests();
                            },
                          ),
                        ),
                        if (!widget.fromDashboard) const SizedBox(width: 20),
                        if (!widget.fromDashboard)
                          CupertinoSlidingSegmentedControl<String>(
                            groupValue: _selectedStatus,
                            children: {
                              'pending': Text(
                                'Pending',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              'active': Text(
                                'Active',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              'rejected': Text(
                                'Rejected',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            },
                            onValueChanged: (status) {
                              _selectedStatus = status!;
                              getNurseRequests();
                              setState(() {});
                            },
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: state is ManageNurseRequestSuccessState
                          ? state.requests.isNotEmpty
                              ? ListView.separated(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  itemBuilder: (context, index) =>
                                      NurseRequestCard(
                                    nurseRequestDetails: state.requests[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: state.requests.length,
                                )
                              : const Center(
                                  child: Text('No Nurse Requests Found'))
                          : const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NurseRequestCard extends StatelessWidget {
  final dynamic nurseRequestDetails;
  const NurseRequestCard({
    super.key,
    required this.nurseRequestDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${nurseRequestDetails['id'].toString()}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  nurseRequestDetails['status'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: primaryColor,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nurseRequestDetails['patient']['name'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${getAge(DateTime.parse(nurseRequestDetails['patient']['dob']))} ${nurseRequestDetails['patient']['gender']}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Date Range',
                    text:
                        '${DateFormat('dd/MM/yyyy').format(DateTime.parse(nurseRequestDetails['date_start']))} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(nurseRequestDetails['date_end']))} ',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Time Range',
                    text:
                        '${convertPostgresTimeToTimeOfDay(nurseRequestDetails['time_start']).format(context)} - ${convertPostgresTimeToTimeOfDay(nurseRequestDetails['time_end']).format(context)}',
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Assigned Nurse'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Accepted Nurse',
                    text: nurseRequestDetails['assigned_nurse']['name'] ??
                        'Not Accepted',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Amount',
                    text: nurseRequestDetails['amount']?.toString() ??
                        'Not determined',
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('View Assigned Nurse'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Assign Request',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Material(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pooja Haridas',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          const Text('Reason'),
                        ],
                      ),
                    ),
                    const Text(
                      'Pending',
                      style: TextStyle(
                        color: Color(0xFFAAD013),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
