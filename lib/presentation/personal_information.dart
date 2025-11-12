import 'package:curdy/components/custom_text_field.dart';
import 'package:curdy/presentation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    const double designWidth = 375;
    const double designHeight = 812;

    double scaleX(double value) => value * size.width / designWidth;
    double scaleY(double value) => value * size.height / designHeight;

    final double horizontalPadding = scaleX(24);
    final double verticalPadding = scaleY(24);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: scaleY(20).clamp(18.0, 22.0),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0D73FF),
              ),
            ),
            SizedBox(height: scaleY(8)),
            Container(
              width: scaleX(60),
              height: 2,
              color: const Color(0xFF0D73FF),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Personal Info',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: scaleY(18).clamp(16.0, 20.0),
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: scaleY(32)),
                  // First Name Field
                  buildTextField(
                    context: context,
                    label: 'First Name*',
                    controller: _firstNameController,
                    hintText: 'First Name',
                    isRequired: true,
                    scaleX: scaleX,
                    scaleY: scaleY,
                  ),
                  SizedBox(height: scaleY(24)),
                  // Last Name Field
                  buildTextField(
                    context: context,
                    label: 'Last Name*',
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    isRequired: true,
                    scaleX: scaleX,
                    scaleY: scaleY,
                  ),
                  SizedBox(height: scaleY(24)),
                  // Email Address Field (Optional)
                  buildTextField(
                    context: context,
                    label: 'Email Address (Optional)',
                    controller: _emailController,
                    hintText: 'Email Address',
                    isRequired: false,
                    keyboardType: TextInputType.emailAddress,
                    scaleX: scaleX,
                    scaleY: scaleY,
                  ),
                  SizedBox(height: scaleY(32)),
                  // Submit Button
                  SizedBox(
                    height: scaleY(50).clamp(48.0, 54.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D73FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.green,
                              content: Text('Profile updated successfully'),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserTabBar(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: scaleY(16).clamp(15.0, 17.0),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
