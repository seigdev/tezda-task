import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatefulWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final bool headerLess;
  final TextEditingController? editingController;
  final int lines;
  final bool readOnly;
  final bool obscureText;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Widget? suffix;
  final TextInputAction textInputAction;
  final Border? border;
  final Color? backgroundColor;
  final double? borderRadius;

  final String? prefixText;
  final String? headerText;
  final String? initialValue;
  const TextFieldComponent({
    super.key,
    this.hint = '',
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.headerText = '',
    this.headerLess = true,
    this.editingController,
    this.lines = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.prefix,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.suffix,
    this.textInputAction = TextInputAction.done,
    this.border,
    this.backgroundColor,
    this.prefixText,
    this.initialValue,
    this.borderRadius,
  });

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent>
    with AppThemeMixin {
  @override
  void initState() {
    _node = widget.focusNode ?? FocusNode();
    super.initState();
  }

  FocusNode? _node;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_node);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.readOnly
              ? const SizedBox.shrink()
              : !widget.headerLess
                  ? Text(
                      widget.headerText!,
                      style: TextStyle(
                        color: colors.ggray900,
                        fontWeight: FontWeight.w400,
                        fontSize: TextSizes.size12,
                      ),
                    )
                  : const SizedBox.shrink(),
          const SizedBox(height: Spacings.spacing6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            decoration: BoxDecoration(
              color: colors.ggray100.withOpacity(0.2),
              border: Border.all(color: colors.ggray200),
              borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? Spacings.spacing10),
            ),
            child: Row(
              children: [
                widget.prefix ?? const HSpacer(Spacings.spacing14),
                Expanded(
                  child: TextFormField(
                    focusNode: _node,
                    initialValue: widget.initialValue,
                    readOnly: widget.readOnly,
                    onChanged: widget.onChanged,
                    onTap: widget.onTap,
                    onEditingComplete: widget.onEditingComplete,
                    textInputAction: widget.textInputAction,
                    obscureText: widget.obscureText,
                    keyboardType: widget.keyboardType,
                    controller: widget.editingController,
                    inputFormatters: widget.inputFormatters,
                    maxLines: widget.obscureText ? 1 : (widget.lines),
                    minLines: widget.obscureText ? 1 : (widget.lines),
                    cursorColor: colors.tF9A03F,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colors.kBlack,
                      fontSize: TextSizes.size14,
                    ),
                    decoration: InputDecoration(
                      prefixText: widget.prefixText,
                      prefixStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: colors.ggray900,
                        fontSize: TextSizes.size14,
                      ),
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        color: colors.ggray500,
                        fontWeight: FontWeight.w400,
                        fontSize: TextSizes.size14,
                      ),
                      label: widget.hint.isNotEmpty
                          ? Text(
                              widget.hint,
                            )
                          : null,
                      hintStyle: TextStyle(
                        color: colors.ggray400,
                        fontWeight: FontWeight.w400,
                        fontSize: TextSizes.size14,
                      ),
                    ),
                  ),
                ),
                widget.suffix ?? const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
