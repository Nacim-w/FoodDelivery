import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal_data_loader.dart';

class GeminiChatService {
  static const _apiKey = 'AIzaSyBm6PiXFSRPTCJMRGbCtk8lvF7fE1GusqM';
  static const _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey';

  static Future<String> ask(String userMessage) async {
    String mealDataPrompt;
    try {
      mealDataPrompt =
          await MealDataLoader.loadMealDataPrompt(filter: userMessage);
    } catch (e) {
      mealDataPrompt = "Menu data could not be loaded: ${e.toString()}";
    }

    // Limit prompt to avoid 503
    if (mealDataPrompt.length > 5000) {
      mealDataPrompt = mealDataPrompt.substring(0, 5000);
    }

    final prompt = """
You are a friendly food assistant. Here is the menu data:

$mealDataPrompt

User question: $userMessage

Respond naturally and clearly. Only plain text.
""";

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 503) {
        return "Service temporairement indisponible. Veuillez réessayer.";
      }

      if (response.statusCode != 200) {
        return "Erreur: code ${response.statusCode}";
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      final candidates = data['candidates'] as List<dynamic>?;

      if (candidates == null || candidates.isEmpty) {
        return "Réponse vide de Gemini";
      }

      final firstText = candidates.first['content']?['parts']?[0]?['text'];
      if (firstText == null) return "Texte Gemini manquant";

      return firstText.toString().trim().isEmpty
          ? "Réponse vide"
          : firstText.toString().trim();
    } catch (e) {
      return "Erreur Gemini: ${e.toString()}";
    }
  }
}
