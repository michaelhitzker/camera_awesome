import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';

class AwesomeAspectRatioButton extends StatelessWidget {
  final CameraState state;

  const AwesomeAspectRatioButton({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SensorConfig>(
      stream: state.sensorConfig$,
      builder: (_, sensorConfigSnapshot) {
        if (!sensorConfigSnapshot.hasData) {
          return SizedBox();
        }
        final sensorConfig = sensorConfigSnapshot.requireData;
        return StreamBuilder<CameraAspectRatios>(
          stream: sensorConfig.aspectRatio$,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return _AspectRatioButton.from(
              aspectRatio: snapshot.requireData,
              onTap: () => sensorConfig.switchCameraRatio(),
            );
          },
        );
      },
    );
  }
}

class _AspectRatioButton extends StatelessWidget {
  final VoidCallback onTap;
  final AssetImage icon;
  final double width;

  const _AspectRatioButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.width,
  });

  factory _AspectRatioButton.from({
    Key? key,
    required CameraAspectRatios aspectRatio,
    required VoidCallback onTap,
  }) {
    final AssetImage icon;
    double width;
    switch (aspectRatio) {
      case CameraAspectRatios.ratio_16_9:
        width = 32;
        icon = AssetImage("packages/camerawesome/assets/icons/16_9.png");
        break;
      case CameraAspectRatios.ratio_4_3:
        width = 24;
        icon = AssetImage("packages/camerawesome/assets/icons/4_3.png");
        break;
      case CameraAspectRatios.ratio_1_1:
        width = 24;
        icon = AssetImage("packages/camerawesome/assets/icons/1_1.png");
        break;
    }
    return _AspectRatioButton(
      key: key,
      onTap: onTap,
      icon: icon,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeOrientedWidget(
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          onPressed: onTap,
          icon: Center(
            child: Image(
              image: icon,
              width: width,
            ),
          ),
        ),
      ),
    );
  }
}
