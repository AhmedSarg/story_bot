import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_bot/app_assets.dart';
import 'package:story_bot/app_colors.dart';

import 'story_model.dart';
import 'story_viewer.dart';

class StoryCreator extends StatefulWidget {
  const StoryCreator({super.key});

  @override
  State<StoryCreator> createState() => _StoryCreatorState();
}

class _StoryCreatorState extends State<StoryCreator> {
  final List<String> _storyLengths = ["قصير", "متوسط", "طويل"];
  final List<String> _englishStoryLengths = ["short", "medium", "long"];
  final List<String> _creativityLevels = ["سهل", "متوسط", "ابداعي"];
  final List<String> _englishCreativityLevels = ["easy", "medium", "creative"];
  final List<String> _types = [
    "خيال",
    "اجتماعي",
    "شعري",
    "حواري",
    "تعليمي",
    "واقعي",
    "تاريخي",
  ];
  final List<String> _englishTypes = [
    "fiction",
    "social",
    "poetry",
    "conversational",
    "educational",
    "realistic",
    "historical",
  ];
  final List<String> _tempos = [
    "اسلوب واقعي",
    "اسلوب قائم على الشخصيات",
    "اسلوب شعري",
    "اسلوب قصير و بسيط",
    "اسلوب قائم علي الخيال",
  ];
  final List<String> _englishTempos = [
    "realistic style",
    "based on characters style",
    "poetic style",
    "short and simple style",
    "base on fiction style",
  ];

  late String _selectedStoryLength = _storyLengths[1];
  late String _englishSelectedStoryLength = _englishStoryLengths[1];
  double _creativityLevel = 1;
  String? _selectedStoryType;
  String? _englishSelectedStoryType;
  String? _selectedTempo;
  String? _englishSelectedTempo;

  late Gemini _gemini;

  @override
  void initState() {
    super.initState();
    _gemini = Gemini.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.background),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Image.asset(AppAssets.header),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'أنا سارة سوف أنشأ لك قصة رائعة! ساعدني في اختيار نوع الحكايات التي تحبها ودعنا نبدأ في مغامرتنا السحرية!',
                      style: TextStyle(
                        fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: Text(
                            'قصير',
                            style: TextStyle(
                              fontFamily:
                                  GoogleFonts.notoKufiArabic().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkPrimary,
                            ),
                          ),
                          selected: _selectedStoryLength == _storyLengths[0],
                          onSelected: (value) {
                            setState(() {
                              _selectedStoryLength = _storyLengths[0];
                              _englishSelectedStoryLength =
                                  _englishStoryLengths[0];
                            });
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          selectedColor: AppColors.primary,
                          showCheckmark: false,
                          labelStyle: const TextStyle(
                            color: AppColors.darkPrimary,
                          ),
                        ),
                        const Spacer(),
                        ChoiceChip(
                          label: Text(
                            'متوسط',
                            style: TextStyle(
                              fontFamily:
                                  GoogleFonts.notoKufiArabic().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkPrimary,
                            ),
                          ),
                          selected: _selectedStoryLength == _storyLengths[1],
                          onSelected: (value) {
                            setState(() {
                              _selectedStoryLength = _storyLengths[1];
                              _englishSelectedStoryLength =
                                  _englishStoryLengths[1];
                            });
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          selectedColor: AppColors.primary,
                          showCheckmark: false,
                          labelStyle: const TextStyle(
                            color: AppColors.darkPrimary,
                          ),
                        ),
                        const Spacer(),
                        ChoiceChip(
                          label: Text(
                            'طويل',
                            style: TextStyle(
                              fontFamily:
                                  GoogleFonts.notoKufiArabic().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkPrimary,
                            ),
                          ),
                          selected: _selectedStoryLength == _storyLengths[2],
                          onSelected: (value) {
                            setState(() {
                              _selectedStoryLength = _storyLengths[2];
                              _englishSelectedStoryLength =
                                  _englishStoryLengths[2];
                            });
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          selectedColor: AppColors.primary,
                          showCheckmark: false,
                          labelStyle: const TextStyle(
                            color: AppColors.darkPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TitleText(text: 'تحديد الإبداع'),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Slider(
                          value: _creativityLevel,
                          onChanged: (value) {
                            setState(() {
                              _creativityLevel = value;
                            });
                          },
                          min: 0,
                          max: 2,
                          divisions: 2,
                          activeColor: AppColors.primary,
                          inactiveColor: AppColors.primary,
                          thumbColor: AppColors.darkPrimary,
                          label: _creativityLevels[_creativityLevel.toInt()],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _creativityLevels
                              .map(
                                (e) => Text(
                                  e,
                                  style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.notoKufiArabic().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkPrimary,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TitleText(text: 'اختر النوع'),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primary),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(.4),
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      items: _types
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: [Text(e)],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            _selectedStoryType = value;
                            if (value != null) {
                              _englishSelectedStoryType =
                                  _englishTypes[_types.indexOf(value)];
                            } else {
                              _englishSelectedStoryType = null;
                            }
                          },
                        );
                      },
                      style: TextStyle(
                        fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkPrimary,
                      ),
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      hint: Text(
                        _selectedStoryType ?? 'اختر النوع',
                        style: TextStyle(
                          fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TitleText(text: 'اختر الأسلوب'),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primary),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(.4),
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      items: _tempos
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: [
                                    Text(e),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      style: TextStyle(
                        fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkPrimary,
                      ),
                      underline: const SizedBox.shrink(),
                      onChanged: (value) {
                        setState(
                          () {
                            _selectedTempo = value;
                            if (value != null) {
                              _englishSelectedTempo =
                                  _englishTempos[_tempos.indexOf(value)];
                            } else {
                              _englishSelectedTempo = null;
                            }
                          },
                        );
                      },
                      isExpanded: true,
                      hint: Text(
                        _selectedTempo ?? 'اختر الأسلوب',
                        style: TextStyle(
                          fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          /* _gemini.text('''
                              Write a story which its length is $_englishSelectedStoryLength
                              and its creativity level is ${_englishCreativityLevels[_creativityLevel.toInt()]}
                              and its type is $_englishSelectedStoryType
                              and its style is $_englishSelectedTempo.
                              Write the title in the first line.
                              separate the title and the story by a '`' as a special character to split it in code.
                              so it should be exactly title`story.
                              ''')*/
                          String request = '''
                           اكتبلي قصة طولها $_selectedStoryLength
                               و مستوي الأبداع فيها ${_creativityLevels[_creativityLevel.toInt()]}
                              و نوعها يكون  $_selectedStoryType
                              و اسلوبها يكون  $_selectedTempo.
                              اكتب عنوان القصة في اول سطر.
                              separate the title and the story by a '`' as a special character to split it in code.
                              so it should be exactly title`story.
                              الحكاية يجب ان تكون باللغة العربية فقط
                              ''';
                          _gemini.text(request).then(
                            (value) {
                              Navigator.pop(context);
                              if (value?.output == null) {
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StoryViewer(
                                      storyModel: StoryModel(
                                        title: value!.output!.split('`')[0],
                                        body: value.output!.split('`')[1],
                                      ),
                                      gemini: _gemini,
                                      firstRequest: request,
                                    ),
                                  ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          'أنشأ حكايتي',
                          style: TextStyle(
                            fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.darkPrimary,
        fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
