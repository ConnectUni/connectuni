import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../user/domain/user_list.dart';
import 'field_padding.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField(
      {super.key, required this.fieldKey, required this.userList});

  final GlobalKey<FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      fieldKey;
  final UserList userList;

  @override
  Widget build(BuildContext context) {
    String fieldName = 'Email';

    return FieldPadding(
      child: FormBuilderTextField(
        name: fieldName,
        key: fieldKey,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: 'Ex: "john@foo.com',
        ),
        validator: (input) {
          if (input!.isEmpty) {
            return 'This field is required';
          }
          if (userList.getUserByEmail(input) == null) {
            return "Email is not valid";
          }
          return null; // return null if validation passes
        },
      ),
    );
  }
}
