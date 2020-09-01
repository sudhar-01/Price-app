import 'package:flutter/material.dart';
import 'package:priceapp/ui/home.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data:(brightness) => new ThemeData(
        brightness: brightness,
      ),
      themedWidgetBuilder: (context,theme){
        return new MaterialApp(
          debugShowCheckedModeBanner:false,
          theme: theme,
          home: HomePage(),
        );
      }
    );
  }

}

