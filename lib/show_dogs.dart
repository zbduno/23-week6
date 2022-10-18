//import necessary packages
import 'file_storage.dart';
import 'package:flutter/material.dart';
import 'add_dog.dart';

class ShowDogsPage extends StatefulWidget {
  const ShowDogsPage({Key? key}) : super(key: key);

  @override
  State<ShowDogsPage> createState() => _ShowDogsPageState();
}

class _ShowDogsPageState extends State<ShowDogsPage> {
  //create a future list of string that will store all the dog data from textfile
  late Future<List<String>?> myDogs;
  FileStorage fileHandler = FileStorage('dogs.txt');

  @override
  void initState() {
    super.initState();
    //initialize myDogs list by getting data from textfile
    myDogs = fileHandler.readFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dogs List"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          myDogsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigate to AddDogPage page and automatically calls the setState()
          //to render newly added dog in textfile when Navigator.pop is called from AddDogPage page
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) =>
                      AddDogPage(title: 'Add Dog', fileHandler: fileHandler)))
              .then((value) => setState(() {
                    myDogs = fileHandler.readFile();
                  }));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  //Since readFile method will return a Future list, we need a Future builder to build our list
  //using listView.builder
  Widget myDogsList() {
    return Expanded(
      child: FutureBuilder(
          future: myDogs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildText(snapshot.data as List<String>);
            } else {
              //if textfile has no data
              return const Center(
                child: Text("No dogs found"),
              );
            }
          }),
    );
  }

  void _deleteDog(myDogs, item) {
    setState(() {
      if (myDogs != null) {
        myDogs.remove(item);
      }
    });
  }

  void _writeStrings(myDogs) {
    String str1 = "";

    for (String str in myDogs) {
      str1 = str1 + str + '\n';
    }

    fileHandler.writeAll(str1);
  }

  //widget that returns listview of myDogs data
  Widget buildText(List<String> myDogs) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: myDogs.length,
      itemBuilder: (context, int index) {
        return Card(
          child: ListTile(
            title: Text(myDogs[index].split(' ')[
                0]), //dog name is the first item from returned list of split()
            subtitle: Text(myDogs[index].split(' ')[
                1]), //dog age is the second item from returned list of split()
            trailing: const Icon(Icons.delete),
            onTap: () {
              //TODO: insert method to delete data from file
              _deleteDog(myDogs, myDogs[index]);
              _writeStrings(myDogs);
            },
          ),
        );
      },
    );
  }
}
