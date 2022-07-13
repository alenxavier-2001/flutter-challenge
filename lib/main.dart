import 'package:developer_challenge_schedule/common/utils.dart';

import 'package:developer_challenge_schedule/events/events_bloc.dart';
import 'package:developer_challenge_schedule/models/eventmodel.dart';

import 'package:developer_challenge_schedule/services/api.dart';

import 'package:developer_challenge_schedule/widgets/custom_button.dart';
import 'package:developer_challenge_schedule/widgets/custom_textfeild.dart';
import 'package:developer_challenge_schedule/widgets/mediumtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(BlocProvider<EventsBloc>(
      create: (_) => EventsBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  String starttime = '1AM';
  String endtime = '1AM';
  String dropdownvalue = 'Item 1';
  String date = '00/00/0000';

  // List of items in our dropdown menu
  var items = [
    '1AM',
    '2AM',
    '3AM',
    '4AM',
    '5AM',
    '6AM',
    '7AM',
    '8AM',
    '9AM',
    '10AM',
    '11AM',
    '12AM',
    '1PM',
    '2PM',
    '3PM',
    '4PM',
    '5PM',
    '6PM',
    '7PM',
    '8PM',
    '9PM',
    '10PM',
    '11PM',
    '12PM',
  ];
  DateTime selectedDate = DateTime.now();

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
    return date;
  }

  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventsBloc>(context).add(EventsFetchEvent());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 5),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 148.0,
            title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(months[now.month],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                            )))
                  ],
                ),
                const SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: Row(
                    children: List.generate(
                      lastDayOfMonth.day,
                      (index) {
                        final currentDate =
                            lastDayOfMonth.add(Duration(days: index + 1));
                        final dayName = DateFormat('E').format(currentDate);
                        return Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 16.0 : 0.0, right: 16.0),
                          child: GestureDetector(
                            onTap: () => setState(() {
                              selectedIndex = index;
                            }),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height / 16,
                                  width: width / 8,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Colors.blue
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(44.0),
                                  ),
                                  child: Text(
                                    dayName.substring(0, 3),
                                    style: TextStyle(
                                      fontSize: width / 20,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  height: 2.0,
                                  width: 28.0,
                                  color: selectedIndex == index
                                      ? Colors.blue
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
      body: Padding(
        padding: EdgeInsets.only(top: height / 90, right: height / 90),
        child: BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
          if (state is EventsFetchSuccess) {
            List<EventModel> list = state.eventlist;
            if (list.isNotEmpty) {
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    String te = list[index].date.toString().substring(0, 2);

                    bool isdate =
                        (te == (selectedIndex + 1).toString()) ? true : false;

                    return Column(
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 240, 240, 240),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: width / 40, right: width / 40),
                            child: SizedBox(
                              height: height / 9,
                              child: Row(
                                children: [
                                  Container(
                                    height: height / 10,
                                    width: width / 7,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 102, 180, 243),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: const Icon(Icons.calendar_month),
                                  ),
                                  SizedBox(
                                    width: width / 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: mediumText(
                                                "6:00 AM - 7:00 AM",
                                                width,
                                                Colors.black)),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: mediumText("Morning Routine",
                                                width, Colors.black)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return const Center(
                child: Text('No Posts'),
              );
            }
          } else if (state is EventsFetchFailed) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is EventsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text("un expected error"),
            );
          }
        }),

        /*child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 240, 240, 240),
              child: Padding(
                padding: EdgeInsets.only(left: width / 40, right: width / 40),
                child: SizedBox(
                  height: height / 9,
                  child: Row(
                    children: [
                      Container(
                        height: height / 10,
                        width: width / 7,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 102, 180, 243),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Icon(Icons.calendar_month),
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: mediumText(
                                    "6:00 AM - 7:00 AM", width, Colors.black)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: mediumText(
                                    "Morning Routine", width, Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),*/
      ),
      floatingActionButton: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (BuildContext context,
                          StateSetter setState /*You can rename this!*/) {
                        return Padding(
                          padding: EdgeInsets.all(width / 35),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    'Add Schedule',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: width / 22,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: width / 2,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close))
                                ],
                              ),
                              SizedBox(
                                height: height / 80,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: mediumText('Name', width, Colors.black),
                              ),
                              SizedBox(
                                height: height / 80,
                              ),
                              SizedBox(
                                height: height / 12,
                                child: CustomTextField(
                                    controller: nameController,
                                    hintText: 'Enter the name of task'),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: mediumText(
                                    ' Date & Time', width, Colors.black),
                              ),
                              SizedBox(
                                height: height / 80,
                              ),
                              Container(
                                color: const Color.fromARGB(255, 202, 234, 250),
                                height: height / 4,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height / 60,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width / 30),
                                      child: SizedBox(
                                        height: height / 4.3,
                                        child: Column(
                                          children: [
                                            /*timeWidget(
                                                'Start time',
                                                width,
                                                Colors.black,
                                                starthour,
                                                startmin,
                                                0),*/
                                            Row(
                                              children: [
                                                mediumText('Start Time',
                                                    width / 1.1, Colors.black),
                                                SizedBox(
                                                  width: width / 2,
                                                ),
                                                Row(
                                                  children: [
                                                    DropdownButton(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          starttime =
                                                              value.toString();
                                                        });
                                                      },
                                                      value: starttime,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: items
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(items),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Divider(
                                              thickness: .8,
                                              color: Colors.black,
                                            ),
                                            Row(
                                              children: [
                                                mediumText('End Time  ',
                                                    width / 1.1, Colors.black),
                                                SizedBox(
                                                  width: width / 2,
                                                ),
                                                Row(
                                                  children: [
                                                    DropdownButton(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          endtime =
                                                              value.toString();
                                                        });
                                                      },
                                                      value: endtime,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: items
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(items),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Divider(
                                              thickness: .8,
                                              color: Colors.black,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _selectDate(context)
                                                    .then((value) {
                                                  setState(() {
                                                    date = value.toString();
                                                  });
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  mediumText(
                                                      'Date',
                                                      width / 1.1,
                                                      Colors.black),
                                                  SizedBox(
                                                    width: width / 2,
                                                  ),
                                                  mediumText(date, width / 1,
                                                      Colors.black),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CustomButton(
                                  text: 'Add Schedule',
                                  onTap: () {
                                    if (nameController.text.isNotEmpty) {
                                      SchedulerApi().postSchedule(
                                          context,
                                          starttime,
                                          endtime,
                                          date,
                                          nameController.text);
                                      Navigator.pop(context);
                                    } else {
                                      showSnackBar(context, 'Enter all fieds');
                                    }
                                  })
                            ],
                          ),
                        );
                      });
                    });
              },
              icon: const Icon(Icons.add))),
    );
  }
}
