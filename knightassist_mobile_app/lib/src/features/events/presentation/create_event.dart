import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

/*
DATA NEEDED:
- the current user's profile image and ID
*/

DateTime selectedDate = DateTime.now();
TimeOfDay selectedStartTime = TimeOfDay.now();
TimeOfDay selectedEndTime = TimeOfDay.now();
File? _eventPicFile;
DateTime endDate = DateTime
    .now(); // used for events that have a different start date and end date
List<String> selectedTags = [];

class CreateEvent extends ConsumerStatefulWidget {
  const CreateEvent({super.key});

  @override
  ConsumerState<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends ConsumerState<CreateEvent> {
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
    final user = authRepository.currentUser;

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
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
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _locationController,
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
          const Center(
            child: OverflowBar(
              children: [
                Center(child: EditImage()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  DateTime startTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedStartTime.hour,
                      selectedEndTime.minute);

                  DateTime endTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedEndTime.hour,
                      selectedEndTime.minute);

                  eventsRepository.addEvent(
                      title,
                      description,
                      location,
                      selectedDate,
                      user!.id,
                      startTime,
                      endTime,
                      _eventPicFile?.path ?? 'assets/orgdefaultbackground.png',
                      selectedTags,
                      '',
                      int.parse(maxVolunteers));
                },
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

class TagsDropDown extends StatefulWidget {
  Organization? organization;
  TagsDropDown({super.key, required this.organization});

  @override
  State<TagsDropDown> createState() => _TagsDropDownState();
}

class _TagsDropDownState extends State<TagsDropDown> {
  late final Organization? organization;

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
        const SizedBox(
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
  const EditImage({super.key});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  File? get imagePlaceHolder => null;

  set imagePlaceHolder(File? imagePlaceHolder) {}

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
              : const Image(
                  image: AssetImage('assets/orgdefaultbackground.png')),
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
              Center(child: Text(DateFormat.yMMMMEEEEd().format(endDate))),
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
