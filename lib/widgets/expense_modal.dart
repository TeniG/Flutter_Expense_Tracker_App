import 'package:flutter/material.dart';

class ExpenseModal extends StatefulWidget {
  const ExpenseModal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<ExpenseModal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // var _editedTitleValue = "";

  // void _saveEditedTitleValue(String inputValue) {
  //   _editedTitleValue = inputValue;
  //   print("getEditedTitleValue : $_editedTitleValue");
  // }

  void displyDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1,now.month,now.day);
    showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveEditedTitleValue,
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center, //vertical allignment
                  children:  [
                    const Text("Select Date"),
                    IconButton(
                      onPressed: () {
                        displyDatePicker();
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // To close the modal
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  print("getEditedTitleValue : ${_titleController.text}");
                  print("getEditedAMountValue : ${_amountController.text}");
                },
                child: const Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
