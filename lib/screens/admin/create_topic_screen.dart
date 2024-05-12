import 'package:app/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:app/reusable_widgets/reusable_widget.dart';
import 'package:app/utils/color_utils.dart';

class CreateTopicScreen extends StatefulWidget {
  @override
  _CreateTopicScreenState createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  final _topicTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CreateTopicBody(
        topicTextController: _topicTextController,
        descriptionTextController: _descriptionTextController,
      ),
    );
  }
}

class _CreateTopicBody extends StatelessWidget {
  final TextEditingController topicTextController;
  final TextEditingController descriptionTextController;

  const _CreateTopicBody({
    Key? key,
    required this.topicTextController,
    required this.descriptionTextController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).size.height * 0.15,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              reusableTextField(
                "Enter Topic",
                Icons.menu_book_outlined,
                false,
                topicTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(
                "Enter Description",
                Icons.description_outlined,
                false,
                descriptionTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              firebaseUIButton(
                context,
                "Create Topic",
                () async {
                  final Topic topic = Topic(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: topicTextController.text,
                    description: descriptionTextController.text, vocabularies: [],
                  );
                  await topic.save();
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}