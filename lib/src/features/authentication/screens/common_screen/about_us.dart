import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class about_us extends StatefulWidget {
  const about_us({super.key});

  @override
  State<about_us> createState() => _about_usState();
}

class _about_usState extends State<about_us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(" Developed by Engineer Amin Hamedi Welcome to our mobile app, proudly developed by Engineer Amin Hamedi! Amin is a highly skilled and experienced engineer with a passion for creating innovative and user-friendly mobile applications.With a strong background in software engineering, Amin has dedicated his career to developing cutting-edge solutions that meet the needs and expectations of modern mobile app users. His expertise spans across various platforms and technologies, allowing him to deliver high-quality and robust applications.Amin's commitment to excellence is evident in every project he undertakes. He approaches app development with meticulous attention to detail, ensuring that every line of code is optimized for performance and functionality. His deep understanding of software architecture and best practices enables him to create stable and scalable applications that can evolve with your business needs.Beyond technical expertise, Amin is a creative thinker who strives to deliver exceptional user experiences. He believes that a great app goes beyond functionality and should engage and delight users. With a keen eye for design and a focus on intuitive interfaces, Amin crafts mobile applications that are both visually appealing and easy to navigate.Throughout his career, Amin has successfully collaborated with clients from various industries, ranging from startups to established enterprises. He values open communication and works closely with his clients to understand their unique requirements and goals. By building strong partnerships, Amin ensures that the final product aligns with the client's vision and exceeds their expectations.Amin's dedication to staying ahead of the curve in mobile app development is evident through his continuous learning and exploration of new technologies. He keeps up with the latest industry trends and incorporates innovative features and functionalities into his projects. By leveraging his expertise and staying up-to-date with advancements, Amin creates apps that provide a competitive edge in the market.When you choose an app developed by Engineer Amin Hamedi, you can expect an exceptional product that combines technical excellence, user-centric design, and seamless functionality. Whether you need a business app, a utility app, or a game, Amin has the skills and expertise to bring your vision to life.Contact Engineer Amin Hamedi today to discuss your mobile app project and embark on a journey of innovation and success. Together, you can create a mobile app that will captivate your audience and drive your business forward in the digital landscape.",textAlign: TextAlign.start, style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black
                ),)),
              Text("",textAlign: TextAlign.start,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold ,color: Colors.black54,)),


            ],
          ),
        ),
      ),
    );
  }
}
