import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:research_package/model.dart';
import 'package:test/test.dart';

import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_connectivity_package/connectivity.dart';
import 'package:carp_context_package/carp_context_package.dart';
import 'package:carp_audio_package/media.dart';
import 'package:carp_survey_package/survey.dart';
import 'package:cognition_package/cognition_package.dart';

import 'package:carp_study_app/main.dart';

void main() {
  StudyProtocol? protocol;
  RPOrderedTask consent;

  String toJsonString(Object object) =>
    const JsonEncoder.withIndent(' ').convert(object);

  Future<void> writeToFile(String json, String fileName) async {
    File file = File('assets/carp/$fileName');
    await file.writeAsString(json);
    debugPrint("Done writing '$fileName'");
    }

  // Make sure to initialize CAMS incl. json serialization
  CarpMobileSensing.ensureInitialized();
  CognitionPackage.ensureInitialized();

  setUp(() async {
    // register the different sampling package since we're using measures from them
    SamplingPackageRegistry().register(ConnectivitySamplingPackage());
    SamplingPackageRegistry().register(ContextSamplingPackage());
    SamplingPackageRegistry().register(MediaSamplingPackage());
    SamplingPackageRegistry().register(SurveySamplingPackage());
  });

    
    /// Generates and save the study protocol as json file
    test('protocol -> resources/protocol.json', () async {
      protocol = await LocalStudyProtocolManager().getStudyProtocol('ignored');
      await writeToFile(toJsonString(protocol!), 'resources/protocol.json');
    });

    /// Generates and save the study consent as json file
    test('consent -> resources/consent.json', () async {
      consent = await InformedConsent().getInformedConsent();
      await writeToFile(toJsonString(consent), 'resources/consent.json');
    });
  }
