import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class GenderSelector extends StatefulWidget {
  const GenderSelector({
    Key? key,
    required this.onSelect,
  }) : super(key: key);
  final Function(GenderTypes) onSelect;
  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  GenderTypes selectedGender = GenderTypes.male;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: const Color(0XFFcdcdcd),
        ),
      ),
      child: Row(
        children: [
          Text(context.locale.gender),
          const SizedBox(
            width: 40,
          ),
          GenderRadioButton(
            title: context.locale.male,
            genderType: GenderTypes.male,
            selectedGender: selectedGender,
            onSelect: (value) {
              setState(() {
                selectedGender = value;
              });
              widget.onSelect(selectedGender);
            },
          ),
          GenderRadioButton(
            selectedGender: selectedGender,
            title: context.locale.female,
            genderType: GenderTypes.female,
            onSelect: (value) {
              setState(() {
                selectedGender = value;
              });
              widget.onSelect(selectedGender);
            },
          ),
        ],
      ),
    );
  }
}

class GenderRadioButton extends StatelessWidget {
  const GenderRadioButton({
    Key? key,
    required this.title,
    required this.genderType,
    required this.selectedGender,
    required this.onSelect,
  }) : super(key: key);
  final String title;
  final GenderTypes genderType;
  final GenderTypes selectedGender;
  final Function(GenderTypes) onSelect;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect(genderType);
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 30),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 8, top: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: genderType == selectedGender
                      ? context.theme.colorScheme.primary
                      : Colors.black,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(2),
              child: genderType == selectedGender
                  ? Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : const SizedBox(
                      height: 7,
                      width: 7,
                    ),
            ),
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }
}
