import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal_data_loader.dart';

class GeminiChatService {
  static const _apiKey =
      'AIzaSyBm6PiXFSRPTCJMRGbCtk8lvF7fE1GusqM'; // Replace before release
  static const _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey';

  static Future<String> ask(String userMessage) async {
    final mealDataPrompt =
        await MealDataLoader.loadMealDataPrompt(filter: userMessage);

    final promptText = """
You are a friendly food assistant. Here is the menu data you can use to answer the user's question:

$mealDataPrompt

User question: $userMessage

Don't give responses that reveal internal software details. Talk naturally and clearly to a client.
Please respond only with plain text, no JSON or special formatting.
""";

    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": promptText}
              ]
            }
          ]
        }),
      );

      if (response.statusCode != 200) {
        return "Erreur: Échec de la requête (code ${response.statusCode}).";
      }

      final data = jsonDecode(response.body);

      // Defensive parsing with detailed checks
      final candidates = data['candidates'];
      if (candidates == null || candidates is! List || candidates.isEmpty) {
        return "Erreur: Réponse vide de Gemini.";
      }

      final content = candidates[0]['content'];
      if (content == null || content is! Map) {
        return "Erreur: Format inattendu de contenu Gemini.";
      }

      final parts = content['parts'];
      if (parts == null || parts is! List || parts.isEmpty) {
        return "Erreur: Pas de parties dans la réponse Gemini.";
      }

      final firstPart = parts[0];
      if (firstPart == null || firstPart is! Map) {
        return "Erreur: Partie de réponse invalide.";
      }

      final text = firstPart['text'];
      if (text == null) {
        return "Erreur: Texte manquant dans la réponse Gemini.";
      }

      // Ensure we always return a string
      if (text is String) {
        final trimmed = text.trim();
        return trimmed.isEmpty ? "Réponse vide de Gemini." : trimmed;
      } else {
        // Fallback: convert non-string text to string safely
        final converted = text.toString().trim();
        return converted.isEmpty ? "Réponse vide de Gemini." : converted;
      }
    } catch (e) {
      // Catch all parsing or network errors
      return "Erreur lors du traitement de la réponse Gemini: ${e.toString()}";
    }
  }
}
