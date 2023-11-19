import 'package:flutter/material.dart';
import 'package:mitrevels22/ui/widgets/user_text_field.dart';

class PersonalInfoSheet extends StatelessWidget {
  final String college;
  final String course;
  final String registrationNumber;
  final int mobileNumber;
  final String email;
  const PersonalInfoSheet({
    Key? key,
    required this.college,
    required this.course,
    required this.email,
    required this.mobileNumber,
    required this.registrationNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(32),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: Text(
            "Personal Information:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        UserTextField(
          label: "College",
          value: college,
        ),
        UserTextField(
          label: "Registration No.",
          value: registrationNumber,
        ),
        UserTextField(
          label: "Branch",
          value: course,
        ),
        UserTextField(
          label: "Phone Number",
          value: mobileNumber.toString(),
        ),
        UserTextField(
          label: "Email",
          value: email,
        ),
      ],
    );
  }
}
