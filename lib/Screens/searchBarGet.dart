import 'package:flutter/material.dart';
import 'package:youtube/main.dart';

class SearchBar extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.keyboard_arrow_left_outlined,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => Home(null),
        //       ),
        //     );
        //   },
        // ),
        title: Container(
          height: 40,
          color: Colors.grey[100],
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Search YouTube",
              hintStyle: TextStyle(),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(textController.text),
                  ),
                );
              }),
          // IconButton(
          //     icon: Icon(Icons.mic_outlined, color: Colors.black),
          //     onPressed: () {}),
        ],
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
