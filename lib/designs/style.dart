
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

Color? iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current!.accentColor;
    } else {
      return null;
    }
  }

  TextStyle bodyFont(BuildContext context) {
   
      return GoogleFonts.nunito(
        color: textColor(context),
         fontSize: 16,
        //  fontStyle: FontStyle.italic
      );

  }


  

    TextStyle rodyFont(BuildContext context) {
   
      return GoogleFonts.nunito(
        color: rextColor(context),
         fontSize: 16,
        //  fontStyle: FontStyle.italic
      );

    }
    TextStyle particularsFont(BuildContext context) {
   
      return GoogleFonts.nunito(
        color: textColor(context),
         fontSize: 16,
         fontStyle: FontStyle.italic,
         fontWeight: FontWeight.w400
      );

      
    
    
  }


    TextStyle titleFont(BuildContext context) {
   
      return GoogleFonts.cinzel(
        color: textColor(context),
        fontSize: 50,
        fontWeight: FontWeight.w500
      );
    
    
  }

    TextStyle addtitleFont(BuildContext context) {
   
      return GoogleFonts.cinzel(
        color: textColor(context),
        fontSize: 26,
        fontWeight: FontWeight.w500
      );
    
    
  }


    TextStyle subtitleFont(BuildContext context) {
   
      return GoogleFonts.cinzel(
        color: textColor(context),
        fontSize: 16,
        fontWeight: FontWeight.bold
      );
    
    
  }

  Color textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Color.fromARGB(255, 253, 253, 253);
    } else {
      return Color.fromARGB(255, 0, 0, 0);
    }
  }

  
  Color rextColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Color.fromARGB(255, 0, 0, 0);
    } else {
      return 
              Color.fromARGB(255, 253, 253, 253);
    }
  }