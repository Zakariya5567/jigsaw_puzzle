import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jigsaw_puzzle/src/puzzle_view.dart';
import 'package:path_provider/path_provider.dart';


jigsawPuzzle(
    BuildContext context,
    String imageUrl,
    GlobalKey<PuzzleViewState> puzzleKey
    ) {
  return
    showDialog(
      useSafeArea: false,
      barrierDismissible: true,
      context: context,
      builder: (context) {

        Color coinBackgroundColor = const Color.fromRGBO(0, 0, 153, 0.5);

        final height = MediaQuery.sizeOf(context).height;
        final width = MediaQuery.sizeOf(context).width;

        return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: FutureBuilder(
             future: networkImageToFile(imageUrl),
              builder: (context,snapshot) {
               if(snapshot.hasData){
                 puzzleKey.currentState!.generatePuzzle(snapshot.data!);
                }
                return StatefulBuilder(builder: (context, setState) {
                  return  Stack(

                    children: [
                    Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                        color: coinBackgroundColor,
                    ),),
                    Container(
                          height: height,
                          width: width,
                          decoration: BoxDecoration(
                              color: coinBackgroundColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                            const Text("Jigaw Puzzle",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),),


                              SizedBox(height: height*0.01,),
                              PuzzleView(
                                key: puzzleKey,
                                image: snapshot.data,
                                height: height*0.50,
                                backgroundColor: coinBackgroundColor,
                                width:  height*0.50,
                                gridSize: 4,
                                onCompleted: () {
                                  print("COMOPLETED");
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Center(
                                  child: InkWell(
                                    onTap: () {
                                      puzzleKey.currentState!.resetPuzzle();
                                    },
                                    child:  Icon(
                                      Icons.refresh,
                                      size: width*0.095,
                                      color: Colors.white,
                                    ),
                                  )),
                            ],
                          ),

                      ),
                    Positioned(
                      top: height*0.15,
                      left: width*0.84,
                      child:IconButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        icon: const Icon(Icons.highlight_remove,
                          size: 30,
                          color: Colors.white,)),)
                    ],
                  );

                });
              }
            ));
      });
}


Future<File> networkImageToFile(String imageUrl) async {
    var name =  DateTime.now().millisecondsSinceEpoch;
    // get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
    // get temporary path from temporary directory.
    String tempPath = tempDir.path;
    // create a new file in temporary path with random file name.
    File file =  File('$tempPath$name.png');
    // call http.get method and pass image url into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
    // write body bytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
    final image = File(file.path);
    return image;
}