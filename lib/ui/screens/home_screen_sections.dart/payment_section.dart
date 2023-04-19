import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_admin/ui/widgets/custom_action_button.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

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
                'Payment',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoSlidingSegmentedControl<String>(
                groupValue: 'pending',
                children: {
                  'pending': Text(
                    'Pending',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  'paid': Text(
                    'Paid',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                },
                onValueChanged: (status) {},
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(height: 1),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                'User',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              SizedBox(height: 3),
                              Text(
                                '#id',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 238,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nurse',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Pooja Haridas',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ]),
                          SizedBox(width: 550),
                          Text(
                            'Pending',
                            style: TextStyle(
                              color: Color(0xFFAAD013),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date Range',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              SizedBox(height: 3),
                              Text(
                                '14/11/2022 - 31/03/2023',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Salary',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '15,000',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
