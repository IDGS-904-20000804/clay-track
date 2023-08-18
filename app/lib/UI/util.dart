import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dialogos {
  static AwesomeDialog msgDialog({
    required BuildContext context,
    DialogType dgt = DialogType.success,
    required String texto,
    required Function() onPress,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dgt,
      body: Center(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: '',
      desc: '',
      btnOkOnPress: onPress,
    );
  }

  static AwesomeDialog msgDialogCOpt({
    required BuildContext context,
    DialogType dgt = DialogType.success,
    required String texto,
    String onOkText = 'si',
    required Function() onOkPress,
    String onCancelText = 'Cancelar',
    required Function() onCancelPress,
  }) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: dgt,
      body: Center(
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: '',
      desc: '',
      btnOkText: onOkText,
      btnOkOnPress: onOkPress,
      btnCancelText: onCancelText,
      btnCancelOnPress: onCancelPress,
    );
  }
}

/* Notifiaciones SnacBar */
class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static showSnackBar(
      {required String message, int type = 1, Color color = Colors.black}) {
    final Widget icono;
    switch (type) {
      case 1:
        icono = const Icon(Icons.check, color: Colors.white);
        break;
      case 2:
        icono = const Icon(Icons.wifi_off_outlined, color: Colors.white);
        break;
      default:
        icono = const Icon(Icons.error_outline, color: Colors.white);
    }
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icono,
          const SizedBox(width: 20),
          Expanded(
              child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ))
        ],
      ),
      backgroundColor: color,
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

/** * * toasMessage * - Muestra un mensaje de toast * @param msg : texto del mensaje * @param time : tiempo de duracion * @param delay : tiempo delay en lanzar el mensaje */
  static toasMessage({required String msg, int time = 5, int delay = 1}) {
    Future.delayed(Duration(seconds: delay), () {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        webBgColor: "#e74c3c",
        textColor: Colors.white,
        timeInSecForIosWeb: time,
      );
    });
  }
}
