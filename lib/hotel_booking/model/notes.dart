import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NoteItem {
  final String title;
  double rating;
  bool isChecked; // Change the type to bool

  NoteItem(this.title, {this.rating = 0.0, this.isChecked = false});
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<NoteItem> notesList = [
    NoteItem('Period start today', isChecked: false),
    NoteItem('Flow', rating: 0.0),
    NoteItem('Period ends today', rating: 0.0),
    NoteItem('Note', isChecked: false),
    NoteItem('Medicine', isChecked: false),
    NoteItem('Symptoms', isChecked: false),
    NoteItem('Moods', isChecked: false),
    NoteItem('Ovulation test', isChecked: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffF7EBE1),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xffF7EBE1),
      body: Padding(
        padding: EdgeInsets.only(right: 30, left: 30, top: 50, bottom: 60),
        child: Column(
          children: [
            Title(
              color: Colors.black,
              child: Text(
                'Today',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Card(
                // Wrap all ListTile(s) inside a single Card widget
                child: ListView.builder(
                  itemCount: notesList.length,
                  itemBuilder: (context, index) {
                    NoteItem item = notesList[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(item.title),
                          ),
                          if (item.title == 'Flow')
                            RatingBar.builder(
                              initialRating: item.rating,
                              minRating: 0.0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20.0,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  item.rating = rating;
                                });
                              },
                            ),
                          if (item.title == 'Period start today' || item.title == 'Period ends today' || item.title == 'Medicine')
                            Checkbox(
                              value: item.isChecked,
                              onChanged: (value) {
                                setState(() {
                                  item.isChecked = value!;
                                });
                              },
                            ),
                        ],
                      ),
                      onTap: () {
                        if (item.title == 'Note') {
                          _showNoteDialog(context);
                        } else if (item.title == 'Medicine') {
                          _showMedicineDialog(context);
                        } else if (item.title == 'Symptoms') {
                          _showSymptomsDialog(context);
                        } else if (item.title == 'Moods') {
                          _showMoodsDialog(context);
                        } else if (item.title == 'Ovulation test') {
                          _showOvulationTestDialog(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Note'),
          content: Text('This is the note pop-up dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showMedicineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Medicine'),
          content: Text('This is the medicine pop-up dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSymptomsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Symptoms'),
          content: Text('This is the Symptoms pop-up dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showMoodsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Moods'),
          content: Text('This is the Moods pop-up dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showOvulationTestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ovulation Test'),
          content: Text('This is the Ovulation Test pop-up dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
