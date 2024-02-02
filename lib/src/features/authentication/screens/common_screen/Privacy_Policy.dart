import 'package:flutter/material.dart';

class Privacy_Policy extends StatelessWidget {
  const Privacy_Policy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy for Tailoring Mobile App'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Privacy Policy",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  "This Privacy Policy outlines how our Tailoring Mobile App collects, uses, and protects the personal information of its users. We are committed to ensuring the privacy and security of your personal information while providing you with a personalized and tailored experience. By using our mobile app, you agree to the terms and practices described in this Privacy Policy."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Information Collection and Use : Personal Information: We may collect personal information such as your name, email address, contact details, and measurements. This information is collected when you create an account, place an order, or provide it voluntarily for a personalized experience.Usage Data: We may collect non-personal information about how you interact with our app, such as device information, IP address, and usage patterns. This data helps us improve our services and provide a better user experience."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Data Storage and Security : We take appropriate measures to securely store your personal information and protect it from unauthorized access, disclosure, alteration, or destruction.We use industry-standard security practices and technologies to safeguard your data. However, please note that no method of transmission or storage is 100% secure, and we cannot guarantee absolute security."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Information Usage : We use the collected information to provide and personalize our services, process orders, communicate with you, improve our app, and ensure a seamless user experience.We may use your email address to send you promotional and marketing communications if you have subscribed to such services. You can opt-out of these communications at any time.We may anonymize and aggregate non-personal information for statistical analysis, research, and marketing purposes."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Information Sharing : We do not sell, trade, or rent your personal information to third parties without your consent, except as required by law or when necessary to provide our services.We may share your information with trusted third-party service providers and partners who assist us in delivering our services, such as payment processors, shipping providers, and analytics tools. These parties are obligated to protect your information and use it solely for the purposes agreed upon.In the event of a merger, acquisition, or sale of our company, your information may be transferred to the new owners, subject to the same privacy commitments."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Third-Party Links : Our app may contain links to third-party websites or services. We are not responsible for the privacy practices or content of these external sites. We encourage you to review their respective privacy policies."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Children's Privacy : Our app is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children. If you are a parent or guardian and believe your child has provided us with personal information, please contact us, and we will take appropriate steps to remove the information."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Changes to the Privacy Policy : We reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective upon posting the revised policy on our app. We encourage you to review this Privacy Policy periodically for any updates."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "Contact Us : If you have any questions, concerns, or requests regarding this Privacy Policy or the handling of your personal information, please contact us through the contact information provided in the app."),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  "By using our Tailoring Mobile App, you acknowledge that you have read and understood this Privacy Policy and agree to the collection, use, and disclosure of your personal information as described herein."),
            ],
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
