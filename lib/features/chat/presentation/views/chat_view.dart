import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legy/core/extension/gap_extension.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/chat/service/gemini_service.dart';
import 'package:legy/features/profile/profile_settings/sections/appbar/profile_settings_appbar.dart'; // update path if needed

class ChatView extends StatefulWidget {
  static const routePath = 'chat';

  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    FocusScope.of(context).unfocus();

    setState(() {
      _messages.add({"role": "user", "text": text});
      _controller.clear();
      _isLoading = true;
    });

    try {
      final response = await GeminiChatService.ask(text);
      setState(() {
        _messages.add({"role": "assistant", "text": response});
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "assistant",
          "text": "Erreur: ${e.toString()}",
        });
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _messageBubble(String text, bool isUser) {
    final backgroundColor = isUser
        ? Colours.lightThemeOrange5
        : Colours.lightThemeBlack1.withOpacity(0.6);
    final textColor = Colors.white;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 18),
          ),
        ),
        child: Text(
          text,
          style: TextStyles.textMedium.copyWith(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.lightThemeWhite1,
      body: SafeArea(
        child: Column(
          children: [
            context.adaptiveGap,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 16),
              child: const ProfileSettingsAppbar(title: 'Assistant'),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['role'] == 'user';
                  return _messageBubble(message['text'] ?? '', isUser);
                },
              ),
            ),
            if (_isLoading) ...[
              const Gap(10),
              const CircularProgressIndicator(color: Colours.lightThemeOrange5),
              const Gap(10),
            ],
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colours.lightThemeBlack1.withOpacity(0.2),
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Posez une question...",
                          hintStyle: TextStyle(color: Colours.lightThemeBlack1),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const Gap(12),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colours.lightThemeOrange5,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
