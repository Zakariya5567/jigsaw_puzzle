import 'package:flutter/material.dart';
import 'package:jigsaw_puzzle/src/puzzle_view.dart';

import 'jigsaw_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<PuzzleViewState> puzzleKey = GlobalKey<PuzzleViewState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              InkWell(
                onTap: (){
                  jigsawPuzzle(context,
                      "https://images5.alphacoders.com/111/1117238.jpg",
                      puzzleKey);
                },
                child: Container(height: 200,
                 width: 300,
                  color: Colors.red,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
