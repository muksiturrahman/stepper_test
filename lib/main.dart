import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStepperDemo(),
    );
  }
}

class MyStepperDemo extends StatefulWidget {
  @override
  _MyStepperDemoState createState() => _MyStepperDemoState();
}

class _MyStepperDemoState extends State<MyStepperDemo> {
  int _currentStep = 0;
  List<bool> _stepCompleted = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper Demo'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () {
          setState(() {
            if (_currentStep < 4) {
              _currentStep++;
              _stepCompleted[_currentStep - 1] = true;
            } else if (_currentStep == 4) {
              // Handle completion of the last step (Step 4)
              _stepCompleted[_currentStep] = true;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep--;
            }
          });
        },
        steps: [
          _buildStep(0),
          _buildStep(1),
          _buildStep(2),
          _buildStep(3),
          _buildStep(4),
        ],
      ),
    );
  }

  Step _buildStep(int stepNumber) {
    final isCompleted = _stepCompleted[stepNumber];
    return Step(
      title: Text('Step ${stepNumber + 1}'),
      content: Text('This is the content of Step ${stepNumber + 1}'),
      isActive: _currentStep >= stepNumber,
      state: isCompleted ? StepState.complete : StepState.indexed,
      subtitle: !isCompleted ? Text('Incomplete') : null,
    );
  }
}
