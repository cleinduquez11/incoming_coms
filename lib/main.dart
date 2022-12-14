// ignore_for_file: prefer_const_constructors

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neomorph/designs/style.dart';
import 'package:neomorph/from.dart';
import 'package:neomorph/home.dart';


  final currentYear = DateTime.now().year;
void main() async {
  //  dotenv.load(fileName: "server.env");
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Incoming Communications',
      themeMode: ThemeMode.light,
      // ignore: prefer_const_constructors
      theme: NeumorphicThemeData(
        
        textTheme: TextTheme(
          // bodyLarge:  GoogleFonts.openSans(),
        ),
        baseColor: Color(0xFFd4f1f9),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF121212),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      home: MyHomePage(),
      routes: {
        'home':(context) => Home(),
        'from':(context) => From(from: "08/17/2022", until: "08/18/2022")
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // floatingActionButton: NeumorphicFloatingActionButton(
      //   child: Icon(Icons.add, size: 30),
      //   onPressed: () {},
      // ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: 'incoming',
              child: Neumorphic(
                style: NeumorphicStyle(
                  
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Incoming Communications",
                  style: titleFont(context)
                ),
              ),
            ),
            // NeumorphicButton(
            //   onPressed: () {
            //     print("onClick");
            //   },
            //   style: NeumorphicStyle(
            //     shape: NeumorphicShape.flat,
            //     boxShape: NeumorphicBoxShape.circle(),
            //   ),
            //   padding: const EdgeInsets.all(12.0),
            //   child: Icon(
            //     Icons.favorite_border,
            //     color: _iconsColor(context),
            //   ),
            // ),
           SizedBox( height: 200,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              NeumorphicButton(
                  margin: EdgeInsets.only(top: 12),
                  onPressed: () {
                    // NeumorphicTheme.of(context)!.themeMode =
                    //     NeumorphicTheme.isUsingDark(context)
                    //         ? ThemeMode.light
                    //         : ThemeMode.dark;
                    Navigator.pushNamed(context, 'home');
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Proceed ->",
                    style: bodyFont(context),
                  )),
              
              // SizedBox(
              //   width: 30,
              // ),
              
              // NeumorphicButton(
              //     margin: EdgeInsets.only(top: 12),
              //     onPressed: () {
              //       // Navigator.of(context)
              //       //     .pushReplacement(MaterialPageRoute(builder: (context) {
              //       //   return;
              //       //  // FullSampleHomePage();
              //       // }));
              //     },
              //     style: NeumorphicStyle(
              //       shape: NeumorphicShape.flat,
              //       boxShape: NeumorphicBoxShape.roundRect(
              //           BorderRadius.circular(8)),
              //       //border: NeumorphicBorder()
              //     ),
              //     padding: const EdgeInsets.all(12.0),
              //     child: Text(
              //       "Admin",
              //       style: TextStyle(color: _textColor(context)),
              //     )),
            ]),
            ],
        ),
      ),
    );
  }

}
