import 'package:pvp_project/models/person.dart';

int attractivenessScore(Person person) {
  int score = 0;

  if (person.age >= 21 && person.age <= 35) {
    score++;
  }

  if (person.height >= 177) {
    score++;
  }

  if (person.muscleMass >= 75.0 && person.muscleMass <= 90.0) {
    score++;
  }

  if (person.hairColor == 'black' || person.hairColor == 'brown') {
    score = score+3;
  } else if (person.hairColor == 'blonde') {
    score = score+2;
  } else {
    score++;
  }

  if (person.eyeColor == 'green') {
    score = score+3;
  } else if (person.eyeColor == 'blue') {
    score = score+2;
  } else {
    score++;
  }

  if (person.facialHair) {
    score++;
  }

  return score;
}
