import 'package:flutter/material.dart';
import '../../../data/models/content_model.dart';
import 'content_row_actions.dart';

class ContentTable extends StatelessWidget {
  final List<ContentModel> contentList;
  final void Function(ContentModel) onEdit;
  final void Function(ContentModel) onDelete;

  const ContentTable({
    super.key,
    required this.contentList,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.grey.shade200),
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Título')),
          DataColumn(label: Text('Tipo')),
          DataColumn(label: Text('Estado')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Acciones')),
        ],
        rows: contentList.map((content) {
          return DataRow(cells: [
            DataCell(Text(content.id.toString())),
            DataCell(Text(content.title)),
            DataCell(Text(content.type)),
            DataCell(Text(content.status)),
            DataCell(Text(content.dateCreated.toLocal().toString())),
            DataCell(ContentRowActions(
              content: content,
              onEdit: onEdit,
              onDelete: onDelete,
            )),
          ]);
        }).toList(),
      ),
    );
  }
}

