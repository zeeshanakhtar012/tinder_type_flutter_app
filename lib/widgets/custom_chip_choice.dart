import 'package:flutter/material.dart';

class CustomChipsChoice<T> extends StatefulWidget {
  final List<T> options;
  final List<T>? selectedOptions;
  final ValueChanged<List<T>> onChanged;

  CustomChipsChoice({
    required this.options,
    this.selectedOptions,
    required this.onChanged,
  });

  @override
  _CustomChipsChoiceState<T> createState() => _CustomChipsChoiceState<T>();
}

class _CustomChipsChoiceState<T> extends State<CustomChipsChoice<T>> {
  late List<T> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.from(widget.selectedOptions ?? []);
    print(_selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.options.map((option) {
        bool isSelected = _selectedOptions.contains(option);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedOptions.remove(option);
              } else {
                if (_selectedOptions.length<5) {
                  _selectedOptions.add(option);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("You can select only 5 options"),
                    ),
                  );
                }
              }
              widget.onChanged(_selectedOptions);
            });
          },
          child: Chip(
            side: BorderSide(
              color: Colors.white
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            label: Text(
              option.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: isSelected ? Color(0xFF9C6031) : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
