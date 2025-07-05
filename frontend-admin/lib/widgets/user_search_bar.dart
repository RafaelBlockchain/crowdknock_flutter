import 'package:flutter/material.dart';

class UserSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const UserSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Buscar usuario por nombre o correo',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }
}
