import 'dart:io';

import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

DateTime selectedDate = DateTime.now();
TimeOfDay selectedStartTime = TimeOfDay.now();
TimeOfDay selectedEndTime = TimeOfDay.now();
File? _eventPicFile;
DateTime endDate = DateTime
    .now(); // used for events that have a different start date and end date

class CreateEvent extends ConsumerWidget {
  const CreateEvent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Event',
        ),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              tooltip: 'View notifications',
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                semanticLabel: 'Notifications',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.profileScreen.name);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: const Image(
                      semanticLabel: 'Profile picture',
                      image: AssetImage(
                          'assets/profile pictures/icon_paintbrush.png'),
                      height: 20),
                ),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Event Title',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
                width: 240,
                height: 120,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: false,
                      hintText: 'Event Description'),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          const SelectDate(),
          const MultiDayEvent(),
          const SizedBox(height: 100, width: 50, child: SelectTime()),
          const SizedBox(height: 100, width: 50, child: SelectEndTime()),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Event Location',
              ),
            ),
          ),
          const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Event Image (Optional)",
              style: TextStyle(fontSize: 17),
            ),
          )),
          const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "We recommend using an image that is around 2000x1400 px or a similar ratio. It will be cropped in the events list screen on the mobile app but users can view the full image by tapping on an event.",
              style: TextStyle(fontSize: 14),
            ),
          )),
          Center(
            child: OverflowBar(
              children: [
                Center(child: const EditImage()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Delete Image (reverts to default)',
                            style: TextStyle(fontSize: 15),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Create Event',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text(DateFormat.yMMMMEEEEd().format(selectedDate))),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Select Event Date'),
          ),
        ),
      ],
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text(selectedStartTime.format(context))),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () => _selectTime(context),
            child: const Text('Select Event Start Time'),
          ),
        ),
      ],
    );
  }
}

class SelectEndTime extends StatefulWidget {
  const SelectEndTime({Key? key}) : super(key: key);

  @override
  State<SelectEndTime> createState() => _SelectEndTimeState();
}

class _SelectEndTimeState extends State<SelectEndTime> {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text(selectedEndTime.format(context))),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ElevatedButton(
            onPressed: () => _selectTime(context),
            child: const Text('Select Event End Time'),
          ),
        ),
      ],
    );
  }
}

class EditImage extends StatefulWidget {
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _eventPicFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EditableImage(
      onChange: _directUpdateImage,
      image: _eventPicFile != null
          ? Image.file(_eventPicFile!, fit: BoxFit.cover)
          : const Image(image: AssetImage('assets/orgdefaultbackground.png')),
      size: 150,
      imagePickerTheme: ThemeData(
        primaryColor: Colors.yellow,
        shadowColor: Colors.deepOrange,
        colorScheme: const ColorScheme.light(background: Colors.indigo),
        iconTheme: const IconThemeData(color: Colors.red),
        fontFamily: 'Papyrus',
      ),
      imageBorder: Border.all(color: Colors.lime, width: 2),
      editIconBorder: Border.all(color: Colors.purple, width: 2),
    );
  }
}

class MultiDayEvent extends StatefulWidget {
  const MultiDayEvent({super.key});

  @override
  State<MultiDayEvent> createState() => _MultiDayEventState();
}

class _MultiDayEventState extends State<MultiDayEvent> {
  bool isChecked = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2023, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Color.fromARGB(255, 91, 78, 119);
    }

    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            "Multi-Day Event (end date different than start date)",
            textAlign: TextAlign.center,
          ),
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Visibility(
          visible: isChecked,
          child: Column(
            children: [
              Center(child: Text(DateFormat.yMMMMEEEEd().format(endDate))),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select Event End Date'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
