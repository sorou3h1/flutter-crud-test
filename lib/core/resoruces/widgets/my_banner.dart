import 'dart:async';

import 'package:flutter/material.dart';

class MyBanner extends StatefulWidget {
  const MyBanner({Key? key, 
    required this.content,
    this.autonDismiss = true,
    this.containerDecoration,
    this.onStateBuilt,
    this.dismissAfter = 2000,
  }) : super(key: key);

  final List<Widget> content;
  final bool autonDismiss;
  final BoxDecoration? containerDecoration;
  final Function(BuildContext bannerContext)? onStateBuilt;
  static BuildContext? _context;
  final int dismissAfter;

  @override
  State<MyBanner> createState() => _MyBannerState();

  static void show(
    BuildContext context, {
    MyBanner? configuredBanner,
    List<Widget>? content,
  }) {
    //client has to pass either configuredBanner or content
    if (configuredBanner == null && content == null) {
      throw Exception(
          "configuredBanner and content can not be null at the same time");
    } else if (configuredBanner != null && content != null) {
      throw Exception(
          "can not have content and configuredBanner at the same time");
    }

    //in case configuredBanner is nulll create a new one with the given content
    configuredBanner ??= MyBanner(
      content: content!,
    );

    //dont show two dialog at the same time
    if (_context != null) {
      print("we cant show to dialog at the same time");
      return;
    }

    _context = context;

    showDialog(context: _context!, builder: (context) => configuredBanner!);
  }

  static void dismiss() {
    if (_context != null) {
      try {
        Navigator.pop(_context!);
      } catch (e) {
        print("failed to pop:$e");
      }
    }
  }
}

class _MyBannerState extends State<MyBanner> with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> widthFactorAnim;
  late final Animation<double> opacityAnim;

  AnimationController? dismissController;
  Animation<double>? dismissAnim;
  late final Timer dismissTimer;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    widthFactorAnim = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
    opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    //start main animation right after building state
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animationController.forward();
    });

    //setting up autodismiss
    if (widget.autonDismiss) {
      dismissController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );

      dismissController!.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

      dismissAnim = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: dismissController!, curve: Curves.easeIn),
      );

      dismissTimer = Timer(Duration(milliseconds: widget.dismissAfter), () {
        try {
          dismissController?.forward();
          animationController.reverse().then((value) {
            MyBanner.dismiss();
          });
        } catch (e) {
          print("failure in timer");
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    MyBanner._context = context;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onStateBuilt?.call(context);
    });

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: ClipRRect(
          child: Align(
            alignment: Alignment.topCenter,
            widthFactor: widthFactorAnim.value,
            child: Opacity(
              opacity: opacityAnim.value,
              child: Container(
                width: size.width * 0.8,
                constraints: BoxConstraints(
                  minHeight: size.height * 0.1,
                  maxHeight: size.height * 0.4,
                ),
                margin: EdgeInsets.only(top: dismissAnim?.value ?? 50),
                padding: const EdgeInsets.all(10),
                decoration: widget.containerDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                    ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    MyBanner._context = null;
    animationController.dispose();
    dismissController?.dispose();
    super.dispose();
  }
}
