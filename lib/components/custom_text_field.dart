import 'package:flutter/material.dart';

Widget buildTextField({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required String hintText,
  required bool isRequired,
  TextInputType? keyboardType,
  required double Function(double) scaleX,
  required double Function(double) scaleY,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: scaleY(14).clamp(13.0, 15.0),
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      SizedBox(height: scaleY(10)),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        validator:
            isRequired
                ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
                : null,
        style: TextStyle(
          fontSize: scaleY(16).clamp(15.0, 17.0),
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xFFB0B8C5),
            fontSize: scaleY(16).clamp(15.0, 17.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: scaleX(16),
            vertical: scaleY(14),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE1E5ED), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE1E5ED), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF0D73FF), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    ],
  );
}
