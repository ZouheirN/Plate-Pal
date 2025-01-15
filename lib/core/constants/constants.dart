import 'package:flutter_dotenv/flutter_dotenv.dart';

const String recipesAPIBaseURL = 'https://api.spoonacular.com';
String apiKey = "${dotenv.env['API_KEY']}";

List<Map<String, String>> cuisines = [
  {'name': 'African', 'value': 'african'},
  {'name': 'Asian', 'value': 'asian'},
  {'name': 'American', 'value': 'american'},
  {'name': 'British', 'value': 'british'},
  {'name': 'Cajun', 'value': 'cajun'},
  {'name': 'Caribbean', 'value': 'caribbean'},
  {'name': 'Chinese', 'value': 'chinese'},
  {'name': 'Eastern European', 'value': 'eastern european'},
  {'name': 'European', 'value': 'european'},
  {'name': 'French', 'value': 'french'},
  {'name': 'German', 'value': 'german'},
  {'name': 'Greek', 'value': 'greek'},
  {'name': 'Indian', 'value': 'indian'},
  {'name': 'Irish', 'value': 'irish'},
  {'name': 'Italian', 'value': 'italian'},
  {'name': 'Japanese', 'value': 'japanese'},
  {'name': 'Jewish', 'value': 'jewish'},
  {'name': 'Korean', 'value': 'korean'},
  {'name': 'Latin American', 'value': 'latin american'},
  {'name': 'Mediterranean', 'value': 'mediterranean'},
  {'name': 'Mexican', 'value': 'mexican'},
  {'name': 'Middle Eastern', 'value': 'middle eastern'},
  {'name': 'Nordic', 'value': 'nordic'},
  {'name': 'Southern', 'value': 'southern'},
  {'name': 'Spanish', 'value': 'spanish'},
  {'name': 'Thai', 'value': 'thai'},
  {'name': 'Vietnamese', 'value': 'vietnamese'},
];

List<Map<String, String>> diets = [
  {'name': 'Gluten Free', 'value': 'glutenFree'},
  {'name': 'Ketogenic', 'value': 'ketogenic'},
  {'name': 'Vegetarian', 'value': 'vegetarian'},
  {'name': 'Lacto-Vegetarian', 'value': 'lacto-vegetarian'},
  {'name': 'Ovo-Vegetarian', 'value': 'ovo-vegetarian'},
  {'name': 'Vegan', 'value': 'vegan'},
  {'name': 'Pescetarian', 'value': 'pescetarian'},
  {'name': 'Paleo', 'value': 'paleo'},
  {'name': 'Primal', 'value': 'primal'},
  {'name': 'Low FODMAP', 'value': 'low-fodmap'},
  {'name': 'Whole30', 'value': 'whole30'},
];
