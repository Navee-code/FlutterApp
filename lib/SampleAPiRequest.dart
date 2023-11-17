import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_project/models/Albums.dart';


class SampleApiRequest extends StatefulWidget {
  const SampleApiRequest({super.key});

  @override
  State<SampleApiRequest> createState() => _SampleApiRequestState();
}

class _SampleApiRequestState extends State<SampleApiRequest> {
  Future<List<Albums>> getAlbums() async{
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com','photos'));
    var source = jsonDecode(response.body);
    List<Albums> albums = [];
    for(var i in source) {
      albums.add(Albums(i['title'],i['url'],i['thumbnailUrl']));
    }
    return albums;

  }
  @override
  Widget build(BuildContext context) {
    getAlbums();
    return Scaffold(
      body: Container(
          child:FutureBuilder(
            future: getAlbums(),
            builder: (context, snapshot) {
              return ListView.builder(itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context,int index){
                if(snapshot.data == null){
                  return  Card(
                      margin:  const EdgeInsets.all(8.0),
                      color: Colors.pink[100],
                    child: const Text('Loading'),
                  ) ;
                }
                  return Container(
                      child: Card(
                      margin: const EdgeInsets.all(8.0),
                      color: Colors.pink[100], child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data![index].title,

                        ),
                      ),
                      )
                  );
                }
              );

            },
          ),

      ),
    );
  }
}
