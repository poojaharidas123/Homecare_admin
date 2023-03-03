import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homecare_admin/ui/screens/home_screen_sections.dart/user_management_section.dart';
import 'package:homecare_admin/ui/widgets/custom_button.dart';

class NurseRequestSection extends StatelessWidget {
  const NurseRequestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 1000,
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Text(
                    'Home Nurse Request',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('#id'),
                          SizedBox(
                            width: 200,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Patient Details',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Krithya M P',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '5 months',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                'F',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '14/11/2022',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '31/03/2023',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '01:00 PM - 04:00 PM',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Cough',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Fever',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Cold',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          CustomButton(label: 'Add', onPressed: () {})
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
