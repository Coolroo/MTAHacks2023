import 'package:flutter/material.dart';
import 'response_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeGPT',
      theme: ThemeData(
//          Green: #388087
//          Off white: #F6F6F2
//          Darker off white: #DDDDDA
        // primarySwatch: Colors.blueGrey,
        primaryColor: const Color(0xFF388087),
        scaffoldBackgroundColor: const Color(0xFFF6F6F2),
        appBarTheme: const AppBarTheme(
          foregroundColor: Color(0xFFF6F6F2),
          backgroundColor: Color(0xFF388087),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Color(0xFFF6F6F2),
          backgroundColor: Color(0xFF388087),
        ),
      ),
      // home: const MyHomePage(title: 'Let\'s Get Cooking!'),
      home: const ResponsePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController searchController = TextEditingController();

  void _generateRecipe() {
    // some send to backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
          child: Image(image: AssetImage('assets/logo.png')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  labelText: "ex. Garlic Powder",
                  fillColor: Colors.white
                ),
              ),
              const SizedBox(height: 15.0),
              const Text(
                "Type an ingredient then press enter.",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Press ",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.arrow_forward_outlined, size: 20, color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(
                      text: " to generate your recipe.",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ]
                ),
              ),
              const Text(
                "*Taste satisfaction not guaranteed*",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRecipe,
        tooltip: 'Generate',
        child: const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }
}
