import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/main.dart';
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
  // to get the ui element height which is overlapped (i.e keyboard)
  var keyboradSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity, // to make modal to take full height in landscape
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(30, 56, 30, keyboradSpace + 30),
          child: Column(
            children: [
              TextField(
                // onChanged: _saveEditedTitleValue,
                style: const TextStyle(fontSize: 20),
                maxLength: 50,
                controller: _titleController,
                decoration: const InputDecoration(
                  label: Text("Title", style: TextStyle(fontSize: 20)),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        prefixText: "\$ ",
                        label: Text("Amount", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 80,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment:
                          CrossAxisAlignment.center, //vertical allignment
                      children: [
                        Text(
                            (_selectedDate == null)
                                ? "Select Date"
                                : formatter.format(_selectedDate!),
                            style: const TextStyle(fontSize: 16)),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Select Category :", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color:Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              alignment: Alignment.center,
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
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: closeModal,
                    child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      saveExpense();
                    },
                    child:
                        const Text("Save Expense", style: TextStyle(fontSize: 16)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
