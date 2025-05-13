part of '../main.dart';

final surveys = _Surveys();

class _Surveys {

  final Survey _demographics = _DemographicSurvey();
  Survey get demographics => _demographics;

  final Survey _morning = _MorningSurvey();
  Survey get morning => _morning;

  final Survey _evening = _EveningSurvey();
  Survey get evening => _evening;

  final Survey _postWorkout = _PostWorkoutSurvey();
  Survey get postWorkout => _postWorkout;

  final Survey _morningHeartRate = _MorningHeartRateMeasurement();
  Survey get morningHeartRate => _morningHeartRate;

  final Survey _postWorkoutHeartRate = _PostWorkoutHeartRateMeasurement();
  Survey get postWorkoutHeartRate => _postWorkoutHeartRate;

  final Survey _preWorkoutHeartRate = _PreWorkoutHeartRateMeasurement();
  Survey get preWorkoutHeartRate => _preWorkoutHeartRate;

  final Survey _workoutHeartRate = _WorkoutHeartRateMeasurement();
  Survey get workoutHeartRate => _workoutHeartRate;
}

/// An interface for an survey from the RP package.
abstract class Survey {
  /// The title of this survey.
  String get title;

  /// A short description (one line) of this survey
  String get description;

  /// How many minutes will it take to do this survey?
  int get minutesToComplete;

  /// The survey to fill out.
  RPTask get survey;
}

class _DemographicSurvey implements Survey {
  @override
  String get title => "Demographics";
  @override
  String get description => "A short survey on your background.";
  @override
  int get minutesToComplete => 2;

  final RPChoiceAnswerFormat _sexChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
      RPChoice(text: "Female", value: 1),
      RPChoice(text: "Male", value: 2),
      RPChoice(text: "Other", value: 3, isFreeText: true),
      RPChoice(text: "Prefer not to say", value: 4),
      ]);


  final RPIntegerAnswerFormat _ageChoices = RPIntegerAnswerFormat(
    minValue: 0,
    maxValue: 45,
    suffix: "years"
);

  // Height
  final RPIntegerAnswerFormat _heightChoices = RPIntegerAnswerFormat(
    minValue: 0,
    maxValue: 300,
    suffix: "cm",
  );
  // Weight
  final RPIntegerAnswerFormat _weightChoices = RPIntegerAnswerFormat(
    minValue: 0,
    maxValue: 300,
    suffix: "kg",
  );

  // Occupation
  final RPChoiceAnswerFormat _occupationChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Student", value: 1),
        RPChoice(text: "Employed", value: 2),
        RPChoice(text: "Unemployed", value: 3),
        RPChoice(text: "Retired", value: 4),
        RPChoice(text: "Other", value: 5, isFreeText: true),
        RPChoice(text: "Prefer not to say", value: 6),

      ]);

  // Fitness level (workout frequency)
  final RPChoiceAnswerFormat _fitnessChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Sedentary (little or no exercise)", value: 1),
        RPChoice(text: "Lightly active (light exercise/sports 1-3 days/week)",
            value: 2),
        RPChoice(text: "Moderately active (moderate exercise/sports 3-5 days/week)",
            value: 3),
        RPChoice(text: "Very active (hard exercise/sports 6-7 days a week)",
            value: 4),
        RPChoice(text: "Super active (very hard exercise/sports & physical job)",
            value: 5),
      ]);

  // Common types of exercise
  final RPChoiceAnswerFormat _exerciseChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "Running", value: 1),
        RPChoice(text: "Cycling", value: 2),
        RPChoice(text: "Swimming", value: 3),
        RPChoice(text: "Weightlifting", value: 4),
        RPChoice(text: "Yoga", value: 5),
        RPChoice(text: "Other", value: 6, isFreeText: true),
      ]);

  // Alcohol consumption frequency
  final RPChoiceAnswerFormat _alcoholChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Never", value: 1),
        RPChoice(text: "Rarely (1-2 times a month)", value: 2),
        RPChoice(text: "Occasionally (1-2 times a week)", value: 3),
        RPChoice(text: "Frequently (3-4 times a week)", value: 4),
        RPChoice(text: "Daily", value: 5),
      ]);


  // Medical conditions that may affect the results of the survey
  final RPChoiceAnswerFormat _medicalChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.MultipleChoice,
      choices: [
        RPChoice(text: "None", value: 1),
        RPChoice(text: "Diabetes", value: 2),
        RPChoice(text: "Hypertension", value: 3),
        RPChoice(text: "Heart disease", value: 4),
        RPChoice(text: "Respiratory disease", value: 5),
        RPChoice(text: "Neurological disorder", value: 6),
        RPChoice(text: "Other", value: 7, isFreeText: true),
      ]);

  // Smoke frequency
  final RPChoiceAnswerFormat _smokeChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Never", value: 1),
        RPChoice(text: "Occasionally (1-2 times a month)", value: 2),
        RPChoice(text: "Regularly (1-2 times a week)", value: 3),
        RPChoice(text: "Frequently (3-4 times a week)", value: 4),
        RPChoice(text: "Daily", value: 5),
      ]);


  @override
  RPTask get survey => RPOrderedTask(
        identifier: "demographics_survey",
        steps: [
          RPQuestionStep(
            identifier: "demo_1",
            title: "Which is your biological sex?",
            answerFormat: _sexChoices,
          ),
          RPQuestionStep(
            identifier: "demo_2",
            title: "How old are you?",
            answerFormat: _ageChoices,
          ),
          RPQuestionStep(
            identifier: "demo_3",
            title: "What is your height?",
            answerFormat: _heightChoices,
          ),
          RPQuestionStep(
            identifier: "demo_4",
            title: "What is your weight?",
            answerFormat: _weightChoices,
          ),
          RPQuestionStep(
            identifier: "demo_5",
            title: "What is your occupation?",
            answerFormat: _occupationChoices,
          ),
          RPQuestionStep(
            identifier: "demo_6",
            title: "How often do you exercise?",
            answerFormat: _fitnessChoices,
          ),
          RPQuestionStep(
            identifier: "demo_7",
            title: "What types of exercise do you do?",
            answerFormat: _exerciseChoices,
          ),
          RPQuestionStep(
            identifier: "demo_8",
            title: "How often do you consume alcohol?",
            answerFormat: _alcoholChoices,
          ),
          RPQuestionStep(
            identifier: "demo_9",
            title: "Do you have any of the following medical conditions?",
            answerFormat: _medicalChoices,
          ),
          RPQuestionStep(
            identifier: "demo_10",
            title: "How often do you smoke?",
            answerFormat: _smokeChoices,
          ),
        ],
      );
}

class _MorningSurvey implements Survey {
  @override
  String get title => "Morning Survey";
  @override
  String get description => "Complete this survey when you wake up.";
  @override
  int get minutesToComplete => 2;

  final RPChoiceAnswerFormat _scaleChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: [
      RPChoice(text: "Very poor", value: 1),
      RPChoice(text: "Poor", value: 2),
      RPChoice(text: "Fair", value: 3),
      RPChoice(text: "Good", value: 4),
      RPChoice(text: "Very good", value: 5),
    ],
  );

  final RPChoiceAnswerFormat _moodChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: [
      RPChoice(text: "Very bad", value: 1),
      RPChoice(text: "Bad", value: 2),
      RPChoice(text: "Neutral", value: 3),
      RPChoice(text: "Good", value: 4),
      RPChoice(text: "Very good", value: 5),
    ],
  );

  final RPChoiceAnswerFormat _stressChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: [
      RPChoice(text: "Very low", value: 1),
      RPChoice(text: "Low", value: 2),
      RPChoice(text: "Moderate", value: 3),
      RPChoice(text: "High", value: 4),
      RPChoice(text: "Very high", value: 5),
    ],
  );

  final RPIntegerAnswerFormat _sleepHoursFormat = RPIntegerAnswerFormat(
    minValue: 0,
    maxValue: 24,
    suffix: "hours",
  );

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "morning_survey",
        steps: [
          RPInstructionStep(
            identifier: 'morning_instruction',
            title: "Morning Survey",
            text:
                "Please answer the following questions about your sleep and how you feel this morning.",
          ),
          RPQuestionStep(
            identifier: "morning_sleep_duration",
            title: "How many hours did you sleep last night?",
            answerFormat: _sleepHoursFormat,
          ),
          RPQuestionStep(
            identifier: "morning_sleep_quality",
            title: "How would you rate your sleep quality?",
            answerFormat: _scaleChoices,
          ),
          RPQuestionStep(
            identifier: "morning_mood",
            title: "How do you feel this morning?",
            answerFormat: _moodChoices,
          ),
          RPQuestionStep(
            identifier: "morning_stress",
            title: "What is your current stress level?",
            answerFormat: _stressChoices,
          ),
          
          RPCompletionStep(
            identifier: 'morning_completion',
            title: 'Finished',
            text: 'Thank you for completing the survey! \n\nPlease proceed to complete the morning heart rate measurement',
          ),
        ],
      );
}

class _EveningSurvey implements Survey {
  @override
  String get title => "Evening Survey";
  @override
  String get description => "Complete this survey before going to bed.";
  @override
  int get minutesToComplete => 1;

  final RPChoiceAnswerFormat _eveningChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Very bad", value: 1),
        RPChoice(text: "Bad", value: 2),
        RPChoice(text: "Neutral", value: 3),
        RPChoice(text: "Good", value: 4),
        RPChoice(text: "Very good", value: 5),
      ]);

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "evening_survey",
        steps: [
          RPInstructionStep(
              identifier: 'evening_instruction',
              title: "Evening Survey",
              text:
                  "In the following page, please answer the questions based on how you feel this evening. "
                  "Please sit down comfortably and relax. Remember that there are no right or wrong answers."),
          RPQuestionStep(
            identifier: "evening_fatigue",
            title: "What is your current level of fatigue?",
            answerFormat: _eveningChoices,
          ),
          RPQuestionStep(
            identifier: "evening_mood",
            title: "What is your current mood level?",
            answerFormat: _eveningChoices,
          ),
          RPQuestionStep(
            identifier: "evening_context_stress",
            title: "What is your current level of stress?",
            answerFormat: _eveningChoices,
          ),
          RPQuestionStep(
            identifier: "evening_context_recovery",
            title: "How well do you feel you have recovered today?",
            answerFormat: _eveningChoices,
          ),
          RPCompletionStep(
              identifier: 'evening_completion',
              title: 'Finished',
              text: 'Thank you for taking the tests'),
        ],
      );
}

class _PostWorkoutSurvey implements Survey {
  @override
  String get title => "Post Workout Survey";
  @override
  String get description => "Complete this survey after your workout.";
  @override
  int get minutesToComplete => 1;

  // Perceived exertion scale (1-5)
  final RPChoiceAnswerFormat _exertionChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: [
      RPChoice(text: "Very low", value: 1),
      RPChoice(text: "Low", value: 2),
      RPChoice(text: "Moderate", value: 3),
      RPChoice(text: "High", value: 4),
      RPChoice(text: "Very high", value: 5),
    ],
  );

  // type of workout
  final RPChoiceAnswerFormat _workoutTypeChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Cardio", value: 1),
        RPChoice(text: "Strength training", value: 2),
        RPChoice(text: "Flexibility", value: 3),
        RPChoice(text: "Balance", value: 4),
        RPChoice(text: "Other", value: 5),
      ]);

  // intensity of workout
  final RPChoiceAnswerFormat _intensityChoices = RPChoiceAnswerFormat(
      answerStyle: RPChoiceAnswerStyle.SingleChoice,
      choices: [
        RPChoice(text: "Very low", value: 1),
        RPChoice(text: "Low", value: 2),
        RPChoice(text: "Moderate", value: 3),
        RPChoice(text: "High", value: 4),
        RPChoice(text: "Very high", value: 5),
      ]);

  // duration of workout in ranges
  final RPChoiceAnswerFormat _durationChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: [
      RPChoice(text: "Less than 15 minutes", value: 1),
      RPChoice(text: "15-30 minutes", value: 2),
      RPChoice(text: "30-45 minutes", value: 3),
      RPChoice(text: "45-60 minutes", value: 4),
      RPChoice(text: "More than 60 minutes", value: 5),
    ],
  );

  // emotional state after workout with emotions scale
  final RPChoiceAnswerFormat _emotionalStateChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.MultipleChoice,
    choices: [
      RPChoice(text: "Happy", value: 1),
      RPChoice(text: "Sad", value: 2),
      RPChoice(text: "Angry", value: 3),
      RPChoice(text: "Relaxed", value: 4),
      RPChoice(text: "Stressed", value: 5),
      RPChoice(text: "Excited", value: 6),
    ],
  );

  // fatigue after workout
  final RPChoiceAnswerFormat _fatigueAfterChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: [
      RPChoice(text: "Very low", value: 1),
      RPChoice(text: "Low", value: 2),
      RPChoice(text: "Moderate", value: 3),
      RPChoice(text: "High", value: 4),
      RPChoice(text: "Very high", value: 5),
    ],
  );

  // energy level after workout
  final RPChoiceAnswerFormat _energyAfterChoices = RPChoiceAnswerFormat(
    answerStyle: RPChoiceAnswerStyle.SingleChoice,
    choices: [
      RPChoice(text: "Very low", value: 1),
      RPChoice(text: "Low", value: 2),
      RPChoice(text: "Moderate", value: 3),
      RPChoice(text: "High", value: 4),
      RPChoice(text: "Very high", value: 5),
    ],
  );

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "post_workout_survey",
        steps: [
          RPInstructionStep(
            identifier: 'post_workout_instruction',
            title: "Post Workout Survey",
            text:
                "Please answer the following questions about your workout and how you feel after it.",
          ),
          RPQuestionStep(
            identifier: "post_workout_exertion",
            title: "How would you rate your perceived exertion during the workout?",
            answerFormat: _exertionChoices,
          ),
          RPQuestionStep(
            identifier: "post_workout_type",
            title: "What type of workout did you do?",
            answerFormat: _workoutTypeChoices,
          ),
          RPQuestionStep(
            identifier: "post_workout_intensity",
            title: "How would you rate the intensity of your workout?",
            answerFormat: _intensityChoices,
          ),
          RPQuestionStep(
            identifier: "post_workout_duration",
            title: "How long was your workout?",
            answerFormat: _durationChoices,
          ),
          RPQuestionStep(
            identifier: "post_workout_emotional_state",
            title: "How do you feel after the workout?",
            answerFormat: _emotionalStateChoices,
          ),
          RPQuestionStep(
            identifier: "post_workout_fatigue",
            title: "How fatigued do you feel after the workout?",
            answerFormat: _fatigueAfterChoices,
          ),
          RPQuestionStep(
            identifier: "post_workout_energy",
            title: "How energetic do you feel after the workout?",
            answerFormat: _energyAfterChoices,
          ),
          RPCompletionStep(
            identifier: 'post_workout_completion',
            title: 'Finished',
            text: 'Thank you for completing the survey!',
          ),
        ],
      );
}

class _MorningHeartRateMeasurement implements Survey {
  @override
  String get title => "Record Morning Heart Rate";
  @override
  String get description => "Complete this survey when you wake up.";
  @override
  int get minutesToComplete => 3;

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "morning_heart_rate_measurement",
        steps: [
          RPInstructionStep(
            identifier: 'morning_heart_rate_instruction',
            title: "Record Morning Heart Rate",
            text:
                "Please sit down for 3 minutes while we capture your heart rate measurements.",
          ),
          RPTimerStep(
            identifier: 'morning_heart_rate_timer',
            title: "Please sit down for 3 minutes while we capture your heart rate measurements. Taking a morning measurement provides a relevant baseline into understanding your nervous responses.",
            timeout: const Duration(seconds: 30),
            playSound: true,
            autoSkip: true,
          ),
          RPCompletionStep(
            identifier: 'morning_heart_rate_completion',
            title: 'Finished',
            text: 'Thank you for completing the measurement!',
          ),

        ],
      );
}

class _PreWorkoutHeartRateMeasurement implements Survey {
  @override
  String get title => "Record Pre Workout Heart Rate";
  @override
  String get description => "Complete this task before your workout to measure your heart rate.";
  @override
  int get minutesToComplete => 3;

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "preworkout_heart_rate_measurement",
        steps: [
          RPInstructionStep(
            identifier: 'preworkout_heart_rate_instruction',
            title: "Record Pre Workout Heart Rate",
            text:
                "Please sit down for 3 minutes while we capture your heart rate measurements.",
          ),
          RPTimerStep(
            identifier: 'preworkout_heart_rate_timer',
            title: "Please sit down for 3 minutes while we capture your heart rate measurements. Taking a measurement before your workout provides a relevant baseline into understanding your nervous responses.",
            timeout: const Duration(seconds: 30),
            playSound: true,
            autoSkip: true,
          ),
          RPCompletionStep(
            identifier: 'preworkout_heart_rate_completion',
            title: 'Finished',
            text: 'Thank you for completing the measurement! \n\nPlease proceed to start the workout task and start your workout',
          ),
        ],
      );
}

class _PostWorkoutHeartRateMeasurement implements Survey {
  @override
  String get title => "Record Post Workout Heart Rate";
  @override
  String get description => "Complete this task after your workout to measure your heart rate.";
  @override
  int get minutesToComplete => 3;

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "postworkout_heart_rate_measurement",
        steps: [
          RPInstructionStep(
            identifier: 'postworkout_heart_rate_instruction',
            title: "Record Post Workout Heart Rate",
            text:
                "Please sit down for 3 minutes while we capture your heart rate measurements.",
          ),
          RPTimerStep(
            identifier: 'postworkout_heart_rate_timer',
            title: "Please sit down for 3 minutes while we capture your heart rate measurements. Taking your heart rate after your workout provides a relevant baseline into understanding your nervous responses.",
            timeout: const Duration(seconds: 30),
            playSound: true,
            autoSkip: true,
          ),
          RPCompletionStep(
            identifier: 'postworkout_heart_rate_completion',
            title: 'Finished',
            text: 'Thank you for completing the measurement! \n\nPlease proceed to complete the post workout survey',
          ),
        ],
      );
}

class _WorkoutHeartRateMeasurement implements Survey {
  @override
  String get title => "Record Workout Heart Rate";
  @override
  String get description => "Start this task when you start your workout to measure your heart rate.";
  @override
  int get minutesToComplete => 30;

  @override
  RPTask get survey => RPOrderedTask(
        identifier: "workout_heart_rate_measurement",
        steps: [
          RPInstructionStep(
            identifier: 'workout_heart_rate_instruction',
            title: "Start Workout and Record Heart Rate",
            text:
                "Your workout session just started! When you are done with your workout come back to the app and click Next \n\nPlease remember to wear the heart rate monitor during your workout. \n\nHave a great workout!",
          ),
          RPCompletionStep(
            identifier: 'workout_heart_rate_completion',
            title: 'Finished',
            text: 'Good job on your workout! \n\nPlease proceed to complete the post workout measurement',
          ),
        ],
      );
}