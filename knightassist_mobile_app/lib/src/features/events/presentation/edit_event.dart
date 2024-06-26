import 'dart:io';

import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

/*
DATA NEEDED:
- the full event object of the event being edited
- the current user's profile image
- the current user's ID
*/

DateTime selectedDate = DateTime.now();
TimeOfDay selectedStartTime = TimeOfDay.now();
TimeOfDay selectedEndTime = TimeOfDay.now();
File? _eventPicFile;
DateTime endDate = DateTime
    .now(); // used for events that have a different start date and end date
List<String> selectedTags = [];

class EditEvent extends ConsumerStatefulWidget {
  final Event event;
  const EditEvent({super.key, required this.event});

  @override
  ConsumerState<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends ConsumerState<EditEvent> {
  late final Event event;
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _maxVolunteersController = TextEditingController();

  String get title => _titleController.text;
  String get description => _descriptionController.text;
  String get location => _locationController.text;
  String get maxVolunteers => _maxVolunteersController.text;

  var _submitted = false;

  @override
  void initState() {
    event = widget.event;
    _titleController.text = event.name;
    _descriptionController.text = event.description;
    _locationController.text = event.location;
    _maxVolunteersController.text = event.maxAttendees.toString();
    super.initState();
  }

  @override
  void dispose() {
    _node.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _maxVolunteersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final eventsRepository = ref.watch(eventsRepositoryProvider);
    final authRepository = ref.watch(authRepositoryProvider);
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);
    final user = authRepository.currentUser;
    final imagesRepository = ref.watch(imagesRepositoryProvider);
    final organization = organizationsRepository.getOrganization(user!.id);

    selectedTags = event.eventTags;

    Widget getAppbarProfileImage() {
      return FutureBuilder(
          future: imagesRepository.retrieveImage('2', user!.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                final String imageUrl = snapshot.data!;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image(
                      semanticLabel: 'Profile picture',
                      image: NetworkImage(imageUrl),
                      height: 20),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    }

    showConfirmDialog(BuildContext context) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          DateTime startTime = DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedStartTime.hour, selectedEndTime.minute);

          DateTime endTime = DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedEndTime.hour, selectedEndTime.minute);

          eventsRepository.editEvent(
              event.id,
              event.sponsoringOrganization,
              title,
              description,
              location,
              startTime,
              endTime,
              _eventPicFile?.path ?? 'assets/orgdefaultbackground.png',
              selectedTags,
              event.semester.toString(),
              int.parse(maxVolunteers));
          Navigator.of(context).pop();
        },
      );

      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Confirmation"),
        content: Text("Are you sure you want to edit this event?"),
        actions: [okButton, cancelButton],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    showDeleteDialog(BuildContext context) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          eventsRepository.deleteEvent(event.sponsoringOrganization, event.id);
          Navigator.pop(context);
        },
      );

      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text(
          "Caution",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
        ),
        content: Text(
            "Are you sure you want to delete this event? This action cannot be undone. Doing so will remove this event from all volunteers' past and future history."),
        actions: [okButton, cancelButton],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Event',
        ),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.pushNamed("organization", extra: organization);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: getAppbarProfileImage(),
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
              controller: _titleController,
              //initialValue: event.name,
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
                  controller: _descriptionController,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  //initialValue: event.description,
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
              controller: _locationController,
              //initialValue: event.location,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Event Location',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _maxVolunteersController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Max Volunteers',
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
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Event Tags",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "You can select tags for an event from the tags of your organization.",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          TagsDropDown(organization: organization, event: event),
          Center(
            child: OverflowBar(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      showConfirmDialog(context);
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
                      showDeleteDialog(context);
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

class TagsDropDown extends StatefulWidget {
  Organization? organization;
  Event event;
  TagsDropDown({super.key, required this.organization, required this.event});

  @override
  State<TagsDropDown> createState() => _TagsDropDownState();
}

class _TagsDropDownState extends State<TagsDropDown> {
  late final Organization? organization;
  late final Event event;

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
  }

  late String dropdownValue = organization!.categoryTags.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: organization?.categoryTags
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          enabled: false,
          child: SizedBox(
            height: 200,
            width: 200,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = selectedTags.contains(value);
                return InkWell(
                  onTap: () {
                    isSelected
                        ? selectedTags.remove(value)
                        : selectedTags.add(value);
                    //This rebuilds the StatefulWidget to update the button's text
                    setState(() {});
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (isSelected)
                          const Icon(Icons.check_box_outlined)
                        else
                          const Icon(Icons.check_box_outline_blank),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
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
    return Consumer(
      builder: (context, ref, child) {
        final imagesRepository = ref.watch(imagesRepositoryProvider);

        Widget getEditableImage() {
          return FutureBuilder(
              future: imagesRepository.retrieveImage('1', event.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final String imageUrl = snapshot.data!;
                    return EditableImage(
                      onChange: _directUpdateImage,
                      image: _eventPicFile != null
                          ? Image.file(_eventPicFile!, fit: BoxFit.cover)
                          : Image(image: NetworkImage(imageUrl)),
                      size: 150,
                      imagePickerTheme: ThemeData(
                        primaryColor: Colors.yellow,
                        shadowColor: Colors.deepOrange,
                        colorScheme:
                            const ColorScheme.light(background: Colors.indigo),
                        iconTheme: const IconThemeData(color: Colors.red),
                        fontFamily: 'Papyrus',
                      ),
                      imageBorder: Border.all(color: Colors.lime, width: 2),
                      editIconBorder:
                          Border.all(color: Colors.purple, width: 2),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        }

        return Column(
          children: [
            getEditableImage(),
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
      },
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
