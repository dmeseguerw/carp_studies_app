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
            'This study is part of a master thesis project at the '
            'Technical University of Denmark (DTU). The goal of this '
            'study is to collect data from users in their everyday life '
            ' regarding their heart rate, physical activity and lifestyle '
            'in order to investigate fitness levels.',
        purpose:
            'To collect basic data from users in their everyday life in order '
            'to investigate fitness levels.',
        responsible: StudyResponsible(
          id: 'msc_thesis_2025_s232888_s194725',
          title: 'Students',
          email: 's232888@dtu.dk / s194725@dtu.dk',
          name: 'Daniel Meseguer / Mattias Tammi',
        ));

    // Define the data end point , i.e., where to store data.
    // This example app only stores data locally in a SQLite DB
    protocol.dataEndPoint = SQLiteDataEndPoint();

    // Define which devices are used for data collection.
    Smartphone phone = Smartphone();
    protocol.addPrimaryDevice(phone);

    // Add polar device
    PolarDevice polar = PolarDevice(roleName: 'Polar HR Sensor');
    protocol.addConnectedDevice(polar, phone);

    //----------------------- Morning task------------------------
    var morningSurveyTask = RPAppTask(
      name: 'morning_survey_task',
      type: SurveyUserTask.SURVEY_TYPE,
      title: surveys.morning.title,
      description: surveys.morning.description,
      minutesToComplete: surveys.morning.minutesToComplete,
      rpTask: surveys.morning.survey,
      measures: [],
      notification: true,
    );
    var morningHeartRateTask = RPAppTask(
        name: 'morning_heart_rate_measurement_task',
        type: SurveyUserTask.SURVEY_TYPE,
        title: surveys.morningHeartRate.title,
        description: surveys.morningHeartRate.description,
        minutesToComplete: surveys.morningHeartRate.minutesToComplete,
        rpTask: surveys.morningHeartRate.survey,
        measures: [
          Measure(type: PolarSamplingPackage.HR)
        ],
        notification: true,
    );
    protocol.addTaskControl(
      RecurrentScheduledTrigger(
        type: RecurrentType.daily,
        time: const TimeOfDay(hour: 6, minute: 00),
        maxNumberOfSampling: 14,
      ),
      morningSurveyTask,
      polar,
    );

    protocol.addTaskControl(
      UserTaskTrigger(taskName: morningSurveyTask.name, triggerCondition: UserTaskState.done),
      morningHeartRateTask,
      phone,
    );

    //----------------------- Evening task------------------------
    var eveningTask = RPAppTask(
      name: 'evening_survey_task',
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
        time: const TimeOfDay(hour: 17, minute: 10),
        maxNumberOfSampling: 14,
      ),
      eveningTask,
      phone,
    );

  //-----------------------Post workout tasks------------------------
    // Pre workout heart rate measurement
    var preWorkoutHeartRateTask = RPAppTask(
      name: 'preworkout_heart_rate_measurement_task',
      type: SurveyUserTask.SURVEY_TYPE,
      title: 'Pre Workout Heart Rate Measurement',
      description: 'Please record your heart rate before the workout',
      minutesToComplete: surveys.preWorkoutHeartRate.minutesToComplete,
      rpTask: surveys.preWorkoutHeartRate.survey,
      measures: [
        Measure(type: PolarSamplingPackage.HR)
      ],
      notification: true,
    );
    protocol.addTaskControl(
      NoUserTaskTrigger(taskName: preWorkoutHeartRateTask.name),
      preWorkoutHeartRateTask,
      polar,
    );


    // Post workout heart rate measurement
    var postWorkoutHeartRateTask = RPAppTask(
      name: 'postworkout_heart_rate_measurement_task',
      type: SurveyUserTask.SURVEY_TYPE,
      title: 'Post Workout Heart Rate Measurement',
      description: 'Please record your heart rate after the workout',
      minutesToComplete: surveys.postWorkoutHeartRate.minutesToComplete,
      rpTask: surveys.postWorkoutHeartRate.survey,
      measures: [
        Measure(type: PolarSamplingPackage.HR)
      ],
      notification: true,
    );
    protocol.addTaskControl(
      UserTaskTrigger(taskName: preWorkoutHeartRateTask.name, triggerCondition: UserTaskState.done),
      postWorkoutHeartRateTask,
      polar,
    );

    // Post workout survey
    var postWorkoutTask = RPAppTask(
      name: 'post_workout_survey_task',
      type: SurveyUserTask.SURVEY_TYPE,
      title: surveys.postWorkout.title,
      description: surveys.postWorkout.description,
      minutesToComplete: surveys.postWorkout.minutesToComplete,
      rpTask: surveys.postWorkout.survey,
      measures: [],
      notification: true,
    );
    protocol.addTaskControl(
      UserTaskTrigger(taskName: postWorkoutHeartRateTask.name, triggerCondition: UserTaskState.done),
      postWorkoutTask,
      phone,
    );


    // ----------------------- Demographics task------------------------
    var demographicsTask = RPAppTask(
      name: 'demographics_survey_task',
      type: SurveyUserTask.SURVEY_TYPE,
      title: surveys.demographics.title,
      description: surveys.demographics.description,
      minutesToComplete: surveys.demographics.minutesToComplete,
      rpTask: surveys.demographics.survey,
      measures: [],
      notification: true,
    );
    protocol.addTaskControl(
      OneTimeTrigger(),
      demographicsTask,
      phone,
    );


    return protocol;
  }

  @override
  Future<bool> saveStudyProtocol(String studyId, StudyProtocol protocol) async {
    throw UnimplementedError();
  }
}
