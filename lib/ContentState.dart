import 'dart:ffi';
import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ContentState extends StatefulWidget {
  final String title;

  const ContentState({super.key, required this.title});

  @override
  State<ContentState> createState() => _ContentStateState(userName: title);
}

void getData() async{
  String name =  await Future.delayed(Duration(seconds: 5),()=>'Naveen');
  String bio = await Future.delayed(Duration(seconds: 5),()=>'dev');
  print('$name');

}
void getBio() async{
  String bio = await Future.delayed(Duration(seconds: 5),()=>'dev');
  print(' and $bio');
}

class _ContentStateState extends State<ContentState> {
  List<String> quote = ['Naveen','Balaji','Rolex','Tiger','Mufasa','Leo','ALex''Naveen','Balaji','Rolex','Tiger','Mufasa','Leo','ALex'];
  final String userName;

  _ContentStateState({required this.userName});

  void _setContent(String content) {
    setState(() {
      quote.add(content);
    });
  }

  Widget cardTemplate(String quote, {required Function() delete}) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      color: Colors.pink[100],
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(quote),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                onPressed: delete,
                child:const Text('delete') )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getData();
    getBio();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink[400],
        title: Text('Welcome $userName'),
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink[400],
          onPressed: () {
            showEmptyTitleDialog(context, (String content) {
              _setContent(content);
            });
          },
          child: const Text('Create'),
        ),
      body: ListView.builder( padding: const EdgeInsets.all(8),
        itemCount: quote.length,
        itemBuilder: (BuildContext context,int index){
          return SizedBox(
            child: Container(
              child: cardTemplate(quote[index], delete: (){
               setState(() {
                 print(index);
                 quote.removeAt(index);
               });
              }),
            )
          );
        })
    );
  }
}


void showEmptyTitleDialog(BuildContext context, void Function(String) createContent) {
  TextEditingController contentController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: Text(
          "Create Your Content",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: TextField(
          controller: contentController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type Your Content',
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
            ),
            child: const Text(
              "Create",
            ),
            onPressed: () {
              createContent(contentController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}