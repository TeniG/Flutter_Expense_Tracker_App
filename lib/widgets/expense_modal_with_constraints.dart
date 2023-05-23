import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/main.dart';
import 'package:flutter_expense_tracker_app/models/expense.dart';
import 'package:flutter_expense_tracker_app/widgets/custom_widgets/custom_text_field.dart';

class ExpenseModalWithConstraints extends StatefulWidget {
  const ExpenseModalWithConstraints({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _ExpenseModalWithConstraintsState();
  }
}

class _ExpenseModalWithConstraintsState extends State<ExpenseModalWithConstraints> {
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

// provide info of what all constraints are applied by parent widget

    return LayoutBuilder(
      builder: (ctx, constraints) {
        var constraintMaxWidth = constraints.maxWidth;

        return SizedBox(
          height:
              double.infinity, // to make modal to take full height in landscape
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, keyboradSpace + 16),
                child: Column(
                  children: [
                    if (constraintMaxWidth >= 600) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: CustomTextFeild(
                                  textFeildController: _titleController,
                                  title: "Title")),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFeild(
                                textFeildController: _titleController,
                                title: "Amount",
                                prefixText: "\$ "),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text("Select Category :",
                                    style: TextStyle(fontSize: 16)),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.2),
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
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, //vertical allignment
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: closeModal,
                            child: const Text("Cancel",
                                style: TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              saveExpense();
                            },
                            child: const Text("Save Expense",
                                style: TextStyle(fontSize: 16)),
                          )
                        ],
                      ),
                    ] else ...[
                      CustomTextFeild(
                        textFeildController: _titleController,
                        title: "Title",
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFeild(
                                textFeildController: _titleController,
                                title: "Amount",
                                prefixText: "\$ "),
                          ),
                          const SizedBox(width: 10, height: 80),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, //vertical allignment
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
                          const Text("Select Category :",
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
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
                            child: const Text("Cancel",
                                style: TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              saveExpense();
                            },
                            child: const Text("Save Expense",
                                style: TextStyle(fontSize: 16)),
                          )
                        ],
                      )
                    ],
                  ],
                )),
          ),
        );
      },
    );
  }
}
