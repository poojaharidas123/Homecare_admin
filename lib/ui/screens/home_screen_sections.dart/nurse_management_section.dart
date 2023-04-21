import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecare_admin/blocs/nurse/nurse_bloc.dart';
import 'package:homecare_admin/ui/widgets/gender_selector.dart';
import 'package:homecare_admin/util/get_age.dart';
import 'package:homecare_admin/util/value_validators.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/label_with_text.dart';

class NurseManagementSection extends StatefulWidget {
  final Function(dynamic)? onSelect;
  const NurseManagementSection({
    super.key,
    this.onSelect,
  });

  @override
  State<NurseManagementSection> createState() => _NurseManagementSectionState();
}

class _NurseManagementSectionState extends State<NurseManagementSection> {
  final NurseBloc nurseBloc = NurseBloc();
  String? query;

  @override
  void initState() {
    super.initState();
    getNurses();
  }

  void getNurses() {
    nurseBloc.add(GetAllNurseEvent(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 1000,
          child: BlocProvider<NurseBloc>.value(
            value: nurseBloc,
            child: BlocConsumer<NurseBloc, NurseState>(
              listener: (context, state) {
                if (state is NurseFailureState) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Failure',
                      message: state.message,
                      primaryButtonLabel: 'Retry',
                      primaryOnPressed: () {
                        getNurses();
                        Navigator.pop(context);
                      },
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Home Nurse Management',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        CustomActionButton(
                          label: 'Add Nurse',
                          iconData: Icons.add_circle_outline,
                          color: Colors.green,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddNurseForm(
                                nurseBloc: nurseBloc,
                              ),
                            );
                          },
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
                            onSearch: (q) {
                              query = q;
                              getNurses();
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
                      child: state is NurseSuccessState
                          ? state.nurses.isEmpty
                              ? const Center(child: Text('No Nurses Found'))
                              : ListView.separated(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  itemBuilder: (context, index) => NurseCard(
                                    onSelect: widget.onSelect != null
                                        ? () {
                                            widget.onSelect!
                                                .call(state.nurses[index]);
                                          }
                                        : null,
                                    nurseBloc: nurseBloc,
                                    nurseDetails: state.nurses[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: state.nurses.length,
                                )
                          : const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class AddNurseForm extends StatefulWidget {
  final NurseBloc nurseBloc;
  final Map<String, dynamic>? nurseDetails;
  const AddNurseForm({
    super.key,
    required this.nurseBloc,
    this.nurseDetails,
  });

  @override
  State<AddNurseForm> createState() => _AddNurseFormState();
}

class _AddNurseFormState extends State<AddNurseForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String gender = 'female';
  bool _isObscure = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.nurseDetails != null) {
      _nameController.text = widget.nurseDetails!['name'];
      gender = widget.nurseDetails!['gender'];
      _emailController.text = widget.nurseDetails!['email'];
      _dobController.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.nurseDetails!['dob']));
      _phoneController.text = widget.nurseDetails!['phone'];
      _rateController.text = widget.nurseDetails!['hourly_rate'].toString();
      _experienceController.text = widget.nurseDetails!['experience'];
      _qualificationController.text = widget.nurseDetails!['qualification'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 900,
      title: widget.nurseDetails != null ? 'Edit Nurse' : 'Add Nurse',
      message:
          'Enter the following details to ${widget.nurseDetails != null ? 'edit the' : 'add a'} nurse',
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: alphaNumericValidator,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    validator: (value) {
                      if (widget.nurseDetails != null) {
                        if (value != null && value.isNotEmpty) {
                          return passwordValidator(value);
                        } else {
                          return null;
                        }
                      } else {
                        return passwordValidator(value);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isObscure = !_isObscure;
                          setState(() {});
                        },
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmController,
                    obscureText: _isObscure,
                    validator: (value) {
                      if (widget.nurseDetails != null) {
                        if (value != null && value.isNotEmpty) {
                          return confirmPasswordValidator(
                              value, _passwordController.text.trim());
                        } else {
                          return null;
                        }
                      } else {
                        return confirmPasswordValidator(
                            value, _passwordController.text.trim());
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dobController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(1990),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(
                          2004,
                        ),
                      );

                      if (date != null) {
                        _dobController.text =
                            DateFormat('yyyy-MM-dd').format(date);
                        setState(() {});
                      }
                    },
                    validator: (d) {
                      if (d != null && d.isNotEmpty) {
                        return null;
                      } else {
                        return 'Select Date to Continue';
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Date of Birth',
                      prefixIcon: Icon(
                        Icons.date_range,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: _phoneController,
                    validator: phoneValidator,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _rateController,
                    validator: numericValidator,
                    decoration: const InputDecoration(
                      hintText: 'Hourly Rate',
                      prefixIcon: Icon(
                        Icons.money,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _experienceController,
                    validator: alphaNumericValidator,
                    decoration: const InputDecoration(
                      hintText: 'Experience',
                      prefixIcon: Icon(
                        Icons.work_outline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _qualificationController,
                    validator: alphaNumericValidator,
                    decoration: const InputDecoration(
                      hintText: 'Qualification',
                      prefixIcon: Icon(
                        Icons.file_copy_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GenderSelector(
                    selected: gender,
                    onSelect: (g) {
                      gender = g;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      primaryButtonLabel: widget.nurseDetails != null ? 'Update' : 'Add',
      primaryOnPressed: () {
        if (formKey.currentState!.validate()) {
          if (widget.nurseDetails != null) {
            widget.nurseBloc.add(
              EditNurseEvent(
                userId: widget.nurseDetails!['user_id'],
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim().isNotEmpty
                    ? _passwordController.text.trim()
                    : null,
                gender: gender,
                experience: _experienceController.text.trim(),
                qualification: _qualificationController.text.trim(),
                hourlyRate: int.parse(_rateController.text.trim()),
                dob: _dobController.text.trim(),
              ),
            );
          } else {
            widget.nurseBloc.add(
              AddNurseEvent(
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                gender: gender,
                experience: _experienceController.text.trim(),
                qualification: _qualificationController.text.trim(),
                hourlyRate: int.parse(_rateController.text.trim()),
                dob: _dobController.text.trim(),
              ),
            );
          }

          Navigator.pop(context);
        }
      },
      secondaryButtonLabel: 'Cancel',
    );
  }
}

class NurseCard extends StatelessWidget {
  final Map<String, dynamic> nurseDetails;
  final NurseBloc nurseBloc;
  final Function()? onSelect;
  const NurseCard({
    super.key,
    required this.nurseDetails,
    required this.nurseBloc,
    this.onSelect,
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${nurseDetails['user_id']}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        nurseDetails['name'],
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${getAge(DateTime.parse(nurseDetails['dob']))} ${nurseDetails['gender']}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    nurseBloc
                        .add(DeleteNurseEvent(userId: nurseDetails['user_id']));
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Phone',
                    text: nurseDetails['phone'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Date of Birth',
                    text: DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(nurseDetails['dob'])),
                  ),
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
                    label: 'Email',
                    text: nurseDetails['email'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Hourly Rate',
                    text: nurseDetails['hourly_rate'].toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: LabelWithText(
                    label: 'Experience',
                    text: nurseDetails['experience'],
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Qualification',
                    text: nurseDetails['qualification'],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelWithText(
                  label: 'Status',
                  text: nurseDetails['status'],
                ),
                Row(
                  children: [
                    if (onSelect != null)
                      CustomActionButton(
                        label: 'Select',
                        iconData: Icons.done,
                        color: Colors.blue,
                        onPressed: onSelect!,
                      ),
                    if (onSelect != null) const SizedBox(width: 10),
                    CustomActionButton(
                      label: 'Edit',
                      iconData: Icons.edit,
                      color: Colors.orange,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddNurseForm(
                            nurseBloc: nurseBloc,
                            nurseDetails: nurseDetails,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    nurseDetails['status'] == 'active'
                        ? CustomActionButton(
                            label: 'Block',
                            iconData: Icons.block,
                            color: Colors.red,
                            onPressed: () {
                              nurseBloc.add(
                                ChangeStatusNurseEvent(
                                  userId: nurseDetails['user_id'],
                                  status: 'blocked',
                                ),
                              );
                            },
                          )
                        : CustomActionButton(
                            label: 'Activate',
                            iconData: Icons.done,
                            color: Colors.green,
                            onPressed: () {
                              nurseBloc.add(
                                ChangeStatusNurseEvent(
                                  userId: nurseDetails['user_id'],
                                  status: 'active',
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
