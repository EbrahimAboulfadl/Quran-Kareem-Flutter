import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../Models/AyahModel.dart';
import '../services/dio_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SpeechToText _speechToText = SpeechToText();
  String _searchQuery = "";
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    await _speechToText.listen(
        onResult: (result) {
          setState(() {
            _searchQuery = result.recognizedWords;
          });
        },
        localeId: 'ar');
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  List<AyahModel> ayat = [];
  void getData(String text) async {
    String url = 'http://api.alquran.cloud/v1/search/$text/all/ar';
    var response = await DioHelper().getMethod(url);
    if (response["code"] == 200) {
      List<AyahModel> ex = [];
      response["data"]["matches"].forEach((element) {
        ex.add(AyahModel.fromJson(element));
      });
      setState(() {
        ayat = ex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0037FF),
        title: Text(
          'Quranee',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _speechToText.isListening
                    ? "listening..."
                    : _speechEnabled
                        ? "Tap the microphone to start listening..."
                        : "Speech not available",
                style: TextStyle(fontSize: 20.0, color: Color(0xFFFFFFFF)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _searchQuery,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFFFFFFF)),
              ),
            ),
            ayat.length == 0
                ? Text(
                    'Search for any Ayah',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  )
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: ayat.length,
                      itemBuilder: (context, index) => ayat[index].source ==
                              'quran-simple-clean'
                          ? Card(
                              child: ListTile(
                                  leading: (CircleAvatar(
                                    child:
                                        Text(ayat[index].ayahNumber.toString()),
                                  )),
                                  title: Text('${ayat[index].ayahText}'),
                                  subtitle: Text(
                                    '${ayat[index].ayahSurah}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.grey),
                                  )),
                            )
                          : null,
                    ),
                  ),
            if (_speechToText.isNotListening)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ),
              ),
            Center(
              child: OutlinedButton(
                child: Text("Search the Ayah"),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  getData(_searchQuery);
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF194993),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stopListening : startListening,
        tooltip: 'Listen',
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
          color: Color(0xFFFFFFFF),
        ),
        backgroundColor: Color(0xFF000000),
      ),
    );
  }
}
