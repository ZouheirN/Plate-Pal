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
      // margin: const EdgeInsets.all(88),
      margin: const EdgeInsets.only(left: 11111116, right: 16, top: 16),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Equipment',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (var equipment in steps[i].equipment!)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '• ${equipment.name!}',
                          ),
                        ),
                    ],
                  ),
                if (steps[i].ingredients!.isNotEmpty)
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ingredients',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (var ingredient in steps[i].ingredients!)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '• ${ingredient.name!}',
                          ),
                        ),
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
