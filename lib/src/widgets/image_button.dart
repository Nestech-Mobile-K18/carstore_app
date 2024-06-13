import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/src/resources/responsive.dart';

class ImageButton extends StatelessWidget {
  // properties GestureDetector
  final void Function()? onTap;
  final HitTestBehavior? behavior;
  final void Function()? onDoubleTap;
  final DragStartBehavior? dragStartBehavior;
  final void Function()? onDoubleTapCancel;
  final void Function(TapDownDetails)? onDoubleTapDown;
  final void Function(ForcePressDetails)? onForcePressEnd;
  final void Function(ForcePressDetails)? onForcePressPeak;
  // properties Image.assets
  final String imagePath;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  final AssetBundle? bundle;
  final int? cacheHeight;
  final int? cacheWidth;
  final Rect? centerSlice;
  final Color? colorImage;
  final BlendMode? colorBlendMode;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final bool excludeFromSemantics;
  final FilterQuality? filterQuality;
  final double? height;
  final double? width;
  final double? scale;
  final double? marginHorizontalButton;
  final double? marginVerticalButton;
  const ImageButton({
    super.key,
    this.marginHorizontalButton,
    this.marginVerticalButton,
    required this.onTap,
    this.behavior,
    this.onDoubleTap,
    this.dragStartBehavior,
    this.onDoubleTapCancel,
    this.onDoubleTapDown,
    this.onForcePressEnd,
    this.onForcePressPeak,
    required this.imagePath,
    this.fit,
    this.alignment,
    this.bundle,
    this.cacheHeight,
    this.cacheWidth,
    this.centerSlice,
    this.colorImage,
    this.colorBlendMode,
    this.errorBuilder,
    this.excludeFromSemantics = false,
    this.filterQuality,
    this.height,
    this.width,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontalButton ?? 0,
          vertical: marginVerticalButton ?? 0),
      child: GestureDetector(
        onTap: onTap,
        behavior: behavior,
        onDoubleTap: onDoubleTap,
        dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
        onDoubleTapCancel: onDoubleTapCancel,
        onDoubleTapDown: onDoubleTapDown,
        onForcePressEnd: onForcePressEnd,
        onForcePressPeak: onForcePressPeak,
        child: Image.asset(
          imagePath,
          fit: fit ?? BoxFit.cover,
          alignment: alignment ?? Alignment.center,
          bundle: bundle,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
          centerSlice: centerSlice,
          color: colorImage,
          colorBlendMode: colorBlendMode,
          errorBuilder: errorBuilder,
          excludeFromSemantics: excludeFromSemantics,
          filterQuality: filterQuality ?? FilterQuality.medium,
          height: height ?? Responsive.screenHeight(context) * 0.03,
          width: width ?? Responsive.screenHeight(context) * 0.03,
          scale: scale,
        ),
      ),
    );
  }
}
