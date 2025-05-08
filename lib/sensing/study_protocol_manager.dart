part of '../main.dart';

/// This is a simple local [StudyProtocolManager] which
/// creates the Fitness Recommender Data Collection study protocol.
class LocalStudyProtocolManager implements StudyProtocolManager {
  @override
  Future<void> initialize() async {}

  @override
  Future<SmartphoneStudyProtocol> getStudyProtocol(String studyId) async {
    SmartphoneStudyProtocol protocol = SmartphoneStudyProtocol(
      name: 'Fitness Recommender Data Collection',
      ownerId: 'alex@uni.dk',
    );
    protocol.studyDescription = StudyDescription(
        title: 'Fitness Recommender Data Collection',
        description:
            "With the Fitness Recommender Data Collection you can monitor your fitness health. "
            "By using the phones sensors, including the microphone, it will try to monitor you breathing, heart rate, sleep, social contact to others, and your movement. "
            "You will also be able to fill in a simple daily survey to help us understand how you're doing. "
            "Before you start, please also fill in the demographics survey. ",
        purpose:
            'To collect basic data from users in their everyday life in order '
            'to investigate fitness levels.',
        responsible: StudyResponsible(
          id: 'dmeseguerw',
          title: 'Student',
          email: 's232888@dtu.dk',
          name: 'Daniel Meseguer',
        ));

    // Define the data end point , i.e., where to store data.
    // This example app only stores data locally in a SQLite DB
    protocol.dataEndPoint = SQLiteDataEndPoint();
    
    // Add firebase as a data end point.
    // final FirebaseEndPoint firebaseEndPoint = FirebaseEndPoint(

    // );

    // Define which devices are used for data collection.
    Smartphone phone = Smartphone();
    protocol.addPrimaryDevice(phone);


    // Define the online location service and add it as a 'device'.
    LocationService locationService = LocationService(
      // used for debugging when the phone is laying still on the table
      distance: 0,
    );

    protocol.addConnectedDevice(locationService, phone);

    // ----------------------- Demographics task------------------------
    var demographicsTask = RPAppTask(
      type: SurveyUserTask.SURVEY_TYPE,
      title: surveys.demographics.title,
      description: surveys.demographics.description,
      minutesToComplete: surveys.demographics.minutesToComplete,
      rpTask: surveys.demographics.survey,
      measures: [],
      notification: true,
    );
    protocol.addTaskControl(
      ImmediateTrigger(),
      demographicsTask,
      phone,
    );

    //----------------------- Morning task------------------------
    var morningTask = RPAppTask(
      type: SurveyUserTask.SURVEY_TYPE,
      title: surveys.morning.title,
      description: surveys.morning.description,
      minutesToComplete: surveys.morning.minutesToComplete,
      rpTask: surveys.morning.survey,
      measures: [],
      notification: true,
    );

    protocol.addTaskControl(
      RecurrentScheduledTrigger(
        type: RecurrentType.daily,
        time: const TimeOfDay(hour: 7, minute: 00),
      ),
      morningTask,
      phone,
    );

    //----------------------- Evening task------------------------
    var eveningTask = RPAppTask(
      type: SurveyUserTask.SURVEY_TYPE,
      title: surveys.evening.title,
      description: surveys.evening.description,
      minutesToComplete: surveys.evening.minutesToComplete,
      rpTask: surveys.evening.survey,
      measures: [],
      notification: true,
    );

    protocol.addTaskControl(
      RecurrentScheduledTrigger(
        type: RecurrentType.daily,
        time: const TimeOfDay(hour: 21, minute: 00),
      ),
      eveningTask,
      phone,
    );

    //-----------------------Post workout task------------------------
    var postWorkoutTask = RPAppTask(
      type: SurveyUserTask.SURVEY_TYPE,
      title: surveys.postWorkout.title,
      description: surveys.postWorkout.description,
      minutesToComplete: surveys.postWorkout.minutesToComplete,
      rpTask: surveys.postWorkout.survey,
      measures: [],
      notification: true,
    );

    protocol.addTaskControl(
      NoUserTaskTrigger(taskName: 'Post Workout Survey'),
      postWorkoutTask,
      phone,
    );


    return protocol;
  }

  @override
  Future<bool> saveStudyProtocol(String studyId, StudyProtocol protocol) async {
    throw UnimplementedError();
  }
}
