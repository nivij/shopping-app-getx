import 'package:flutter/material.dart';

ThemeData Lightmode =ThemeData(

  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade100,
    primary: Colors.black,
    secondary: Colors.grey.shade100,
    primaryContainer: Colors.grey.shade100,
    outline: Colors.grey.shade900,
    secondaryContainer: Colors.grey.shade900,
    onBackground: Colors.grey.shade900,
  onPrimary: Colors.grey.shade100,
      onPrimaryContainer: Colors.grey.shade800,
      inversePrimary: Colors.black,
  )
);

ThemeData Darkmode =ThemeData(

  brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.grey.shade100,
      secondary: Colors.grey.shade900,
        primaryContainer: Colors.grey.shade800,
        outline: Colors.grey.shade100,
      secondaryContainer: Colors.grey.shade100,
      onBackground: Colors.grey.shade800,
     onPrimary: Colors.black12,
      onPrimaryContainer: Colors.grey.shade300,
      inversePrimary: Colors.yellow
    )
);

