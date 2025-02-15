
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* Register Form
|--------------------------------------------------------------------------
| Usage: https://nylo.dev/docs/6.x/forms#how-it-works
| Casts: https://nylo.dev/docs/6.x/forms#form-casts
| Validation Rules: https://nylo.dev/docs/6.x/validation#validation-rules
|-------------------------------------------------------------------------- */

class RegisterForm extends NyFormData {
  RegisterForm({String? name}) : super(name ?? "register");

  /*
  {
  "name": "Md Rakibul Haque",
  "email": "test1w@example.com",
  "student_id":"221311160",
  "password": "Add3445@2ef",
  "password_confirmation": "Add3445@2ef",
  "phone": "01458895154"
}

   */

  @override
  fields() => [
        Field.text("Name",
            dummyData: "Md Rakibul Haque",
            validate: FormValidator.notEmpty(),
            style: "compact"),
        Field.email(
            dummyData: "test@gmail.com",
            "Email", validate: FormValidator.email(),
            style: "compact"),
        [
          Field.text("Student ID",
              dummyData: "221311160",
              validate: FormValidator()
                  .notEmpty()
                  .minLength(9)
                  .maxLength(20),
              style: "compact"),

          Field.text(
              dummyData: "01458895154",
              "Phone", validate: FormValidator.phoneNumber(), style: "compact"),
        ],

        Field.password(
           dummyData: 'Add3445@2ef',
            "Password", validate: FormValidator.password(strength: 1), style: "compact"),

        Field.password(
            dummyData: 'Add3445@2ef',
            "Password Confirmation",  validate: FormValidator.password(strength: 1), style: "compact"),
      ];
}
