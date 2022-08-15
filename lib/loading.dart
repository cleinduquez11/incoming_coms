// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:neomorph/designs/style.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'lf30_editor_tak9z4hd.json',
                  ),
                  Text(
                    "Connecting....",
                    style: TextStyle(
                      color: Colors.black

                    ),
                  )
                ],
              ),

              // Lottie.network('https://assets8.lottiefiles.com/private_files/lf30_fup2uejx.json')
            ),
          );
     
  }
}
