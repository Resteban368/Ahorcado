


// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget HiddenLetter (String char, bool visble){
  return Padding(
    padding: const EdgeInsets.only(left: 3),
    child: Container(
      alignment: Alignment.center,
      width: 32,
      height: 40,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(10),
        color: Colors.white,
  
      ),
      child: Visibility(
        visible: !visble,
        child: Text(
          char,
          style: GoogleFonts.outfit(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            
          ),
          textAlign: TextAlign.center,
        
        )
  
      ),
    ),
  );

}