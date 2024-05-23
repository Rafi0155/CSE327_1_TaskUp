import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/assignee.dart';
import '../components/assignee_dropdown_menu.dart';
import '../components/custom_date_picker.dart';
import '../components/custom_dropdown_menu.dart';
import '../components/my_textfield.dart';
import '../components/priority_level.dart';
import '../services/auth_service.dart';
import '../services/firestore.dart';

class AddEditTaskScreen extends StatefulWidget {
  final String? taskTitle;
  final String? taskDescription;
  final DateTime? taskDueDate;
  final String? taskPriority;

  const AddEditTaskScreen({
    Key? key,
    this.taskTitle,
    this.taskDescription,
    this.taskDueDate,
    this.taskPriority,
  }) : super(key: key);

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  //String? _selectedPriority;
  //PriorityLevel? _selectedPriority1 = PriorityLevel.low;
  PriorityLevel? _selectedPriority1;

  //firestore
  final FirestoreService firestoreService = FirestoreService();

  Assignee? _selectedAssignee;
  final List<Assignee> _assignees = [
    Assignee(name: 'John Doe'),
    Assignee(name: 'Jane Smith'),
    Assignee(name: 'Alice Johnson'),
    Assignee(name: 'Bob Brown'),
  ];

  CustomDatePicker customDatePicker = CustomDatePicker(initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101), onDateChanged: (date ) {  },);
  // You can access the selected date using the getSelectedDate() method

  @override
  void initState() {
    super.initState();
    if (widget.taskTitle != null) {
      _titleController.text = widget.taskTitle!;
    }
    if (widget.taskDescription != null) {
      _descriptionController.text = widget.taskDescription!;
    }
    _selectedDueDate = widget.taskDueDate;
    _selectedPriority1 = widget.taskPriority as PriorityLevel? ?? PriorityLevel.low;

  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDueDate) {
      setState(() {
        _selectedDueDate = pickedDate;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      // Save the task details
      Navigator.pop(context);

      firestoreService.addTask (
        _titleController.text,
          _descriptionController.text,
          DateTime.now(),
          _selectedPriority1.toString()
      );
      // clear the text controller
      _titleController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskTitle != null ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ListTile(
              //   title: Text(
              //     _selectedDueDate != null
              //         ? 'Due Date: ${DateFormat.yMd().format(_selectedDueDate!)}'
              //         : 'Select Due Date',
              //   ),
              //   trailing: const Icon(Icons.calendar_today),
              //   onTap: _pickDueDate,
              // ),

              CustomDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                onDateChanged: (date) {
                  // Handle date change
                },
              ),

              const SizedBox(height: 16),

              // DropdownButtonFormField<String>(
              //   value: _selectedPriority,
              //   decoration: const InputDecoration(
              //     labelText: 'Priority Level',
              //     border: OutlineInputBorder(),
              //   ),
              //   items: ['Low', 'Medium', 'High']
              //       .map((priority) => DropdownMenuItem<String>(
              //             value: priority,
              //             child: Text(priority),
              //           ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedPriority = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select a priority level';
              //     }
              //     return null;
              //   },
              // ),

              //const SizedBox(height: 16),

              // Custom DropdownMenu for Priority Levels
              CustomDropdownMenu(
                initialSelection: _selectedPriority1!,
                onSelected: (PriorityLevel? priority) {
                  setState(() {
                    _selectedPriority1 = priority;
                  });
                },
              ),

              const SizedBox(height: 16),

              AssigneeDropdownMenu(
                initialSelection: _selectedAssignee,
                assignees: _assignees,
                onSelected: (Assignee? assignee) {
                  setState(() {
                    _selectedAssignee = assignee;
                  });
                },
                onAddAssignee: () {
                  // Navigate to the screen where the user can add an assignee
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddAssigneeScreen(),
                  //   ),
                  // );
                },
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _saveTask,
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
