import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class SemesterGoal extends ConsumerWidget {
  const SemesterGoal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semester Goal'),
      ),
      body: ResponsiveScrollableCard(
        child: SizedBox(
          width: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Image(
                image: AssetImage('assets/KnightAssistCoA3.png'),
                height: 60,
                alignment: Alignment.center,
              ),
              const Text(
                'Please enter your semester volunteer hour goal.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 40,
                indent: 40,
                endIndent: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildTextField(labelText: 'Semester Goal'),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BuildTextButton(),
                    )
                  ],
                ),
              ),
            ],
          ),
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


  class BuildTextButton extends StatelessWidget {
    const BuildTextButton({super.key});

    @override
    Widget build(BuildContext context) {
      return TextButton(
      onPressed: () => showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Semester goal updated'),
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
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 91, 78, 119)),
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