import 'package:flutter/material.dart';
import 'package:nomba_routines/database_helper.dart';
import 'package:nomba_routines/models/routine.dart';
import 'package:nomba_routines/widgets/checklistWidget.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({Key? key}) : super(key: key);

  @override
  RoutinePageState createState() => RoutinePageState();
}

class RoutinePageState extends State<RoutinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 12.0),
                  child: Row(children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Icon(
                            Icons.arrow_back,
                          )),
                    ),
                    Expanded(
                        child: TextField(
                      onSubmitted: ((value) async {
                        print(value);
                        /*if (value != "") {
                          DatabaseHelper _dbHelper = DatabaseHelper();
                          Routine _newRoutine =
                              Routine(title: value, description: "", id: 1);

                          await _dbHelper.InsertRoutines(_newRoutine);
                          print("New rotuine created");
                        }*/
                      }),
                      decoration: InputDecoration(
                          hintText: "Enter routine title",
                          border: InputBorder.none),
                      style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF211551)),
                    ))
                  ])),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 12.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Enter the description for this routine",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
                ),
              ),
              CheckListWidget(
                text: "Help",
                isDone: false,
              ),
              CheckListWidget(
                text: "Sad",
                isDone: true,
              ),
              CheckListWidget(
                text: "Will still do",
                isDone: false,
              ),
              CheckListWidget(
                text: "not doing",
                isDone: true,
              ),
            ]),
            Positioned(
              bottom: 24.0,
              right: 24.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoutinePage(),
                      ));
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Color(0xFFFE3577),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
