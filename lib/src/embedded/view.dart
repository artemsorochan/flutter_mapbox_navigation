import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import '../models/models.dart';

/// Callback method for when the navigation view is ready to be used.
///
/// Pass to [MapBoxNavigationView.onMapCreated] to receive a [MapBoxNavigationViewController] when the
/// map is created.
typedef void OnNavigationViewCreatedCallBack(
    MapBoxNavigationViewController controller);

///Embeddable Navigation View.
class MapBoxNavigationView extends StatelessWidget {
  final MapBoxOptions? options;
  final OnNavigationViewCreatedCallBack? onCreated;
  final ValueSetter<RouteEvent>? onRouteEvent;

  MapBoxNavigationView(
      {Key? key, this.options, this.onCreated, this.onRouteEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'FlutterMapboxNavigationView',
        layoutDirection: TextDirection.ltr,
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: options!.toMap(),
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isIOS) {
      return UiKitView(
          viewType: 'FlutterMapboxNavigationView',
          layoutDirection: TextDirection.ltr,
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: options!.toMap(),
          creationParamsCodec: const StandardMessageCodec());
    } else
      throw UnsupportedError('Unsupported platform view');
  }

  void _onPlatformViewCreated(int id) {
    if (onCreated == null) {
      return;
    }
    onCreated!(MapBoxNavigationViewController(id, onRouteEvent));
  }
}
