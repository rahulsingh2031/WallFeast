import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.mainText,
    this.obscureText = false,
    required this.validator,
    required this.onSaved,
    this.onChanged,
  });
  final String mainText;
  final bool obscureText;
  final String? Function(String?) validator;
  final void Function(String?) onSaved;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            mainText,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 2,
          ),
          TextFormField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: mainText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context)
                        .colorScheme
                        .inverseSurface
                        .withOpacity(0.5),
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1.5,
                    color: Theme.of(context)
                        .colorScheme
                        .inverseSurface
                        .withOpacity(0.6)),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
          )
        ],
      ),
    );
  }
}
