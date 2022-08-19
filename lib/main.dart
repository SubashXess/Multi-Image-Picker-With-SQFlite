import 'package:flutter/material.dart';
import 'package:multi_image_picker_v1/Pages/homepage.dart';
import 'package:multi_image_picker_v1/Provider/imageprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhotoProvider())
      ],
      child: MaterialApp(
        title: 'Multi Image Picker V1',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const HomePage(),
      ),
    );
  }
}
