import 'package:url_launcher/url_launcher.dart';

//Esta función muestra un preview de las direcciones URL
launchURL({String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
