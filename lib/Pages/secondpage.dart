import 'package:flutter/material.dart';
import 'package:multi_image_picker_v1/Pages/thirdpage.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    // height: size.height * 0.18,
                    width: size.height * 0.36,

                    child: Card(
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                                width: 2.0, color: Colors.deepPurple)),
                        child: Image.asset(
                          "assets/default-image.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                    top: -10.0,
                    right: -10.0,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThirdPage()));
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Third Page'),
              ),
            ],
          ),
        ));
  }
}
