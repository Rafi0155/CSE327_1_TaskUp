import 'package:flutter/material.dart';
import 'package:task_up/components/priority_level.dart';

class CustomDropdownMenu extends StatefulWidget {
  final PriorityLevel initialSelection;
  final void Function(PriorityLevel?)? onSelected;

  const CustomDropdownMenu({
    Key? key,
    required this.initialSelection,
    this.onSelected,
  }) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  PriorityLevel? _selectedPriority;
  final TextEditingController priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.initialSelection;
    priorityController.text = _selectedPriority!.label;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: DropdownMenu<PriorityLevel>(
            initialSelection: _selectedPriority,
            controller: priorityController,
            requestFocusOnTap: true,
            label: const Text('Priority Level'),
            onSelected: widget.onSelected,
            dropdownMenuEntries: PriorityLevel.values
                .map<DropdownMenuEntry<PriorityLevel>>((PriorityLevel priority) {
              return DropdownMenuEntry<PriorityLevel>(
                value: priority,
                label: priority.label,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
