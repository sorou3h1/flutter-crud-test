import 'package:flutter/material.dart';
import 'package:mc_crud_test/core/resoruces/const/dimensions.dart';

primaryElevatedButtonStyle(BuildContext context, Size? fixedSize) =>
    ElevatedButton.styleFrom(
      fixedSize: fixedSize,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          defaultRadius,
        ),
      ),
    );
