import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/SampleAPiRequest.dart';
import 'package:sample_project/main.dart';
import 'ContentPreference.dart';


class ContentState extends StatefulWidget {
  final String title;

  const ContentState({super.key, required this.title});

  @override
  State<ContentState> createState() => _ContentStateState(userName: title);
}
enum shared{
  Save,Fetch,ListView,GridView
}
class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children:<Widget> [
              ContentState(title: ''),
              SampleApiRequest()
            ],
          ),
        ),
      ),
    );
  }
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

  void storeFetch(List<String> quote, shared save, {required Function(Future<List<String>>) fectch})async{
    switch (save) {
      case shared.Save:
        ContentPreference.saveList(quote);
        break;
      case shared.Fetch:
        Future<List<String>> json = ContentPreference.fetchList();
        fectch(json);
        break;

      default:
    }

  }


class _ContentStateState extends State<ContentState> {
  List<String> quote =  [
    'Naveen',
    'Balaji',
    'Rolex',
    'Tiger',
    'Mufasa',
    'Leo',
    'ALex',
    'John',
    'Emma',
    'Olivia',
    'William',
    'James',
    'Sophia',
    'Ethan',
    'Isabella',
  ];
  final String userName;
  shared viewType = shared.ListView;

  _ContentStateState({required this.userName});

  void _setContent(String content) {
    setState(() {
      quote.add(content);
      storeFetch(quote, shared.Save, fectch: (Future<List<String>> json){});

    });

  }
  void handleClick(String value) {
    switch (value) {
      case 'ListView':
        setState(() {
          viewType = shared.ListView;
        });
        break;
      case 'GridView':
       setState(() {
         viewType = shared.GridView;
       });
        break;
    }
  }
  Widget getScrollViewType(shared view){
    switch (view) {
      case shared.GridView:
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // You can adjust the number of columns as needed
          ),
          itemCount: quote.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: cardTemplate(quote[index], delete: () {
                setState(() {
                  quote.removeAt(index);
                });
              }),
            );
          },
        );

      case shared.ListView:
        return ListView.builder( padding: const EdgeInsets.all(8),
            itemCount: quote.length,
            itemBuilder: (BuildContext context,int index){
              return SizedBox(
                  child: Container(
                    child: cardTemplate(quote[index], delete: (){
                      setState(() {
                        quote.removeAt(index);
                      });
                    }),
                  )
              );
            });


      default:
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // You can adjust the number of columns as needed
          ),
          itemCount: quote.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: cardTemplate(quote[index], delete: () {
                setState(() {
                  quote.removeAt(index);
                });
              }),
            );
          },
        );

    }

  }
  Widget cardTemplate(String quote, {required Function() delete}) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
  Widget cardTemplateGrid(String quote, {required Function() delete}) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      color: Colors.pink[100],
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
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
    storeFetch(quote, shared.Fetch, fectch: (Future<List<String>> json) async{
    List<String> data = await json;

    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'ListView', 'GridView'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
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
      body:getScrollViewType(viewType)

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