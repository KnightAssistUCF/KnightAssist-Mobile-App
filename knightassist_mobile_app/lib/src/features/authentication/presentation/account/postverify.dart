import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
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

class PostVerify extends ConsumerWidget {
  const PostVerify({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final user = authRepository.currentUser;
    bool isOrg = user?.role == 'organization';
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);

    StudentUser? student = null;

    organizationsRepository.fetchOrganizationsList();
    final org = organizationsRepository.getOrganization(user?.id ?? '');

    final studentRepository = ref.watch(studentsRepositoryProvider);
    if (user?.role == 'student') {
      studentRepository.fetchStudent(user!.id);
      student = studentRepository.getStudent();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Questions'),
      ),
      body: ListView(
        children: [
          const Image(
            image: AssetImage('assets/KnightAssistCoA3.png'),
            height: 60,
            alignment: Alignment.center,
          ),
          isOrg? const SizedBox(height: 0) : const Text(
            'What is your semester volunteer hour goal?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          isOrg? const SizedBox(height: 0) : _buildTextField(labelText: 'Semester Goal'),
          Text(
            isOrg? 'Select up to 10 tags for your organization.' : 'What are your interests? Select up to 10 below:',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            isOrg? 'This helps connect interested volunteers to your organization by suggesting them recommendations.' : 'This helps connect you to relevant organizations and events.',
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: BuildTextButton(),
          ),
        ],
      ),
    );
  }
}

class BuildTextButton extends StatelessWidget {
  const BuildTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // TODO: add api call here
      onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Interests updated'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              )),
      style: ButtonStyle(
        //padding: MaterialStateProperty.all(
        //const EdgeInsets.symmetric(vertical: 20),
        //),
        side:
            MaterialStateProperty.all(const BorderSide(color: Colors.black54)),
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 91, 78, 119)),
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

TextField _buildTextField({String labelText = '', bool obscureText = false}) {
  return TextField(
    keyboardType: TextInputType.number,
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
