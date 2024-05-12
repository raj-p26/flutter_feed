import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String articleUrl;
  const NewsCard(
      {super.key,
      required this.title,
      this.imageUrl,
      required this.articleUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3.0,
        child: InkWell(
            onTap: _launchUrl,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  if (imageUrl != null)
                    Image.network(imageUrl!)
                  else
                    Image.asset('assets/images/no_image.png'),
                  const SizedBox(height: 10),
                  Text(title),
                ],
              ),
            )));
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(articleUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $articleUrl';
    }
  }
}
