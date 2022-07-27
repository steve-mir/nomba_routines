import 'package:flutter/material.dart';
import 'package:nomba_routines/database_helper.dart';
import 'package:nomba_routines/models/routine.dart';
import 'package:nomba_routines/screens/routinePage.dart';
import 'package:nomba_routines/widgets/TaskCardWidget.dart';

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
  int currenTab = 0;

  //DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    List<String> dates = datesFromDate();
    List<String> days = dayFromDate();

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 95,
                    color: Colors.blue,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: null == dates ? 0 : dates.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              createDateTabs(days[index], dates[index], index)
                            ],
                          );
                        }),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Routine>>(
                      future: DatabaseHelper.instance.getRoutines(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Routine>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Loading..."),
                          );
                        }
                        return snapshot.data!.isEmpty
                            ? Center(
                                child: Text("No Routines yet"),
                              )
                            : ListView(
                                children: snapshot.data!.map((e) {
                                  return TaskCardWidget(
                                    title: e.title,
                                    desc: e.desc,
                                  );
                                }).toList(),
                              );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoutinePage(),
                        )).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Icon(Icons.add),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell createDateTabs(String day, String date, int i) {
    return InkWell(
        onTap: () {
          currenTab = i;
          setState(() {});
        },
        child: Column(
          children: [
            Card(
                elevation: 5,
                color: Colors.white,
                shape: CircleBorder(),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(day,
                          style: TextStyle(
                              fontSize: 17,
                              color: (currenTab == i)
                                  ? Colors.blue
                                  : Colors.black)),
                      Text(date,
                          style: TextStyle(
                              fontSize: 17,
                              color: (currenTab == i)
                                  ? Colors.blue
                                  : Colors.black))
                    ],
                  )),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 4,
                width: 120,
                color: (currenTab == i) ? Colors.white : Colors.transparent)
          ],
        ));
  }

  List<String> datesFromDate() {
    List<String> list = [];
    var now = DateTime.now();

    for (var i = 15; i > -15; i--) {
      var now24 = now.subtract(Duration(days: i));
      int now24Int = now24.day;
      list.add(now24Int.toString());
    }

    return list;
  }

  List<String> dayFromDate() {
    List<String> list = [];
    var now = DateTime.now();
    List<String> days = ['', 'Mon', "Tue", 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    for (var i = 15; i > -15; i--) {
      var now24 = now.subtract(Duration(days: i));
      int now24Int = now24.weekday;

      list.add(days[now24Int]);
    }

    return list;
  }

  changeFilter(String filter) {
    filterType = filter;

    setState(() {});
  }
}
