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
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0),
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

  final List<dynamic> ingredients;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: const Text(
          "Ingredients",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: ingredients.length,
            itemBuilder: (BuildContext bc, int i) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      ingredients[i].entries.first.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ingredients[i].entries.last.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)
                    ),
                  ),
                ],
              );
            }
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

class Instruction extends StatefulWidget {
  const Instruction({ Key? key, required this.steps}) : super(key: key);

  final List<dynamic> steps;

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
      controlsBuilder:(BuildContext context, ControlsDetails details) {
        return Container(
          margin: const EdgeInsets.only(top: 50),
          child: Row(
            children: [
              if(_index < widget.steps.length-1)
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Text("Continue")
                    ),
                  ),
                const SizedBox(width: 12),
                if(_index > 0) 
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: const Text("Back")
                    ),
                  ),
              ],
            ),
          );
        },
      steps: widget.steps.map((e) => Step(
        title: const Text(""),
        content: Container(
            alignment: Alignment.centerLeft,
            child: Text(e)
          ),
      )).toList(),
    );
  }
}