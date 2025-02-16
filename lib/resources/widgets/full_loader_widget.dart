import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading...", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}




class DownloadProgressDialog extends StatefulWidget {
  final int initialProgress;

  DownloadProgressDialog({required this.initialProgress});

  @override
  _DownloadProgressDialogState createState() => _DownloadProgressDialogState();

  static void show(BuildContext context, int progress) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DownloadProgressDialog(initialProgress: progress);
      },
    );
  }

  static void update(BuildContext context, int progress) {
    final _DownloadProgressDialogState? state =
        context.findAncestorStateOfType<_DownloadProgressDialogState>();
    state?.updateProgress(progress);
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  late int progress;

  @override
  void initState() {
    super.initState();
    progress = widget.initialProgress;
  }

  void updateProgress(int newProgress) {
    setState(() {
      progress = newProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(width: 20),
            Text("Downloading... $progress%", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}