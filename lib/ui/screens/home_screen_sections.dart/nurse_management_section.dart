import 'package:flutter/material.dart';

import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_search.dart';
import '../../widgets/label_with_text.dart';

class NurseManagementSection extends StatelessWidget {
  const NurseManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 1000,
          child: Column(
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
                    onPressed: () {},
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
                      onSearch: (query) {},
                    ),
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
                  itemBuilder: (context, index) => NurseCard(),
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

class NurseCard extends StatelessWidget {
  const NurseCard({
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#13424124',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Pooja Haridas',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
                ),
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Phone',
                    text: '98872346728',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Date of Birth',
                    text: '12/12/1990',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Email',
                    text: 'someemail@gmail.com',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Address',
                    text: 'Abc house,P.O.Morazha via Mottammal,Kannur',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Gender',
                    text: 'Female',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    label: 'Qualification',
                    text: 'SSLC,PLUS TWO,BSc Nursing',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LabelWithText(
                  label: 'Experience',
                  text: '1 Year(General)',
                ),
                Row(
                  children: [
                    CustomActionButton(
                      label: 'Edit',
                      iconData: Icons.edit,
                      color: Colors.orange,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomActionButton(
                      label: 'Block',
                      iconData: Icons.block,
                      color: Colors.red,
                      onPressed: () {},
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
