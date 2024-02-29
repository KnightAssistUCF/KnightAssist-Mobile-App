import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

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

class TagSelection extends ConsumerWidget {
  const TagSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final user = authRepository.currentUser;
    bool isOrg = user?.role == 'organization';
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);

    organizationsRepository.fetchOrganizationsList();
    final org = organizationsRepository.getOrganization(user?.id ?? '');
    selectedTags = org?.categoryTags ?? [];

    if (user?.role == 'student') {
      final studentsRepository = ref.watch(studentsRepositoryProvider);
    final student = studentsRepository.fetchStudent(user!.id);
    selectedTags = studentsRepository.getStudent()!.categoryTags;

    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isOrg ? 'Tags' : 'Interests'),
      ),
      body: ListView(
        children: [
          const Image(
            image: AssetImage('assets/KnightAssistCoA3.png'),
            height: 60,
            alignment: Alignment.center,
          ),
          Text(
            isOrg
                ? 'Select up to 10 tags for your organization below.'
                : 'Select up to 10 of the interests below:',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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

class BuildTextButton extends ConsumerWidget {
  const BuildTextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final user = authRepository.currentUser;
    bool isOrg = user?.role == 'organization';
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);

    organizationsRepository.fetchOrganizationsList();
    final org = organizationsRepository.getOrganization(user?.id ?? '');

    return TextButton(
      onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text(isOrg ? 'Tags updated' : 'Interests updated'),
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

    selected = selectedTags.contains(tag);

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
