import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({ Key? key }) : super(key: key);

  static const String _title = 'Recipe Title';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        actions: const [
          SizedBox(
            width: 50,
            child: Image(image: AssetImage('assets/logo.png')),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          Ingredient(),
          Instruction(),
        ],
      ),
    );
  }
}

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(
          child: Text('ingredient name', textAlign: TextAlign.center),
        ),
        Expanded(
          child: Text('amount', textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

class Instruction extends StatefulWidget {
  const Instruction({ Key? key }) : super(key: key);

  @override
  State<Instruction> createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  int _index = 0;
  int maxIndex = 3;

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
        if (_index < maxIndex-1) {
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
      steps: <Step>[
        Step(
          title: const Text('Step 1'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        Step(
          title: const Text('Step 2'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 2')),
        ),
        Step(
          title: const Text('Step 3'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 3')),
        ),
      ],
    );
  }
}