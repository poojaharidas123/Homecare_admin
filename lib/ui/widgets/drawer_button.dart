import 'package:flutter/material.dart';

import '../../values/values.dart';
import 'custom_card.dart';

class CustomDrawerButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomCard(
        onPressed: onTap,
        color: isSelected ? Colors.white : primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isSelected ? primaryColor : Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
