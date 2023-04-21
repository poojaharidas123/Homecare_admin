import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/suggestion/suggestion_bloc.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/ui/widgets/label_with_text.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_alert_dialog.dart';

class FeedbackSection extends StatefulWidget {
  const FeedbackSection({super.key});

  @override
  State<FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  final SuggestionBloc suggestionBloc = SuggestionBloc();

  @override
  void initState() {
    super.initState();
    suggestionBloc.add(GetAllSuggestionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocProvider<SuggestionBloc>.value(
          value: suggestionBloc,
          child: BlocConsumer<SuggestionBloc, SuggestionState>(
            listener: (context, state) {
              if (state is SuggestionFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Retry',
                    primaryOnPressed: () {
                      suggestionBloc.add(GetAllSuggestionEvent());
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
                      'Feedbacks',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: state is SuggestionSuccessState
                          ? state.suggestions.isNotEmpty
                              ? ListView.separated(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  itemBuilder: (context, index) => FeedbackCard(
                                    feedbackDetails: state.suggestions[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: state.suggestions.length,
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
              );
            },
          ),
        ),
      ],
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final dynamic feedbackDetails;
  const FeedbackCard({
    super.key,
    required this.feedbackDetails,
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
                        '#${feedbackDetails['id']}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm a').format(
                            DateTime.parse(feedbackDetails['created_at'])),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text(
                    feedbackDetails['suggestion'],
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
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
