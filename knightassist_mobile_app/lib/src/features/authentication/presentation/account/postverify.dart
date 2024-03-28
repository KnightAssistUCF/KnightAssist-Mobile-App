import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

/*
DATA NEEDED:
- the current user's ID and full studentuser or org object
*/

List<String> tags = [
  "Education",
  "Technology",
  "Community Service",
  "Environment",
  "Arts & Culture",
  "Health & Wellness",
  "Leadership",
  "Sports & Recreation",
  "Social Justice",
  "Entrepreneurship",
  "International Affairs",
  "Gardening & Horticulture",
  "Creative Writing",
  "Dance & Movement",
  "Music & Performance",
  "Science & Research",
  "Engineering",
  "Mathematics",
  "Language & Linguistics",
  "Culinary Arts",
  "Animal Welfare",
  "History & Heritage",
  "Politics & Governance",
  "Media & Communication",
  "Spirituality & Religion",
  "Mental Health Awareness",
  "Sustainability & Conservation",
  "Diversity & Inclusion",
  "Tutoring & Mentoring",
  "Fundraising & Philanthropy",
  "Legal Aid & Human Rights",
  "Robotics & AI",
  "Fashion & Design",
  "Film & Photography",
  "Theater & Drama",
  "Outdoor Adventure",
  "Networking & Career Development",
  "Gaming & eSports",
  "Volunteering",
  "Women's Empowerment",
  "LGBTQ+ Advocacy",
  "Disability Awareness",
  "Cultural Exchange",
  "Public Speaking",
  "Literary Society",
  "Coding & Software Development",
  "Astronomy & Space",
  "DIY & Crafting",
  "Yoga & Mindfulness",
  "Travel & Exploration"
];

List<String> selectedTags = [];

class PostVerify extends StatefulWidget {
  const PostVerify({super.key});

  @override
  _PostVerifyState createState() => _PostVerifyState();
}

class _PostVerifyState extends State<PostVerify> {
  final _descriptionController = TextEditingController();
  final _hourGoalController = TextEditingController();

  String get description => _descriptionController.text;
  String get hourGoal => _hourGoalController.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _hourGoalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authRepository = ref.watch(authRepositoryProvider);
        final user = authRepository.currentUser;
        bool isOrg = user?.role == 'organization';
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);

        organizationsRepository.fetchOrganizationsList();
        final org = organizationsRepository.getOrganization(user?.id ?? '');

        final studentRepository = ref.watch(studentsRepositoryProvider);

        studentRepository.fetchStudent(user!.id);
        final student = studentRepository.getStudent();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Additional Information'),
          ),
          body: ListView(
            children: [
              const Image(
                image: AssetImage('assets/KnightAssistCoA3.png'),
                height: 60,
                alignment: Alignment.center,
              ),
              isOrg
                  ? const Text(
                      'Write a description of your organizaion to show volunteers what it\'s about!.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )
                  : const Text(
                      'What is your semester volunteer hour goal?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
              isOrg
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildTextField(
                          labelText: 'Description',
                          controller: _descriptionController),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildTextField(
                          labelText: 'Semester Goal',
                          numbersOnly: true,
                          controller: _hourGoalController),
                    ),
              Text(
                isOrg
                    ? 'Select up to 10 tags for your organization.'
                    : 'What are your interests? Select up to 10 below:',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Text(
                isOrg
                    ? 'This helps connect interested volunteers to your organization by suggesting them recommendations.'
                    : 'This helps connect you to relevant organizations and events.',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                    spacing: 5.0,
                    children: [for (var tag in tags) ChooseTags(tag: tag)]),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    if (isOrg) {
                      organizationsRepository.editOrganization(
                          org!.id,
                          org.password,
                          org.name,
                          org.email,
                          description,
                          org.logoUrl,
                          [],
                          org.favorites,
                          [],
                          org.calendarLink,
                          org.contact,
                          org.isActive,
                          org.eventHappeningNow,
                          org.backgroundUrl,
                          [],
                          org.location,
                          selectedTags,
                          org.workingHoursPerWeek);
                    } else {
                      studentRepository.editStudent(
                          student!.id,
                          student.password,
                          student.firstName,
                          student.lastName,
                          student.email,
                          student.profilePicPath,
                          student.totalVolunteerHours,
                          int.tryParse(hourGoal),
                          selectedTags);
                    }
                    user!.firstTimeLogin = false;
                    context.pushNamed(AppRoute.homeScreen.name);
                  },
                  style: ButtonStyle(
                    //padding: MaterialStateProperty.all(
                    //const EdgeInsets.symmetric(vertical: 20),
                    //),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.black54)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 91, 78, 119)),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Text(
                'Be sure to go to your profile by tapping the icon in the top right or going to the account screen to edit more information!',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

TextField _buildTextField(
    {String labelText = '',
    bool obscureText = false,
    bool numbersOnly = false,
    TextEditingController? controller}) {
  return TextField(
    keyboardType: numbersOnly ? TextInputType.number : TextInputType.name,
    controller: controller,
    cursorColor: Colors.black54,
    cursorWidth: 1,
    obscureText: obscureText,
    obscuringCharacter: '●',
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 18,
      ),
      fillColor: Colors.red,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black54,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black54,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    ),
  );
}

class ChooseTags extends StatefulWidget {
  final String tag;

  const ChooseTags({super.key, required this.tag});

  @override
  State<ChooseTags> createState() => _ChooseTagsState();
}

class _ChooseTagsState extends State<ChooseTags> {
  late final String tag;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    tag = widget.tag;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ActionChip(
      backgroundColor: (selected
          ? const Color.fromARGB(255, 91, 78, 119)
          : Colors.grey[300]),
      label: Text(
        tag,
        style: TextStyle(color: (selected ? Colors.white : Colors.black)),
      ),
      onPressed: () {
        setState(() {
          selected = !selected;
          if (selected) {
            if (selectedTags.length < 10) {
              selectedTags.add(tag);
            } else {
              selected = false;
            }
          } else {
            selectedTags.remove(tag);
          }
        });
      },
    );
  }
}
