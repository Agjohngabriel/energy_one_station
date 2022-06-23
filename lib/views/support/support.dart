import 'package:energyone_station/helpers/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/dimension.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);
  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: "2348147657436",
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendMail() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: "agjohngabriel@gmail.com",
    );
    await launchUrl(launchUri);
  }
  Future<void> _sendChat() async {
    final Uri launchUri = Uri(
      scheme: 'https',
      host: "wa.me",
      path: "2348147657436",
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            backgroundColor: AppTheme.white,
            appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              leading: InkWell(
                onTap: () => Get.back(),
                child: const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppTheme.blue,
                  ),
                ),
              ),
              titleSpacing: 0,
              elevation: 0,
              centerTitle: true,
              title: Image.asset('assets/energy_one.png', width: 120),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(25),
                      child: const Text(
                        "Contact us through any of the following channel listed below",
                        textAlign: TextAlign.center,
                      )),
                  InkWell(
                    onTap: ()=> _sendChat(),
                    child: const ListTile(
                      leading: Icon(
                        Icons.whatsapp,
                        color: AppTheme.green,
                      ),
                      title: Text("WhatsApp"),
                      trailing: Icon(
                        Icons.link,
                        color: AppTheme.blue,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () => _sendMail(),
                    child: const ListTile(
                      leading: Icon(
                        Icons.mail_outline,
                        color: AppTheme.blue,
                      ),
                      title: Text("Email"),
                      trailing: Icon(
                        Icons.link,
                        color: AppTheme.blue,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () => _makePhoneCall(),
                    child: const ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: AppTheme.blue,
                      ),
                      title: Text("08147657436"),
                      trailing: Icon(
                        Icons.link,
                        color: AppTheme.blue,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            )));
  }
}
