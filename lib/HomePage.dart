import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "magista",
      ),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String filterType = 'today';
  DateTime today = new DateTime.now();
  var monthNames = [
    "JAN",
    "FEB",
    "Mar",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];

  CalendarController calendarController = new CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  title: Text(
                    "Routines",
                    style: TextStyle(fontSize: 30),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.short_text),
                      color: Colors.white,
                      iconSize: 30,
                    )
                  ])
            ],
          ),
          Container(
            height: 70,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        changeFilter("Today");
                      },
                      child: Text(
                        "Today",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 4,
                        width: 120,
                        color: (filterType == "Today")
                            ? Colors.white
                            : Colors.transparent)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        changeFilter("Monthly");
                      },
                      child: Text(
                        "Monthly",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 4,
                        width: 120,
                        color: (filterType == "Monthly")
                            ? Colors.white
                            : Colors.transparent)
                  ],
                ),
              ],
            ),
          ),
          (filterType == "Monthly")
              ? TableCalendar(calendarController: calendarController)
              : Container(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Today ${monthNames[today.month - 1]}, ${today.day}")
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {});
  }
}
