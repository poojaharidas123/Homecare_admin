import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/user_management_section.dart';
import 'package:homecare_admin/ui/widgets/custom_button.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/ui/widgets/custom_search.dart';
import 'package:homecare_admin/ui/widgets/label_with_text.dart';
import 'package:homecare_admin/values/values.dart';

class NurseRequestSection extends StatefulWidget {
  const NurseRequestSection({super.key});

  @override
  State<NurseRequestSection> createState() => _NurseRequestSectionState();
}

class _NurseRequestSectionState extends State<NurseRequestSection> {
  String _selectedStatus = 'pending';
  @override
  Widget build(BuildContext context) {
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
                'Home Nurse Request Management',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomSearch(
                      onSearch: (query) {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  CupertinoSlidingSegmentedControl<String>(
                    groupValue: _selectedStatus,
                    children: {
                      'pending': Text(
                        'Pending',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      'active': Text(
                        'Active',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      'complete': Text(
                        'Complete',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    },
                    onValueChanged: (status) {
                      _selectedStatus = status!;
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
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) => const NurseRequestCard(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NurseRequestCard extends StatelessWidget {
  const NurseRequestCard({
    super.key,
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
                  '#51344234214',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Pending',
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
                      'Krithya M P',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '20 Female',
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
                const Expanded(
                  child: LabelWithText(
                    label: 'Time Range',
                    text: '14/11/2022 - 14/01/2023',
                  ),
                ),
                const Expanded(
                  child: LabelWithText(
                    label: 'Time Range',
                    text: '01:00 PM - 04:00 PM',
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: CustomButton(
                    label: 'Assign Request',
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
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
