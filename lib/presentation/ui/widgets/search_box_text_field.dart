import 'package:crafty_bay/presentation/ui/utils/strings/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBoxTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  const SearchBoxTextField({
    super.key,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: textEditingController,
      decoration:InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: AppString.searchHintText,
        prefixIcon: const Icon(Icons.search,color: Colors.black45,),
        border:  const OutlineInputBorder(
            borderSide: BorderSide.none,
        ),
        enabledBorder:const  OutlineInputBorder(
            borderSide: BorderSide.none
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none
        ),
      ),

    );
  }
}