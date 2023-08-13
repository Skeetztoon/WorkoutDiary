import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_app_flutter/cards/exercise_card.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class NewWorkout extends StatefulWidget {
  const NewWorkout({super.key});

  @override
  State<NewWorkout> createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int exercises = 2;

  final List exerciseCounter = [
    1,
  ];

  List<String> dropdownValues = [''];

  ScrollController controller = new ScrollController();

  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.95,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              border: Border.all(width: 10, color: const Color(0xFF3b3b3b)),
              color: const Color(0xff282828),
            ),
            child: Column(
              children: [
                const Text(
                  "NEW WORKOUT",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 450),
                  child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      controller: controller,
                      itemCount: exerciseCounter.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExerciseCard(
                          dropdownValues: dropdownValues,
                          index: index,
                        );
                      }),
                ),
                FloatingActionButton.extended(
                  //                       КНОПКА
                  label: const Text(
                    'ADD',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  backgroundColor: Colors.pink,
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    color: Colors.black87,
                    size: 24.0,
                  ),
                  onPressed: () {
                    setState(() {
                      exerciseCounter
                          .add(exerciseCounter[exerciseCounter.length - 1] + 1);
                      Timer(const Duration(milliseconds: 100), () {
                        controller.jumpTo(controller.position.maxScrollExtent);
                      });
                      dropdownValues.add("");
                    });
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SwipeableButtonView(
                      activeColor: Colors.pink,
                      buttonText: "FINISH",
                      buttonWidget: Container(
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      isFinished: isFinished,
                      onWaitingProcess: () {
                        Future.delayed(Duration(seconds: 2), () {
                          setState(() {
                            isFinished = true;
                          });
                        });
                      },
                      onFinish: () {
                        Navigator.pop(context);
                        print("################### LIST ################### $dropdownValues");
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

