import 'package:flutter/material.dart';
import 'package:ds_hrm/ui/shared/app_colors.dart';
import 'package:ds_hrm/ui/shared/ui_helpers.dart';

class PushNotification {
  late BuildContext context;
  late OverlayEntry _overlayEntry;

  PushNotification(this.context);

  static PushNotification of(BuildContext context) {
    return PushNotification(context);
  }

  Future<void> show(NotificationContent content) async {
    _overlayEntry = OverlayEntry(builder: (context) {
      return PushWidget(
        content: content,
        callback: () {
          _overlayEntry.remove();
        },
      );
    });

    Overlay.of(context)!.insert(_overlayEntry);
  }
}

class PushWidget extends StatefulWidget {
  final NotificationContent content;
  final VoidCallback callback;

  PushWidget({required this.content, required this.callback});

  @override
  _PushWidgetState createState() => _PushWidgetState();
}

class _PushWidgetState extends State<PushWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late MediaQueryData _mq;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    _startAnim();

    super.initState();
  }

  Future<void> _startAnim() async {
    await _controller.forward();
    await Future.delayed(Duration(seconds: 2));
    await _controller.reverse();
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    _mq = MediaQuery.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Animation curvedAnim = CurvedAnimation(
            parent: _controller, curve: Curves.fastLinearToSlowEaseIn);

        return Positioned(
            top: Tween<double>(begin: -100, end: _mq.padding.top)
                .animate(curvedAnim.value)
                .value,
            left: 0,
            right: 0,
            child: Transform.scale(
                scale:
                    Tween<double>(begin: 0.8, end: 1).animate(curvedAnim.value).value,
                child: child));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 1,
          color:
              widget.content.isError ? kErrorRed :kBgDark,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(
                  widget.content.isError
                      ? Icons.error_outline
                      : Icons.check_circle_outline,
                  color: kcPrimaryColor,
                ),
                verticalSpaceMedium,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.content.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: kAltWhite, fontSize: 15),
                      ),
                      (widget.content.body == null ||
                              widget.content.body.isEmpty)
                          ? Container(
                              width: 0,
                            )
                          : Text(
                              widget.content.body,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: kcPrimaryColor),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationContent {
  String title, body;
  bool isError;

  NotificationContent({required this.title, required this.body, required this.isError});
}
