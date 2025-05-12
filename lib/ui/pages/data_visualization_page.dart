part of carp_study_app;

// todo change text for survey progress
class DataVisualizationPage extends StatefulWidget {
  static const String route = '/data';
  final DataVisualizationPageViewModel model;
  const DataVisualizationPage(this.model, {super.key});

  @override
  State<DataVisualizationPage> createState() => _DataVisualizationPageState();
}

class _DataVisualizationPageState extends State<DataVisualizationPage> {
  @override
  Widget build(BuildContext context) {
    RPLocalizations locale = RPLocalizations.of(context)!;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CarpAppBar(hasProfileIcon: true),
            ),
            Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${locale.translate('pages.data_viz.hello')} ${bloc.friendlyUsername}'
                            .toUpperCase(),
                        style: dataCardTitleStyle.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      Text(locale.translate('pages.data_viz.thanks'),
                          style: aboutCardSubtitleStyle),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _dataVizCards,
                ),
              ),
            )
          ],
        )));
  }

  // The list of cards, depending on what measures are defined in the study.
  List<Widget> get _dataVizCards {
    final List<Widget> widgets = [];

    // Show user task progress, if study has any tasks.
    if (bloc.hasUserTasks()) {
      widgets.add(
          StudyProgressCardWidget(widget.model.studyProgressCardDataModel));
    }

    // Show HR if there is a POLAR or MOVESENSE device in the study
    if (bloc.hasMeasure(PolarSamplingPackage.HR)) {
      widgets.add(
          HeartRateOuterStatefulWidget(widget.model.heartRateCardDataModel));
    }

    // check to show surveys stats
    if (bloc.hasUserTasks()) {
      widgets.add(SurveyCard(widget.model.surveysCardDataModel));
    }

    List<TaskCardViewModel> mediaModelsList = [];

    // check what media types are in the study and add them to de media card
    if (bloc.hasMeasure(MediaSamplingPackage.AUDIO)) {
      mediaModelsList.add(widget.model.audioCardDataModel);
    }
    if (bloc.hasMeasure(MediaSamplingPackage.VIDEO)) {
      mediaModelsList.add(widget.model.videoCardDataModel);
    }
    if (bloc.hasMeasure(MediaSamplingPackage.IMAGE)) {
      mediaModelsList.add(widget.model.imageCardDataModel);
    }
    if (mediaModelsList.isNotEmpty) {
      widgets.add(MediaCardWidget(mediaModelsList));
    }

    if (bloc.hasMeasure(SensorSamplingPackage.STEP_COUNT)) {
      widgets.add(StepsCardWidget(widget.model.stepsCardDataModel));
    }
    if (bloc.hasMeasure(ContextSamplingPackage.ACTIVITY)) {
      widgets.add(ActivityCard(widget.model.activityCardDataModel));
    }
    if (bloc.hasMeasure(ContextSamplingPackage.MOBILITY)) {
      widgets.add(MobilityCard(widget.model.mobilityCardDataModel));
      widgets.add(DistanceCard(widget.model.mobilityCardDataModel));
    }

    return widgets.toSet().toList();
  }
}
