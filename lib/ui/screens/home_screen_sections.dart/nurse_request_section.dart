import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/manage_nurse_requests/manage_nurse_request_bloc.dart';
import 'package:homecare_admin/blocs/nurse/nurse_bloc.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_management_section.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/user_management_section.dart';
import 'package:homecare_admin/ui/screens/select_nurse_screen.dart';
import 'package:homecare_admin/ui/widgets/custom_button.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/ui/widgets/custom_patient_card.dart';
import 'package:homecare_admin/ui/widgets/custom_search.dart';
import 'package:homecare_admin/ui/widgets/label_with_text.dart';
import 'package:homecare_admin/util/get_age.dart';
import 'package:homecare_admin/util/postgres_time_to_time_of_day.dart';
import 'package:homecare_admin/values/values.dart';
import 'package:intl/intl.dart';

import '../../../util/value_validators.dart';
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
                                    manageNurseRequestBloc:
                                        manageNurseRequestBloc,
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
  final ManageNurseRequestBloc manageNurseRequestBloc;
  const NurseRequestCard({
    super.key,
    required this.nurseRequestDetails,
    required this.manageNurseRequestBloc,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '#${nurseRequestDetails['id'].toString()}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Text(
                  nurseRequestDetails['status'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: primaryColor,
                      ),
                ),
                if (nurseRequestDetails['status'] == 'pending')
                  const SizedBox(width: 10),
                if (nurseRequestDetails['status'] == 'pending')
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ReasonForm(
                          manageNurseRequestBloc: manageNurseRequestBloc,
                          requestId: nurseRequestDetails['id'],
                        ),
                      );
                    },
                    child: Text(
                      'Reject Request',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
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
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        insetPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PatientCard(
                              patientDetails: nurseRequestDetails['patient'],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('View Details'),
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
                      if (nurseRequestDetails['status'] == 'pending')
                        TextButton(
                          child: const Text('Request Nurse'),
                          onPressed: () async {
                            dynamic nurse = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SelectNurseScreen(),
                              ),
                            );

                            if (nurse != null) {
                              manageNurseRequestBloc.add(
                                AssignNurseRequestEvent(
                                  requestId: nurseRequestDetails['id'],
                                  nurseId: nurse['user_id'],
                                ),
                              );
                            }
                          },
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
                    children: nurseRequestDetails['assigned_nurse']['name'] !=
                            null
                        ? [
                            TextButton(
                              child: const Text('View Assigned Nurse'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: SizedBox(
                                      width: 1000,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          NurseCard(
                                            nurseBloc: NurseBloc(),
                                            nurseDetails: nurseRequestDetails[
                                                'assigned_nurse'],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]
                        : [],
                  ),
                ),
              ],
            ),
            const Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Assign Requests',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (nurseRequestDetails['assign_requests'] != null &&
                nurseRequestDetails['assign_requests'].isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => AssignRequestItem(
                  assignRequestDetails: nurseRequestDetails['assign_requests']
                      [index],
                  manageNurseRequestBloc: manageNurseRequestBloc,
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: nurseRequestDetails['assign_requests'].length,
              )
            else
              const Center(
                child: Text('No Assign Requests'),
              ),
          ],
        ),
      ),
    );
  }
}

class AssignRequestItem extends StatelessWidget {
  final dynamic assignRequestDetails;
  final ManageNurseRequestBloc manageNurseRequestBloc;
  const AssignRequestItem({
    super.key,
    required this.assignRequestDetails,
    required this.manageNurseRequestBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
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
                    assignRequestDetails['nurse']['name'],
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 5),
                  if (assignRequestDetails['reason'] != null)
                    Text(
                      assignRequestDetails['reason'],
                    ),
                ],
              ),
            ),
            Text(
              assignRequestDetails['status'],
              style: const TextStyle(
                color: Color(0xFFAAD013),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                manageNurseRequestBloc.add(
                  DeleteAssignNurseRequestEvent(
                    assignNurseRequestId: assignRequestDetails['id'],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReasonForm extends StatefulWidget {
  final ManageNurseRequestBloc manageNurseRequestBloc;
  final int requestId;
  const ReasonForm({
    super.key,
    required this.manageNurseRequestBloc,
    required this.requestId,
  });

  @override
  State<ReasonForm> createState() => _ReasonFormState();
}

class _ReasonFormState extends State<ReasonForm> {
  final TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Reason',
      message: 'Enter a reason to reject the request',
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: reasonController,
          minLines: 3,
          maxLines: 5,
          validator: alphaNumericValidator,
          decoration: const InputDecoration(
            hintText: 'Reason',
            prefixIcon: Icon(
              Icons.receipt_outlined,
            ),
          ),
        ),
      ),
      primaryButtonLabel: 'Reject',
      primaryOnPressed: () {
        if (formKey.currentState!.validate()) {
          widget.manageNurseRequestBloc.add(
            RejectNurseRequestEvent(
              requestId: widget.requestId,
              reason: reasonController.text.trim(),
            ),
          );
          Navigator.pop(context);
        }
      },
    );
  }
}
