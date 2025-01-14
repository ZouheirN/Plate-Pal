import 'package:flutter_dotenv/flutter_dotenv.dart';

const String recipesAPIBaseURL = 'https://api.spoonacular.com';
String apiKey = "${dotenv.env['API_KEY']}";