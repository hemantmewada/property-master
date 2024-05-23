import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditions extends StatefulWidget {
  TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.terrmsAndConditions,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0,),
            const Text('1. Acceptance of Terms',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            const Text('By accessing or using the App, you agree to these Terms and any additional terms and conditions provided to you by the Company. If you do not agree to these Terms, you may not use the App.'),
            const SizedBox(height: 10.0,),
            const Text('2. Registration',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '(a) Registered User: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE0000000),
                    ),
                  ),
                  TextSpan(
                    text:
                    'Registered users include employees or channel partners of Property Master who have been authorized to access the App. By registering, you agree to provide accurate and complete information and to keep your login credentials confidential.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xE0000000),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '(b) Free User: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE0000000),
                    ),
                  ),
                  TextSpan(
                    text:
                    'Free users are customers searching for properties using the App. By using the App as a free user, you agree to provide accurate information and to comply with these Terms.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xE0000000),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0,),
            const Text('3. Data Collection and Use',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '(a) Personal Information: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE0000000),
                    ),
                  ),
                  TextSpan(
                    text:
                    'The App may collect personal information from users, including but not limited to name, contact information, and preferences. By using the App, you consent to the collection and use of your personal information as described in our Privacy Policy.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xE0000000),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '(b) Internal Use: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE0000000),
                    ),
                  ),
                  TextSpan(
                    text:
                    "The Company may use the information collected from users for internal purposes, including but not limited to improving the App's functionality, providing personalized services, and marketing purposes.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xE0000000),
                    ),
                  ),
                ],
              ),
            ),
            const Text('4. User Content',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '(a) Content Submission: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE0000000),
                    ),
                  ),
                  TextSpan(
                    text:
                    'Users may submit content, including but not limited to property listings, reviews, and comments. By submitting content, you grant the Company a non-exclusive, royalty-free, perpetual, irrevocable, and fully sublicensable right to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xE0000000),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '(b) Responsibility for Content: ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE0000000),
                    ),
                  ),
                  TextSpan(
                    text:
                    "Users are solely responsible for the content they submit to the App. The Company does not endorse or guarantee the accuracy, integrity, or quality of any user-generated content.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xE0000000),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0,),
            const Text('5. Intellectual Property',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            const Text('The App and its content, including but not limited to text, graphics, logos, images, audio clips, and software, are the property of the Company or its licensors and are protected by copyright, trademark, and other intellectual property laws.'),
            const SizedBox(height: 10.0,),
            const Text('6. Termination',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            const Text('The Company reserves the right to terminate or suspend your access to the App at any time, without prior notice or liability, for any reason whatsoever, including without limitation if you breach these Terms.'),
            const SizedBox(height: 10.0,),
            const Text('7. Amendments',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            const Text('The Company reserves the right to modify or replace these Terms at any time. Your continued use of the App after any such changes constitutes your acceptance of the new Terms.'),
            const SizedBox(height: 10.0,),
            const Text('8. Governing Law',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            const Text('These Terms shall be governed by and construed in accordance with the laws of [Indore Jurisdiction], without regard to its conflict of law provisions.'),
            const SizedBox(height: 10.0,),
            const Text('9. Contact Us',style: TextStyle(fontSize: 18.0,),),
            const SizedBox(height: 10.0,),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'If you have any questions about these Terms, please contact us at ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE0000000),
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () => _sendMail('support@propertymaster.co.in'),
                    text: "support@propertymaster.co.in",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xE0000000),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0,),
            const Text('By clicking "Agree" or by accessing or using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms.'),
            const SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
  _sendMail(String eml) async {
    // Android and iOS
    if (await canLaunch(eml)) {
      await launch(eml);
    } else {
      throw 'Could not launch $eml';
    }
  }
}