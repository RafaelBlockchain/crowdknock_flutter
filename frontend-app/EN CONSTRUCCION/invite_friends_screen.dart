import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriendsScreen extends StatelessWidget {
  final String userId; // ID único del usuario para el link de invitación

  InviteFriendsScreen({super.key, required this.userId});

  final String baseUrl = 'https://tusitio.com/invite';

  String get inviteLink => '$baseUrl?ref=$userId';

  void _shareUniversal(BuildContext context) {
    final mensaje = '¡Únete a esta app genial! 👉 $inviteLink';
    Share.share(mensaje);
  }

  void _shareToWhatsApp(BuildContext context) async {
    final url = 'https://wa.me/?text=${Uri.encodeComponent("Únete a esta app 👉 $inviteLink")}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir WhatsApp')),
      );
    }
  }

  void _shareToFacebook(BuildContext context) async {
    final url = 'https://www.facebook.com/sharer/sharer.php?u=$inviteLink';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir Facebook')),
      );
    }
  }

  void _copyLink(BuildContext context) {
    Share.share(inviteLink); // Alternativa: usar Flutter Clipboard para copiar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Enlace copiado al portapapeles!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invita a tus amigos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Invita a tus amigos y gana recompensas 🎉',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.whatsapp, color: Colors.green),
              title: const Text('Invitar por WhatsApp'),
              onTap: () => _shareToWhatsApp(context),
            ),
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue),
              title: const Text('Compartir en Facebook'),
              onTap: () => _shareToFacebook(context),
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copiar enlace'),
              onTap: () => _copyLink(context),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Más opciones...'),
              onTap: () => _shareUniversal(context),
            ),
          ],
        ),
      ),
    );
  }
}
