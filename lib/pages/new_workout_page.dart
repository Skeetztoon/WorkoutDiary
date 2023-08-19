import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app_flutter/cards/exercise_card.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class NewWorkout extends StatefulWidget {
  const NewWorkout({super.key});

  @override
  State<NewWorkout> createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> with TickerProviderStateMixin {

  final List exerciseCounter = [1];                  // List for creating exercises
  List<String> dropdownValues = [''];             // List for storing values of exercises

  ScrollController controller = new ScrollController(); // Animation scroll on adding new exercises

  bool isFinished = false;

  final stopwatch = Stopwatch();
  late Timer timer;
  String elapsedTime = '00:00:00';


  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        elapsedTime =
        '${(stopwatch.elapsed.inHours).toString().padLeft(2, '0')}:'
            '${(stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:'
            '${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
    stopwatch.start();

    return WillPopScope(
      onWillPop: () async {

        final result = await showDialog(
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xff282828),
            title: const Text('Are you sure?', style: TextStyle(color: Colors.white)),
            content: const Text('All progress will be lost', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ), context: context,
        );
        return result;
      },
      child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.9,
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
                  Text(
                    elapsedTime,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        controller: controller,
                        itemCount: exerciseCounter.length,
                        itemBuilder: (context, index) {
                          final item = exerciseCounter[index];
                          return Dismissible(
                              key: Key(item.toString()),
                              onDismissed: (direction) {
                                setState(() {
                                  exerciseCounter.removeAt(index);
                                });
                              },
                              background: Container(color: Colors.red),
                              child: ExerciseCard(
                                dropdownValues: dropdownValues,
                                index: index,
                              ));
                        }),
                  ),

                  const SizedBox(height: 20,),

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
                          controller.jumpTo(controller.position.maxScrollExtent); // Scroll to last item
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
                        buttonWidget: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        ),
                        isFinished: isFinished,
                        onWaitingProcess: () {
                          String dateStr =
                              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

                          timer.cancel();
                          stopwatch.stop(); // Секундомер
                          List<String> filteredDropdownValues = dropdownValues.where((value) => value.isNotEmpty).toList();

                          CollectionReference myWorkouts =
                          FirebaseFirestore.instance.collection('MyWorkouts');
                          myWorkouts.add({
                            'Date': dateStr,
                            'Timer': elapsedTime,
                            'Exercises': filteredDropdownValues
                          });

                          setState(() {
                            isFinished = true;
                          });
                        },
                        onFinish: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );

  }
}