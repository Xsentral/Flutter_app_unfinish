import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File? imageFile;

  //test

  //end test

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturing Image'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageFile != null)
              Container(
                width: 640,
                height: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: FileImage(imageFile!)
                  ),
                  border: Border.all(width: 8, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              if (imageFile == null)
                  Container(
                    width: 640,
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(width: 8, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text('Image Should Appear Here', style: TextStyle(fontSize: 26),),
                  ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: ()=> getImage(source: ImageSource.camera),
                        child: const Text('Capture Image', style: TextStyle(fontSize: 18))
                    ),
                  ),
                  const SizedBox(width: 20,),
                  if (imageFile == null)
                  Expanded(
                    child: ElevatedButton(
                        onPressed: ()=> getImage(source: ImageSource.gallery),
                        child: const Text('selected Image', style: TextStyle(fontSize: 18))
                    ),
                  ),
                  if(imageFile != null)
                  Expanded(
                    child: ElevatedButton(
                        onPressed: ()=> getImage(source: ImageSource.gallery),
                        child: const Text('selected New Image', style: TextStyle(fontSize: 15))
                    ),
                  ),
                ],
              ),
                  const SizedBox(width: 40,),
                  if (imageFile != null)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                    builder: (context)=> const Page2()
                                )
                            );
                          },
                          child: const Text('Submit', style: TextStyle(fontSize: 24))
                        ),
                      )
                    ],
                  ),
            ],
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {

    final file = await ImagePicker().pickImage(source: source);

    if(file?.path != null){
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}







class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Center(child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(
              MaterialPageRoute(
                  builder: (context)=> const Home()
              )
          );
        },
        child: const Text('Back to select picture'),
      )),
    );
  }
}