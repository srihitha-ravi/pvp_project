import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvp_project/models/person.dart';
import 'package:pvp_project/models/attractiveness_logic.dart';

class AttractivenessCalculator extends StatefulWidget {
  @override
  _AttractivenessCalculatorState createState() =>
      _AttractivenessCalculatorState();
}

class _AttractivenessCalculatorState extends State<AttractivenessCalculator> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController muscleMassController;
  late TextEditingController hairColorController;
  late TextEditingController eyeColorController;
  late TextEditingController facialHairController;

  List<String> yesNoOptions = ['Yes', 'No'];
  String initialYesNoValue = 'Yes';

  List<String> hairColorOptions = ['Blonde', 'Brown', 'Black', 'Colored'];
  List<String> eyeColorOptions = ['Green', 'Blue', 'Black', 'Brown'];
  String initialHairColorValue = 'Brown';
  String initialEyeColorValue = 'Black';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    heightController = TextEditingController();
    muscleMassController = TextEditingController();
    hairColorController = TextEditingController();
    eyeColorController = TextEditingController();
    facialHairController = TextEditingController();

    facialHairController.text = initialYesNoValue;
    hairColorController.text = initialHairColorValue;
    eyeColorController.text = initialEyeColorValue;
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    muscleMassController.dispose();
    hairColorController.dispose();
    eyeColorController.dispose();
    facialHairController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attractiveness Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name'
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Age'
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: heightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Height'
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: muscleMassController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Muscle Mass (%)'
                  ),
              ),
            ),
            
            buildDropdown('Hair Color', hairColorController, hairColorOptions),
            buildDropdown('Eye Color', eyeColorController, eyeColorOptions),
            buildYesNoDropdown('Facial Hair', facialHairController),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Person person = Person(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      height: double.parse(heightController.text),
                      muscleMass: double.parse(muscleMassController.text),
                      hairColor: hairColorController.text.toLowerCase(),
                      eyeColor: eyeColorController.text.toLowerCase(),
                      facialHair:
                          facialHairController.text.toLowerCase() == 'yes',
                    );

                    int score = attractivenessScore(person);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Attractiveness Score'),
                          content: Text(
                              style: GoogleFonts.aleo(),
                              '${person.name} is on scale $score out of 10 attractive!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Calculate'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> buildYesNoDropdown(
      String labelText, TextEditingController controller) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText),
      value: controller.text,
      items: yesNoOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          controller.text = newValue!;
        });
      },
    );
  }

  DropdownButtonFormField<String> buildDropdown(String labelText,
      TextEditingController controller, List<String> options) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: labelText),
      value: controller.text.isEmpty
          ? options[0]
          : controller.text, // Set the initial value here
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          controller.text = newValue!;
        });
      },
    );
  }
}
