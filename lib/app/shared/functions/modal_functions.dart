import 'package:flutter/material.dart';
import 'package:tezda_task/core/core.dart';

import '../components/modal_component.dart';

Future showModal({required Widget child}) => showDialog(
      context: context!,
      builder: (context) => ModalComponent(
        child: child,
      ),
    );
