import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'story_model.dart';

class StoryViewer extends StatefulWidget {
  const StoryViewer({
    super.key,
    required this.storyModel,
    required this.gemini,
    required this.firstRequest,
  });

  final StoryModel storyModel;
  final String firstRequest;
  final Gemini gemini;

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  final TextEditingController _messagesController = TextEditingController();
  final List<String> _requests = [];
  final List<String?> _messages = [];
  final List<String> _chat = [];

  @override
  void initState() {
    super.initState();
    _messages.add(widget.storyModel.body);
    _messages.add(null);
    _requests.add(widget.firstRequest);
    _chat.add(widget.firstRequest);
    _chat.add(widget.storyModel.body);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Action when the heart button is pressed
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.storyModel.title,
                  style: TextStyle(
                    fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkPrimary,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                ...(_messages.map(
                  (e) {
                    if (e == null) {
                      return const Divider(height: 50);
                    }
                    return Text(
                      e,
                      style: TextStyle(
                        fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                        fontSize: 14,
                      ),
                    );
                  },
                ).toList()),
                const Text(
                  'هل تريد أسئلة على هذه الحكاية؟',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Action for Yes button
                      },
                      child: const Text('نعم'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Action for No button
                      },
                      child: const Text('لا'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messagesController,
                    style: TextStyle(
                      fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    _requests.add('''
                    سأسألك سؤال عن هذه القصة
                    ${_messagesController.text}
                    ''');
                    _chat.add('''
                    سأسألك سؤال عن هذه القصة
                    ${_messagesController.text}
                    ''');
                    int i = -1;
                    widget.gemini
                        .chat(
                      _chat.map(
                        (e) {
                          i++;
                          return Content(
                              parts: [Parts(text: e)],
                              role: i % 2 == 0 ? 'user' : 'model');
                        },
                      ).toList(),
                    )
                        .then(
                      (value) {
                        Navigator.pop(context);
                        if (value?.output == null) {
                          _requests.removeLast();
                          _chat.removeLast();
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              contentPadding: EdgeInsets.all(50),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  SizedBox(height: 20),
                                  Text('Error Has Happened Try Again.'),
                                ],
                              ),
                            ),
                          );
                        } else {
                          setState(
                            () {
                              _messagesController.clear();
                              _messages.add(value!.output!);
                              _messages.add(null);
                              _chat.add(value.output!);
                            },
                          );
                        }
                      },
                    );
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  icon: const FittedBox(
                    child: Icon(
                      Icons.send_rounded,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
