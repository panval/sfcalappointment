import 'package:flutter/material.dart';
import 'add_event_page.dart';
import 'calendar_widget.dart';

void main() {
  runApp(const SfCalExample());
}

class SfCalExample extends StatelessWidget {
  const SfCalExample({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ForSF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Main(title: 'How to add appointments with FAB'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.title});

  final String title;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(flex: 2, child: CalendarWidget(setState)),
            Expanded(flex: 1, child: Agenda())
          ],
        ),
        floatingActionButton: SizedBox(
          width: 200,
          child: TextButton(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.shade700.withOpacity(0.9),
                      offset: Offset(0, 2),
                      blurRadius: 10,
                    )
                  ],
                  color: Colors.black.withOpacity(0.9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$selectedDay',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.green.shade400,
                    size: 45,
                  ),
                ],
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: const EventEditingPage(), //TODO: Change!
                    );
                  }),
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endDocked, // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                  'Here I got a Custom Agenda but it is irrelevat for this example so I am using it to describe the problem',),
              SizedBox(
                height: 10,
              ),
              Text('As you can see, when the user taps the calendar, the date changes on the Add-Button. '),
              SizedBox(height: 10,),
              Text('The user taps the add Button - then types his Appointment and clicks save - but how does this information go to the calendar data source?')
            ],
          ),
        ),
      ),
    );
  }
}
