import 'package:flutter/material.dart';
import 'package:platepal/features/recipe/models/recipe_instructions_model.dart';

class InstructionsWidget extends StatefulWidget {
  final List<RecipeInstructionsModel> recipeInstructionsModel;

  const InstructionsWidget({super.key, required this.recipeInstructionsModel});

  @override
  State<InstructionsWidget> createState() => _InstructionsWidgetState();
}

class _InstructionsWidgetState extends State<InstructionsWidget> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final steps = widget.recipeInstructionsModel.first.steps!;

    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      steps: [
        for (var i = 0; i < steps.length; i++)
          Step(
            isActive: _currentStep == i,
            title: Text(steps[i].step!),
            content: Column(
              children: [
                if (steps[i].equipment!.isNotEmpty)
                  Column(
                    children: [
                      const Text('Equipment:'),
                      for (var equipment in steps[i].equipment!)
                        Text(equipment.name!),
                    ],
                  ),
                if (steps[i].ingredients!.isNotEmpty)
                  Column(
                    children: [
                      const Text(
                        'Ingredients:',
                        textAlign: TextAlign.left,
                      ),
                      for (var ingredient in steps[i].ingredients!)
                        Text(ingredient.name!),
                    ],
                  ),
                if (steps[i].length != null)
                  Text(
                      'Length: ${steps[i].length!.number} ${steps[i].length!.unit}'),
              ],
            ),
          ),
      ],
      onStepTapped: (step) {
        setState(() {
          _currentStep = step;
        });
      },
      onStepContinue: () {
        setState(() {
          if (_currentStep < steps.length - 1) {
            _currentStep += 1;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (_currentStep > 0) {
            _currentStep -= 1;
          }
        });
      },
      currentStep: _currentStep,
    );
  }
}
