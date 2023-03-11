import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipe"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: const [
            Text("Instructions go here."),
          ]
        )
      ),
    );
  }
}