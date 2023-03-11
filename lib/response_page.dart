import 'package:flutter/material.dart';
import 'package:recipe_gen/recipe.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({ Key? key, required this.recipe }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.getName()),
        actions: const [
          SizedBox(
            width: 50,
            child: Image(image: AssetImage('assets/logo.png')),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Ingredient(ingredients: recipe.getIngredients()),
          Instruction(steps: recipe.getSteps()),
        ],
      ),
    );
  }
}

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key, required this.ingredients}) : super(key: key);

  final List<Map<String, String>> ingredients;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: ingredients.length,
        itemBuilder: (BuildContext bc, int i) {
          print(ingredients[i].entries);
          return Row(
            children: <Widget>[
              Expanded(
                child: Text(ingredients[i][0].toString(), textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text(ingredients[i][1].toString(), textAlign: TextAlign.center),
              ),
            ],
          );
        }
      )
    );
  }
}

class Instruction extends StatefulWidget {
  const Instruction({ Key? key, required this.steps}) : super(key: key);

  final List<String> steps;

  @override
  State<Instruction> createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index < widget.steps.length-1) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      // Add Step for each step
      steps: widget.steps.map((e) => Step(
        title: Text("Step ${widget.steps.indexOf(e)+1}"),
        content: Container(
            alignment: Alignment.centerLeft,
            child: Text(e)
          ),
      )).toList(),
    );
  }
}