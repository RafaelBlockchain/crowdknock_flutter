// frontend-admin/lib/widgets/users/user_search_bar.dart

import 'package:flutter/material.dart';

class UserSearchBar extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const UserSearchBar({
    super.key,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Buscar usuario',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClear,
              )
            : null,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      onChanged: onChanged,
      controller: TextEditingController(text: searchQuery),
    );
  }
}

