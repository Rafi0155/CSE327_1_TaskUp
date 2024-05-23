import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown_menu.dart';

import 'assignee.dart';

// class Assignee {
//   final String name;
//
//   Assignee(this.name);
// }

class AssigneeDropdownMenu extends StatelessWidget {
  final Assignee? initialSelection;
  final List<Assignee> assignees;
  final Function(Assignee?) onSelected;
  final Function() onAddAssignee;

  const AssigneeDropdownMenu({
    Key? key,
    required this.initialSelection,
    required this.assignees,
    required this.onSelected,
    required this.onAddAssignee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Assignee>(
      initialSelection: initialSelection,
      label: Text('Assignee'), // Providing a label
      dropdownMenuEntries: [
        DropdownMenuEntry<Assignee>(
          value: assignees.first,
          label: 'Add Assignee',
        ),
        ...assignees.map((assignee) => DropdownMenuEntry<Assignee>(
          value: assignee,
          label: assignee.name,
        ))
      ],
      onSelected: onSelected,
      trailingIcon: IconButton(
        icon: Icon(Icons.add),
        onPressed: onAddAssignee,
      ),
    );
  }
}
