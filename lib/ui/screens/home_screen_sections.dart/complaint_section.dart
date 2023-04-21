import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/complaint/complaint_bloc.dart';
import 'package:homecare_admin/blocs/manage_nurse_requests/manage_nurse_request_bloc.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_request_section.dart';
import 'package:homecare_admin/ui/widgets/custom_button.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/ui/widgets/label_with_text.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_alert_dialog.dart';

class ComplaintSection extends StatefulWidget {
  const ComplaintSection({super.key});

  @override
  State<ComplaintSection> createState() => _ComplaintSectionState();
}

class _ComplaintSectionState extends State<ComplaintSection> {
  final ComplaintBloc complaintBloc = ComplaintBloc();
  String selectedType = 'nurse';

  @override
  void initState() {
    super.initState();
    getComplaints();
  }

  void getComplaints() {
    complaintBloc.add(GetAllComplaintEvent(type: selectedType));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintBloc>.value(
      value: complaintBloc,
      child: BlocConsumer<ComplaintBloc, ComplaintState>(
        listener: (context, state) {
          if (state is ComplaintFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                message: state.message,
                primaryButtonLabel: 'Retry',
                primaryOnPressed: () {
                  getComplaints();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      'Complaints',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoSlidingSegmentedControl<String>(
                      groupValue: selectedType,
                      children: {
                        'nurse': Text(
                          'Nurse',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        'user': Text(
                          'User',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      },
                      onValueChanged: (status) {
                        selectedType = status ?? 'nurse';
                        setState(() {});
                        getComplaints();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: state is ComplaintSuccessState
                          ? state.complaints.isNotEmpty
                              ? ListView.separated(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  itemBuilder: (context, index) =>
                                      ComplaintCard(
                                    complaintDetails: state.complaints[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: state.complaints.length,
                                )
                              : const Center(
                                  child: Text('No Feedbacks Found'),
                                )
                          : const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final dynamic complaintDetails;
  const ComplaintCard({
    super.key,
    required this.complaintDetails,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#${complaintDetails['complaint']['id']}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(
                            complaintDetails['complaint']['created_at'])),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text(
                    complaintDetails['complaint']['complaint'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextButton(
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
                                            NurseRequestCard(
                                              nurseRequestDetails:
                                                  complaintDetails['request'],
                                              manageNurseRequestBloc:
                                                  ManageNurseRequestBloc(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Text('View Request Details'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
