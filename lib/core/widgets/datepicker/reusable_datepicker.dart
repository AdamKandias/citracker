import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../constants/color.dart';

class ReusableDatePicker extends StatefulWidget {
  final String? label;
  final DateTime? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final Function(String) onChanged;

  const ReusableDatePicker({
    Key? key,
    this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ReusableDatePicker> createState() => _ReusableDatePickerState();
}

class _ReusableDatePickerState extends State<ReusableDatePicker> {
  DateTime? selectedValue;
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    controller = TextEditingController(
      text: getInitialValue(),
    );
  }

  getInitialValue() {
    if (widget.value != null) {
      return DateFormat("d MMMM y").format(widget.value!);
    }
    return "-";
  }

  getFormattedValue() {
    if (selectedValue != null) {
      return DateFormat("d MMMM y").format(selectedValue!);
    }
    return "-";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          selectedValue = pickedDate;
          controller.text = getFormattedValue();
          setState(() {});

          if (selectedValue == null) return;
          widget.onChanged(getFormattedValue());
        },
        child: Container(
          width: 325.w,
          height: 50.h,
          margin: EdgeInsets.only(bottom: 20.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              border: Border.all(color: AppColors.primaryFourthElementText)),
          child: SizedBox(
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (widget.validator != null) {
                    return widget.validator!(selectedValue.toString());
                  }
                  return null;
                },
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  labelText: widget.label,
                  labelStyle: const TextStyle(
                    color: AppColors.primaryText,
                  ),
                  prefixIcon: Icon(
                    Icons.date_range,
                    size: 16.w,
                    color: AppColors.primaryText,
                  ),
                  helperText: widget.helper,
                  hintText: widget.hint,
                ),
              ),
            ),
          ),
        ));
  }
}
