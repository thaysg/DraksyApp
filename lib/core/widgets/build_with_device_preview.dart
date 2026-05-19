import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

class BuildWithDevicePreview extends StatelessWidget {
  const BuildWithDevicePreview({super.key});

  @override
  Widget build(BuildContext context) => DevicePreview(
        enabled: true,
        tools: const [...DevicePreview.defaultTools],
        builder: (context) => const AppWidget(),
      );
}
