// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/digital_clock.dart';
import 'src/vos/time_segment_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
      MaterialApp(
      home: Material(
          child: Scaffold(
            body: ChangeNotifierProvider(
              create: (context) => TimeModel(),
              child: DigitalSandClock()
            ),
          )
      ),
      theme: ThemeData()
  ));
}