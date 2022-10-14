import 'package:flutter/material.dart';

@immutable
class OptionListTile extends StatelessWidget {
  const OptionListTile({
    super.key,
    required this.titleText,
    this.leadingIcon,
    this.subTitleText,
    this.trailingIcon = Icons.keyboard_arrow_right,
    required this.onTap,
  });
  final String titleText;
  final IconData? leadingIcon;
  final String? subTitleText;
  final IconData trailingIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          titleText,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: leadingIcon == null ? null : Icon(leadingIcon),
        subtitle: subTitleText == null ? null : Text(subTitleText!),
        trailing: Icon(
          trailingIcon,
        ),
        onTap: onTap,
      ),
    );
  }
}
