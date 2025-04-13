import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(double lat, double lng) async {
  final Uri googleMapsUri =
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

  try {
    final bool launched = await launchUrl(
      googleMapsUri,
      mode: LaunchMode.externalApplication, // recommended mode for Google Maps
    );

    if (!launched) {
      throw 'Could not launch Google Maps';
    }
  } catch (e) {
    debugPrint("Launch failed: $e");

    // ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    //   const SnackBar(content: Text('Could not open Google Maps')),
    // );
  }
}

Future<void> launchWhatsApp(String phone) async {
  final Uri whatsappUrl = Uri.parse("https://wa.me/$phone");
  if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
    throw Exception("Could not launch WhatsApp");
  }
}

Future<void> launchCall(String phone) async {
  final Uri callUri = Uri(scheme: "tel", path: phone);
  if (!await launchUrl(callUri, mode: LaunchMode.externalApplication)) {
    throw Exception("Could not make a call");
  }
}
