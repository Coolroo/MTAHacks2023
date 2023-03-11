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
        colorScheme: const ColorScheme(
          primary: Color(0xFF388087),
          primaryVariant: Color(0xFF388087),
          secondary: Color(0xFFDDDDDA),
          secondaryVariant: Color(0xFFC6C6C2),
          surface: Color(0xFFF6F6F2),
          background: Color(0xFFDDDDDA),
          error: Colors.deepOrange,
          onPrimary: Color(0xFFF6F6F2),
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light
        ),
        scaffoldBackgroundColor: const Color(0xFFDDDDDA),
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

  bool isVegetarian = false;
  bool isVegan = false;
  bool isGlutenFree = false;
  bool isDairyFree = false;

  List<String> ingredients = [];

  void _generateRecipe() {
    // some send to backend
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    // Text Input with instruction text
                    TextField(
                      controller: searchController,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      onSubmitted:(value) => setState(() {
                        ingredients.add(value);
                        searchController.text = "";
                      }),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        iconColor: Theme.of(context).colorScheme.primary,
                        prefixIcon: const Icon(Icons.search),
                        labelText: "ex. Garlic Powder",
                        fillColor: Colors.amber
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "Type an ingredient then press enter.",
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 18),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Press ",
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.arrow_forward_outlined, size: 20, color: Theme.of(context).colorScheme.primary),
                          ),
                          TextSpan(
                            text: " to generate your recipe.",
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20),
                          ),
                        ]
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "*Taste satisfaction NOT guaranteed*",
                      style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 18),
                    ),

                    const SizedBox(height: 15.0),

                    // Checkbox row
                    Wrap(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: isVegetarian,
                              checkColor: Colors.amber,
                              onChanged: (bool? value) {
                                setState(() {
                                  isVegetarian = value!;
                                });
                              }
                            ), const Text("Vegetarian"),
                          ]
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: isVegan,
                              onChanged: (bool? value) {
                                setState(() {
                                  isVegan = value!;
                                });
                              }
                            ), const Text("Vegan"),
                          ]
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: isGlutenFree,
                              onChanged: (bool? value) {
                                setState(() {
                                  isGlutenFree = value!;
                                });
                              }
                            ), const Text("Gluten-Free"),
                          ]
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: isDairyFree,
                              onChanged: (bool? value) {
                                setState(() {
                                  isDairyFree = value!;
                                });
                              }
                            ), const Text("Dairy-Free"),
                          ],
                        ),
                      ]
                    ),

                    // Entered ingredients list
                    

                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.secondaryVariant,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: ingredients.isNotEmpty ? ingredients.length: 1,
                    itemBuilder: (BuildContext bc, int i) {
                      return ingredients.isNotEmpty ? ListTile(
                        title: Text(ingredients[i]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_forever),
                          onPressed: () { setState(() {
                            ingredients.removeAt(i);
                          }); },
                        ),
                      ) : 
                      const Center(child: Text("Add the first ingredient!", style: TextStyle()),);
                    }
                  ),
                ),
              ),
            ),
          ]
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
