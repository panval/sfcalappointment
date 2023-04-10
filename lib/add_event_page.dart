import 'package:flutter/material.dart';
import 'calendar_widget.dart';

const List<String> optionsList = <String>[
  'Repeating',
  'Weekly',
  'Monthly',
  'Yearly'
];

class EventEditingPage extends StatefulWidget {

  const EventEditingPage({
    Key? key,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, top: 5, bottom: 5),
                              child: Text(
                                '$selectedDayFull',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        buildTitle(),
                        const SizedBox(height: 10),
                        const AppointmentOptions(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.lock_outline),
                                    Text(
                                      ' Super-Private ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          surfaceTintColor: Colors.white,
                                          title: const Text(' Super-Privat'),
                                          content: const Text(
                                            'Describes funktion - not relevat for this example',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.done, color: Colors.white, size: 30,),
                                                ],
                                              ),
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                          side: BorderSide(color: Colors.black)
                                                      )
                                                  ),
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green)),
                                            ),
                                          ],
                                        ),
                                  ),
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            MyCheckbox()
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                        BorderSide(color: Colors.black)),
                                    elevation: MaterialStateProperty.all(5),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        )),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green.shade600)),
                                onPressed: () {
                                  //TODO implement Save
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Save',
                                      style: TextStyle(
                                        decorationThickness: 2,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildTitle() => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black)),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        cursorColor: Colors.black,
        autofocus: true,
        controller: titleController,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          hintText: "Add Appointment",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        //onFieldSubmitted: (_) => saveForm(),
        validator: (title) => title != null && title.isEmpty
            ? 'Termin/Erinnerung fehlt'
            : null,
      ),
    ),
  );

}

class AppointmentOptions extends StatefulWidget {
  const AppointmentOptions({super.key});

  @override
  State<AppointmentOptions> createState() => _AppointmentOptionsState();
}

class _AppointmentOptionsState extends State<AppointmentOptions> {
  String dropdownValue = optionsList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      dropdownColor: Colors.white,
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.repeat, color: Colors.black),
      elevation: 16,
      style: const TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      underline: Container(
        height: 0,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: optionsList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MyCheckbox extends StatefulWidget {
  const MyCheckbox({super.key});

  @override
  State<MyCheckbox> createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.black;
    }

    return Transform.translate(
      offset: const Offset(14, 0),
      child: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
