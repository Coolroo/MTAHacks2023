import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:recipe_gen/response_page.dart';
import 'package:recipe_gen/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe GPT',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF388087),
          secondary: Color(0xFFDDDDDA),
          tertiary: Color(0xFFC6C6C2),
          surface: Color(0xFFF6F6F2),
          background: Color(0xFFDDDDDA),
          error: Colors.deepOrange,
          onPrimary: Color(0xFFF6F6F2),
          onSecondary: Colors.black,
          onTertiary: Colors.black,
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
        listTileTheme: const ListTileThemeData(
          tileColor: Color(0xFFDDDDDA),
          iconColor: Color(0xFF388087),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          style: ListTileStyle.list,
        ),
        cardTheme: const CardTheme(
          color: Color(0xFFDDDDDA,),
          shadowColor: Color(0x00000000)
        )
      ),
      home: const MyHomePage(title: 'Let\'s Get Cooking!'),
      // home: const ResponsePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  bool isLoading = false;

  TextEditingController searchController = TextEditingController();

  bool isVegetarian = false;
  bool isVegan = false;
  bool isGlutenFree = false;
  bool isDairyFree = false;

  List<String> ingredients = [];

  void _generateRecipe() async {
    if (ingredients.isEmpty) return;

    isLoading = true;

    List<String> restrictions = [];
    if (isVegetarian) restrictions.add("vegetarian");
    if (isVegan) restrictions.add("vegan");
    if (isGlutenFree) restrictions.add("gluten free");
    if (isDairyFree) restrictions.add("dairy free");

    List<String> excludes = [];
 
    final response = await http.post(
      Uri.parse('https://plagueinc.coolroo.ca/recipe/getRecipe'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        "ingredients": ingredients,
        "dietaryRestrictions": restrictions,
        "excludedIngredients": excludes
      })
    );
    var data = json.decode(response.body);
    isLoading = false;
    if (response.statusCode == 200 && data != null) {
      // go to the result page and pass the data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponsePage(recipe: Recipe(data))
        )
      );
    }
  }

  late AnimationController loadController;

  @override
  void initState() {
    loadController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
    });
    loadController.repeat(reverse: true);
    super.initState();
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
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
            child: Image(image: AssetImage('assets/logo.png')),
          ),
        ],
      ),
      body: (isLoading ?
        Center(child: CircularProgressIndicator(
          value: loadController.value,
        )) :
        GestureDetector(
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
                        onSubmitted:(value) => setState(() {
                          ingredients.add(value);
                          searchController.text = "";
                        }),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          iconColor: Theme.of(context).colorScheme.primary,
                          prefixIcon: const Icon(Icons.search),
                          labelText: "ex. Garlic Powder",
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
                                activeColor: Theme.of(context).colorScheme.primary,
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
                                activeColor: Theme.of(context).colorScheme.primary,
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
                                activeColor: Theme.of(context).colorScheme.primary,
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
                                activeColor: Theme.of(context).colorScheme.primary,
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
                child: Material(
                  color: Theme.of(context).colorScheme.tertiary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: ingredients.isNotEmpty ? ingredients.length: 1,
                      itemBuilder: (BuildContext bc, int i) {
                        return ingredients.isNotEmpty ? Column(
                          children: [
                            ListTile(
                              title: Text(ingredients[i]),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () { setState(() {
                                  ingredients.removeAt(i);
                                }); },
                              ),
                            ),
                            const SizedBox(height: 5.0),
                          ]
                        ) : 
                        Column(
                          children: const[
                            SizedBox(height: 15.0),
                            Center(
                              child: Text("Add the first ingredient!", style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
              ),
            ]
          ),
        )),
      floatingActionButton: (isLoading ? null :
      FloatingActionButton(
        onPressed: _generateRecipe,
        tooltip: 'Generate',
        child: const Icon(Icons.arrow_forward_outlined),
      )),
    );
  }
}
