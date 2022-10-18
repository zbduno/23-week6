import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'file_storage.dart';

class AddDogPage extends StatefulWidget {
  const AddDogPage({Key? key, required this.title, required this.fileHandler})
      : super(key: key);
  final String title;
  final FileStorage fileHandler;
  @override
  State<AddDogPage> createState() => _AddDogPageState();
}

class _AddDogPageState extends State<AddDogPage> {
  final TextEditingController _name =
      TextEditingController(); //controller for getting dog name
  final TextEditingController _age =
      TextEditingController(); //controller for dog age
//data to be inserted to file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildTextField('Enter name', _name),
          buildTextField('Enter age', _age),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSaveButton(),
              buildViewButton(),
            ],
          )
        ],
      ),
    );
  }

  //function for creating a textfield widget which accepts the label and controller as parameter
  Widget buildTextField(String label, TextEditingController _controller) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    );
  }

  //function for creating save button
  Widget buildSaveButton() {
    return ElevatedButton(
        child: const Text('Save'),
        onPressed: () {
          //create an instance of the data you want to save
          Dog dog = Dog(_name.text, _age.text);

          //write formatted data to textfile
          widget.fileHandler.writeString(dog.dogData);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
          //clear text on controllers after successful insert of data to database
          _name.clear();
          _age.clear();
        });
  }

  Widget buildViewButton() {
    return ElevatedButton(
      onPressed: () {
        //go back to list of dogs page
        Navigator.pop(context);
      },
      child: const Text("View"),
    );
  }
}
