import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Login Form
|--------------------------------------------------------------------------
| Usage: https://nylo.dev/docs/6.x/forms#how-it-works
| Casts: https://nylo.dev/docs/6.x/forms#form-casts
| Validation Rules: https://nylo.dev/docs/6.x/validation#validation-rules
|-------------------------------------------------------------------------- */

class LoginForm extends NyFormData {
  LoginForm({String? name}) : super(name ?? "login");

  @override
  fields() => [
        Field.text("login",
            prefixIcon: Icon(Icons.person),
            dummyData: "221311160",
            validate: FormValidator()
                .notEmpty()
                .minLength(9)
                .maxLength(20),
            style: "compact"
        ),

        Field.password(
            "password",
            dummyData: 'Add3445@2ef',
            validate: FormValidator.password(strength: 1), style: "compact"
        ),
      ];
}
