import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/manage_patients/manage_patients_bloc.dart';
import 'package:homecare_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:homecare_admin/ui/widgets/custom_card.dart';
import 'package:homecare_admin/ui/widgets/custom_patient_card.dart';

import '../../widgets/custom_search.dart';
import '../../widgets/label_with_text.dart';

class UserManagementSection extends StatefulWidget {
  const UserManagementSection({super.key});

  @override
  State<UserManagementSection> createState() => _UserManagementSectionState();
}

class _UserManagementSectionState extends State<UserManagementSection> {
  final ManagePatientsBloc managePatientsBloc = ManagePatientsBloc();

  @override
  void initState() {
    super.initState();
    managePatientsBloc.add(GetAllPatientsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocProvider<ManagePatientsBloc>.value(
          value: managePatientsBloc,
          child: BlocConsumer<ManagePatientsBloc, ManagePatientsState>(
            listener: (context, state) {
              if (state is ManagePatientsFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    message: state.message,
                    primaryButtonLabel: 'Retry',
                    primaryOnPressed: () {
                      managePatientsBloc.add(GetAllPatientsEvent());
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "User Management",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomSearch(
                            onSearch: (query) {
                              managePatientsBloc
                                  .add(GetAllPatientsEvent(query: query));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: state is ManagePatientsSuccessState
                          ? state.patients.isNotEmpty
                              ? SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: List.generate(
                                      state.patients.length,
                                      (index) => PatientCard(
                                        patientDetails: state.patients[index],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text('No Patients Found'),
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
