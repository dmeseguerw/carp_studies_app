part of '../main.dart';

final consent = InformedConsent();

class InformedConsent {
  RPOrderedTask? _informedConsent;

  RPOrderedTask get informedConsent {
    if (_informedConsent == null) {
      RPConsentSection overviewSection = RPConsentSection(
          type: RPConsentSectionType.Overview,
          title: "General consent",
          summary: "A brief overview of the study and consent process.",
          content:
              "By agreeing to participate in this study, you acknowledge that you have been informed about the purpose, procedures, and potential risks associated with the research. Your participation is voluntary, and you may choose to withdraw at any time without any penalties. Please read the following sections carefully to understand how your data will be handled and what is expected from you during the study.");

      RPConsentSection privacySection = RPConsentSection(
          type: RPConsentSectionType.Privacy,
          title: "Privacy consent",
          summary: "How your personal data will be handled and protected.",
          content:
              "Your privacy is very important to us. All the data collected during this study will be handled confidentially and used solely for research purposes. Personal information will not be shared with third parties without your explicit consent, unless required by law. We will take all necessary measures to protect your data and ensure that it is stored securely.");

      RPConsentSection dataGatheringSection = RPConsentSection(
          type: RPConsentSectionType.DataGathering,
          title: "Data Gathering consent",
          summary:
              "Information on what data will be collected and its purpose.",
          content:
              "During this study, we will collect data on your Heart Rate Variability (HRV) using wearable devices or mobile sensors. We may also collect basic information such as age, gender, and health status to help analyze the data. The data collected will be used for research purposes only and will not be shared with third parties without your permission. Additionally, you will be asked to answer short questionnaires to provide context for the HRV data. By participating, you consent to the collection of this data.");

      RPConsentSection timeCommitmentSection = RPConsentSection(
          type: RPConsentSectionType.TimeCommitment,
          title: "Time Commitment consent",
          summary: "Overview of the time required for your participation.",
          content:
              "This study will take approximately 5-10 minutes per day over the course of 14 days. You will be asked to wear a device and occasionally fill out short questionnaires.");

      RPConsentSignature signature =
          RPConsentSignature(identifier: "consentSignatureID");

      RPConsentDocument consentDocument = RPConsentDocument(
          title: 'Consent form',
          sections: [
            overviewSection,
            dataGatheringSection,
            privacySection,
            timeCommitmentSection
          ])
        ..addSignature(signature);

      RPConsentReviewStep consentReviewStep = RPConsentReviewStep(
        identifier: "consentreviewstepID",
        consentDocument: consentDocument,
        reasonForConsent: 'By tapping AGREE you can take part in the study',
        text: 'Agreed?',
        title: "Consent Review Step",
      );

      RPVisualConsentStep consentVisualStep = RPVisualConsentStep(
        identifier: "visualStep",
        consentDocument: consentDocument,
      );

      RPInstructionStep intoductionStep = RPInstructionStep(
        identifier: "introductionID",
        title: "Welcome!",
        text:
            "Welcome to the HRV analysis study! We would like to kindly ask you to look over the following terms and information which gives you an introduction to the study. ",
        detailText: 
            "The first set of consent steps will touch on the following topics: General consent, Data Gathering, Privacy, and Time Commitment. You will be asked to review the information and agree to participate in the study. Please read the information carefully before you decide to take part in the study. If you have any questions, please contact us at: \ns194725@dtu.dk or\ns232888@dtu.dk",
        // footnote: "(1) Important footnote",
        imagePath: "assets/images/waving-hand.png",
      );

      RPCompletionStep finalStep = RPCompletionStep(
        identifier: "finalID",
        title: "Thank You!",
        text: "We saved your consent document.",
      );

      _informedConsent = RPOrderedTask(
        identifier: "consentTaskID",
        steps: [
          intoductionStep,
          consentVisualStep,
          consentReviewStep,
          finalStep
        ],
      );
    }

    return _informedConsent!;
  }
}
