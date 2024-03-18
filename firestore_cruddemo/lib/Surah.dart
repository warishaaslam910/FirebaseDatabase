import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class Surah extends StatefulWidget {
  const Surah({super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 178, 221),
      appBar: AppBar(
        title: Text(quran.getSurahName(18)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(18),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  quran.getVerse(18, index + 1, verseEndSymbol: true),
                  textAlign: TextAlign.right,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
