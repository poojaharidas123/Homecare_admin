import 'dart:ui';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home Nurse Request Management',
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
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'user',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '#id',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Text(
                            'Pending',
                            style: TextStyle(
                              color: Color(0xFFAAD013),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Patient Deatils:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Krithya M P',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 3),
                              Row(
                                children: [
                                  Text('5 months'),
                                  SizedBox(width: 5),
                                  Text('F'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 168),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date Range:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Text('14/11/2022'),
                                  Text(' - '),
                                  Text('31/03/2023'),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time Range:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text('01:00 PM - 04:00 PM'),
                            ],
                          ),
                          SizedBox(width: 113),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Health Conditions',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text('Cough,Fever,Cold'),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
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
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Meditations',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('OTC Cough Medicine'),
                          SizedBox(
                            width: 100,
                          ),
                          Text('1-0-0-1'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Acetaminophen'),
                          SizedBox(
                            width: 133,
                          ),
                          Text('1-1-0-0'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Nasal Saline Drops'),
                          SizedBox(
                            width: 114,
                          ),
                          Text('1-0-0-1'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Assign Request'),
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
                      Row(
                        children: [
                          Text(
                            'Pooja Haridas',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reason'),
                          Text(
                            'Pending',
                            style: TextStyle(
                              color: Color(0xFFAAD013),
                            ),
                          ),
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
