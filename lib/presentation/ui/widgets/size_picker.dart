import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSizeSelected;

  const SizePicker({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
  });

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  late String _selectedSize = widget.sizes.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Size",style: Theme.of(context).textTheme.titleMedium,),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:widget.sizes.map((item){
            return GestureDetector(
              onTap: (){
                _selectedSize = item;
                widget.onSizeSelected(item);
                setState(() {});
              },

              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 16,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 13,
                    color: _selectedSize == item
                        ?  Colors.blue
                        : null,
                  ),
                )
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
