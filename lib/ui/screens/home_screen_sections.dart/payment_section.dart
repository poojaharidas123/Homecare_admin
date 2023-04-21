import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/manage_nurse_requests/manage_nurse_request_bloc.dart';
import 'package:homecare_admin/blocs/payments/payments_bloc.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/nurse_request_section.dart';
import 'package:homecare_admin/ui/widgets/custom_action_button.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/ui/widgets/label_with_text.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../widgets/custom_alert_dialog.dart';

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  final PaymentsBloc paymentsBloc = PaymentsBloc();

  @override
  void initState() {
    super.initState();
    paymentsBloc.add(PaymentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocProvider<PaymentsBloc>.value(
          value: paymentsBloc,
          child: BlocConsumer<PaymentsBloc, PaymentsState>(
            listener: (context, state) {
              if (state is PaymentsFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Retry',
                    primaryOnPressed: () {
                      paymentsBloc.add(PaymentsEvent());
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
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      'Payment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: state is PaymentsSuccessState
                          ? state.payments.isNotEmpty
                              ? ListView.separated(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  itemBuilder: (context, index) => PaymentCard(
                                    paymentDetails: state.payments[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: state.payments.length,
                                )
                              : const Center(
                                  child: Text('No Payments Found'),
                                )
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

class PaymentCard extends StatelessWidget {
  final dynamic paymentDetails;
  const PaymentCard({
    super.key,
    required this.paymentDetails,
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
                  Text(
                    '#${paymentDetails['payment']['id']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15),
                  LabelWithText(
                    label: 'Nurse Booking ID',
                    text: '#${paymentDetails['request']['id']}',
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: SizedBox(
                            width: 900,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                NurseRequestCard(
                                  nurseRequestDetails:
                                      paymentDetails['request'],
                                  manageNurseRequestBloc:
                                      ManageNurseRequestBloc(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View Booking Details',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LabelWithText(
                    label: 'Paid At',
                    text: DateFormat('dd/MM/yyyy hh:mm a').format(
                        DateTime.parse(
                            paymentDetails['payment']['created_at'])),
                    alignment: CrossAxisAlignment.end,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '₹${paymentDetails['payment']['amount'].toString()}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
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
