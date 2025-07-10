import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;
  final bool isActive;

  const NavButton({
    super.key,
    required this.label,
    required this.icon,
    required this.route,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.indigo : Colors.grey[600],
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.indigo : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.indigo.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        } else {
          Navigator.pop(context); // solo cerrar drawer si ya estás en la ruta
        }
      },
    );
  }
}

