import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './../../../../core/core.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({Key? key, required this.controller, this.validator})
      : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField>
    with ValidationMixin {
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
              controller: widget.controller,
              validator: (phone) {
                if (validatePhoneNumber(phone, context) == null) {
                  errorText = "";
                  setState(() {});
                  return null;
                }
                errorText = validatePhoneNumber(phone, context)!;
                setState(() {});
                return "";
              },
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(9),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                prefixIcon: const SizedBox(
                  width: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "+966  | ",
                      ),
                    ),
                  ),
                ),
                hintText: context.locale.phone,
                hintStyle: context.textTheme.bodySmall,
                hintTextDirection: context.locale.localeName == "ar"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(13, 12, 0, 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0XFFcdcdcd)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorStyle: const TextStyle(fontSize: 0, height: 1),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.red[600]!,
                  ),
                ),
                fillColor: Colors.white,
              ),
            ),
          ),
          errorText.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    errorText,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.red[900]),
                  ),
                ),
        ],
      ),
    );
  }
}
