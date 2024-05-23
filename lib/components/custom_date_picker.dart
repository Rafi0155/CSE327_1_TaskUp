import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onDateChanged;

  const CustomDatePicker({super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateChanged,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate!;
  }

  // Method to get the selected date
  DateTime getSelectedDate() {
    return _selectedDate;
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.onDateChanged(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputDatePickerFormField(
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            onDateSubmitted: (date) {
              setState(() {
                _selectedDate = date;
                widget.onDateChanged(date);
              });
            },
            onDateSaved: (date) {
              setState(() {
                _selectedDate = date;
                widget.onDateChanged(date);
              });
            },
            fieldLabelText: 'Select Due Date',
            fieldHintText: 'Enter Due Date',
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: _pickDate,
        ),
      ],
    );
  }
}
