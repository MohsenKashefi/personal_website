import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personalwebsite/models/carousel_item_model.dart';
import 'package:personalwebsite/utils/constants.dart';

List<CarouselItemModel> carouselItems = List.generate(
  5,
  (index) => CarouselItemModel(
    text: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "MOBILE DEVELOPER",
            style: GoogleFonts.oswald(
              color: kPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 18.0,
          ),
          Text(
            "Mohsen   Kashefi",
            style: GoogleFonts.oswald(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              height: 1.3,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Full-stack developer, Based in Tehran",
            style: TextStyle(
              color: kCaptionColor,
              fontSize: 15.0,
              height: 1.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Container(
          //   child: Wrap(
          //     children: [
          //       Text(
          //         "Need a full custom app?",
          //         style: TextStyle(
          //           color: kCaptionColor,
          //           fontSize: 15.0,
          //           height: 1.5,
          //         ),
          //       ),
                // GestureDetector(
                //   onTap: () {},
                //   child: MouseRegion(
                //     cursor: SystemMouseCursors.click,
                //     child: Text(
                //       " Got a project? Let's talk.",
                //       style: TextStyle(
                //         height: 1.5,
                //         color: Colors.white,
                //         fontSize: 15.0,
                //       ),
                //     ),
                //   ),
                // )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 25.0,
          ),
          // MouseRegion(
          //   cursor: SystemMouseCursors.click,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: kPrimaryColor,
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //     height: 48.0,
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 28.0,
          //     ),
          //     child: TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         "GET STARTED",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 13.0,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    ),
    image: Container(
   
      child: ClipRRect(
           borderRadius: BorderRadius.circular(20.0),

        child: Image.asset(
          
          "assets/person.png",
         
          fit: BoxFit.contain,
        ),
      ),
    ),
  ),
);
