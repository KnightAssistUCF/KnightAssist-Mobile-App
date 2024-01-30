import 'dart:io';

import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

DateTime selectedDate = DateTime.now();
TimeOfDay selectedStartTime = TimeOfDay.now();
TimeOfDay selectedEndTime = TimeOfDay.now();
File? _eventPicFile;
DateTime endDate = DateTime
    .now(); // used for events that have a different start date and end date

class EditEvent extends ConsumerWidget {
  EditEvent({super.key, required this.event});

  Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final eventsRepository = ref.watch(eventsRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Event',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: event.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Event Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 240,
                height: 120,
                child: TextFormField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  initialValue: event.description,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: false,
                      hintText: 'Event Description'),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          SelectDate(
            event: event,
          ),
          MultiDayEvent(
            event: event,
          ),
          SizedBox(
              height: 100,
              width: 50,
              child: SelectTime(
                event: event,
              )),
          SizedBox(
              height: 90,
              width: 50,
              child: SelectEndTime(
                event: event,
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: event.location,
              decoration: const InputDecoration(
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
                Center(
                  child: EditImage(
                    event: event,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: OverflowBar(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      /*              Map<dynamic, dynamic> map = {
  "name": name,
  String? description,
  String? location,
  DateTime? startTime,
  DateTime? endTime,
  String? picLink,
  List<String>? eventTags,
  String? semester,
  int? maxAttendees,
}
                      eventsRepository.editEvent(event.id, map);*/
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Update Event',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      eventsRepository.deleteEvent(
                          event.sponsoringOrganization, event.id);
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Delete Event',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  Event event;
  SelectDate({Key? key, required this.event}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late final Event event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: event.startTime,
        firstDate: DateTime(2023, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != event.startTime) {
      setState(() {
        event.startTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text(DateFormat.yMMMMEEEEd().format(event.startTime))),
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
  Event event;
  SelectTime({Key? key, required this.event}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late final Event event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(event.startTime));
    if (picked != null && picked != TimeOfDay.fromDateTime(event.startTime)) {
      setState(() {
        event.startTime = new DateTime(
            event.startTime.year,
            event.startTime.month,
            event.startTime.day,
            picked.hour,
            picked.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child:
                Text(TimeOfDay.fromDateTime(event.startTime).format(context))),
        const SizedBox(
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
  Event event;

  SelectEndTime({Key? key, required this.event}) : super(key: key);

  @override
  State<SelectEndTime> createState() => _SelectEndTimeState();
}

class _SelectEndTimeState extends State<SelectEndTime> {
  late final Event event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(event.endTime));
    if (picked != null && picked != TimeOfDay.fromDateTime(event.endTime)) {
      setState(() {
        event.endTime = new DateTime(event.endTime.year, event.endTime.month,
            event.endTime.day, picked.hour, picked.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(TimeOfDay.fromDateTime(event.endTime).format(context))),
        const SizedBox(
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
  Event event;
  EditImage({super.key, required this.event});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  late final Event event;

  File? get imagePlaceHolder => null;

  set imagePlaceHolder(File? imagePlaceHolder) {}

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  Future<void> _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _eventPicFile = file;
    });
  }

  Future<void> _deleteImage() async {
    File imagePlaceHolder;

    _setPlaceHolder() async {
      this.imagePlaceHolder = await ImageUtils.imageToFile(
          imageName: "orgdefaultbackground", ext: "png");
    }

    setState(() {
      _eventPicFile = this.imagePlaceHolder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditableImage(
          onChange: _directUpdateImage,
          image: _eventPicFile != null
              ? Image.file(_eventPicFile!, fit: BoxFit.cover)
              : Image(image: AssetImage(event.profilePicPath)),
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  _deleteImage();
                },
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
    );
  }
}

class MultiDayEvent extends StatefulWidget {
  Event event;

  MultiDayEvent({super.key, required this.event});

  @override
  State<MultiDayEvent> createState() => _MultiDayEventState();
}

class _MultiDayEventState extends State<MultiDayEvent> {
  late final Event event;
  bool isChecked = true;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: event.endTime,
        firstDate: DateTime(2023, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != event.endTime) {
      setState(() {
        event.endTime = picked;
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
          title: const Text(
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
              Center(
                  child: Text(DateFormat.yMMMMEEEEd().format(event.endTime))),
              const SizedBox(
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

class ImageUtils {
  static Future<File> imageToFile(
      {required String imageName, required String ext}) async {
    var bytes = await rootBundle.load('assets/$imageName.$ext');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }
}
