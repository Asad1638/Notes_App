import 'package:flutter/material.dart';
import 'package:hive/hive.dart';



import '../models/notes_model.dart';
import 'constant.dart';

class AddNotes extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  final myBox = Hive.box('Notes');
  AddNotes({super.key});
  void _saveNote(context) {
    if (_title.text.isEmpty) {
      showToast(context, 'the title is  empty');
    } else if (_content.text.isEmpty) {
      showToast(context, 'the content is empty');
    } else {
      final myObj = NotesModel(
          title: _title.text, description: _content.text);
      myBox.add(myObj);
      
      myObj.save();
      Navigator.of(context).pop();
    }
  }

  showToast(context, message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('N O T E S'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _saveNote(context),
              icon: const Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding:const  EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextField(cursorColor: kPrimaryColor,
              controller: _title,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Title',
                 labelStyle:const TextStyle(color: kPrimaryColor),
                border: buildingBorder(),
                
                  focusedBorder: buildingBorder(kPrimaryColor),
                enabledBorder: buildingBorder(kPrimaryColor),
              ),
            ),
           const  SizedBox(
              height: 20,
            ),
            TextField(cursorColor: kPrimaryColor,
              controller: _content,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                 labelStyle:const TextStyle(color: kPrimaryColor),
                border: borderBuilding(),
                 focusedBorder: borderBuilding(kPrimaryColor),
                enabledBorder: borderBuilding(kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder borderBuilding([Color]) {
    return OutlineInputBorder(
      borderSide:const  BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              );
  }

  OutlineInputBorder buildingBorder([Color]) {
    return OutlineInputBorder(
    borderSide:const  BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              );
  }
}
