import 'package:curdy/presentation/bottom_navigation_bar.dart';
import 'package:curdy/presentation/personal_information.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    const double designWidth = 375;
    const double designHeight = 812;

    double scaleY(double value) => value * size.height / designHeight;

    final double topSectionHeight =
        size.height < 600 ? scaleY(320) : size.height * 0.42;
    final double verticalPadding = size.height * 0.035;
    final double horizontalPadding = size.width * 0.08;

    final double titleFontSize =
        (theme.textTheme.titleLarge?.fontSize ?? 22) *
        (size.width / designWidth).clamp(0.9, 1.2);
    final double subtitleFontSize =
        (theme.textTheme.bodyMedium?.fontSize ?? 16) *
        (size.width / designWidth).clamp(0.9, 1.15);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: topSectionHeight,
            child: Image.asset(
              'assets/Welcome_screen_photo.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome to Cardy',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: scaleY(8)),
                  Text(
                    'Please enter your phone number',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: subtitleFontSize,
                      color: const Color(0xFF6F7A8A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: scaleY(32)),
                  _PhoneField(
                    fieldHeight: scaleY(56),
                    dividerHeight: scaleY(24),
                  ),
                  SizedBox(height: scaleY(24)),
                  SizedBox(
                    height: scaleY(52).clamp(44.0, 56.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D73FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalInformation(),
                          ),
                        );
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: scaleY(16).clamp(14.0, 18.0),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: scaleY(18)),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize:
                            (theme.textTheme.bodySmall?.fontSize ?? 13) *
                            (size.width / designWidth).clamp(0.9, 1.1),
                        color: const Color(0xFF8D96A5),
                      ),
                      children: const [
                        TextSpan(
                          text:
                              'By entering your phone number, you agree to our    ',
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Color(0xFF0D73FF),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserTabBar(),
                        ),
                      );
                    },
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        color: const Color(0xFF0D73FF),
                        fontSize: scaleY(14).clamp(12.0, 16.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneField extends StatefulWidget {
  const _PhoneField({
    Key? key,
    required this.fieldHeight,
    required this.dividerHeight,
  }) : super(key: key);

  final double fieldHeight;
  final double dividerHeight;

  @override
  State<_PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<_PhoneField> {
  CountryCode selectedCountry = CountryCode.fromCode('LB');
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double designWidth = 375;
    double scaleX(double value) => value * size.width / designWidth;
    double scaleY(double value) => value * size.height / 812;

    return Container(
      height: widget.fieldHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E5ED), width: 1),
      ),
      child: Row(
        children: [
          // Country Code Picker
          IntrinsicWidth(
            child: CountryCodePicker(
              onChanged: (CountryCode country) {
                setState(() {
                  selectedCountry = country;
                });
              },
              backgroundColor: Colors.white,
              barrierColor: Colors.black54,
              initialSelection: 'LB',
              favorite: const ['+961', 'LB'],
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              padding: EdgeInsets.symmetric(horizontal: scaleX(8)),
              textStyle: TextStyle(
                fontSize: scaleY(14).clamp(13.0, 15.0),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              flagWidth: scaleX(20).clamp(18.0, 24.0),
              showFlag: true,
              showFlagDialog: true,
              hideMainText: false,
              showDropDownButton: false,
              enabled: true,
              dialogSize: Size(size.width * 0.9, size.height * 0.7),
              dialogBackgroundColor: Colors.white,
              dialogTextStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              searchDecoration: InputDecoration(
                hintText: 'Search country',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              searchStyle: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          // Divider
          Container(
            width: 1,
            height: widget.dividerHeight,
            color: const Color(0xFFE1E5ED),
          ),
          // Phone Number Text Field
          Expanded(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontSize: scaleY(16).clamp(15.0, 17.0),
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: scaleX(12),
                  vertical: scaleY(14),
                ),
                hintText: 'Enter phone number',
                hintStyle: TextStyle(
                  color: const Color(0xFFB0B8C5),
                  fontSize: scaleY(16).clamp(15.0, 17.0),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
