import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';

class ExpenseModal extends StatefulWidget {
  const ExpenseModal({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<ExpenseModal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.lesiure;

  // var _editedTitleValue = "";

  // void _saveEditedTitleValue(String inputValue) {
  //   _editedTitleValue = inputValue;
  //   print("getEditedTitleValue : $_editedTitleValue");
  // }

  void closeModal() {
    // To close the modal
    Navigator.pop(context);
  }

  void displyDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final initialDate = (_selectedDate == null) ? now : _selectedDate;
    //first method to get future values using .then method
    // showDatePicker(
    //         context: context,
    //         initialDate: now,
    //         firstDate: firstDate,
    //         lastDate: now)
    //     .then((value) => {
    //       setState(() {
    //         _selectedDate = value;
    //       }),
    //     });

    //second method to get future values using Async-await
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate!,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void saveExpense() {
    var editedAmount = double.tryParse(_amountController
        .text); //tryParse("hello") => null, tryParse("34")=>34.0

    if (_titleController.text.trim().isEmpty ||
        editedAmount == null ||
        editedAmount <= 0 ||
        _selectedDate == null) {
      print("Error :All feilds are mandatory .Please check the errors");
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                icon: const Icon(Icons.error, color: Colors.red),
                title: const Text("Invalid Input"),
                content: const Text(
                    "All feilds are mandatory. Please make sure a valid title, amount, date and category are filled"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("OK"))
                ],
              ));
      return;
    }

    print("TitleValue : ${_titleController.text}");
    print("AmountValue : ${_amountController.text}");
    print("CategoryValue : ${_selectedCategory.name}");
    print("Date: ${formatter.format(_selectedDate!)}");
    
    var expense = Expense(
        title: _titleController.text,
        amount: editedAmount,
        date: _selectedDate!,
        category: _selectedCategory);

//Important : to access Widget property from Stateclass.
    widget.onAddExpense(expense);

    closeModal();
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
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
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
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment:
                      CrossAxisAlignment.center, //vertical allignment
                  children: [
                    Text((_selectedDate == null)
                        ? "Select Date"
                        : formatter.format(_selectedDate!)),
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
              const SizedBox(width: 16),
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: closeModal,
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveExpense();
                      },
                      child: const Text("Save Expense"),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
