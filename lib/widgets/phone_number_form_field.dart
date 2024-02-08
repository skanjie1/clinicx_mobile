import 'package:clinicx_patient/utils/strings.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:clinicx_patient/utils/constants.dart';

class PhoneNumberFormField extends StatefulWidget {
  const PhoneNumberFormField(
      {Key? key,
      this.initialValue,
      this.errorText,
      this.labelText,
      this.enabled,
      this.autofocus,
      this.showBorder = true,
      this.showPrefix = true,
      this.validator,
      this.onChanged})
      : super(key: key);

  final String? initialValue;
  final String? errorText;
  final String? labelText;
  final bool? enabled;
  final bool showBorder;
  final bool? autofocus;
  final bool showPrefix;
  final void Function(
    String? countryCode,
    String? value,
  )? onChanged;
  final String? Function(String?)? validator;

  @override
  State<PhoneNumberFormField> createState() => _PhoneNumberFormFieldState();
}

class _PhoneNumberFormFieldState extends State<PhoneNumberFormField> {
  CountryCode? _country;
  final countryPicker = const FlCountryCodePicker();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getDefaultCountry(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(_country.toString()),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: widget.validator,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: 11,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
        counterText: "",
        focusedBorder: widget.showBorder ? focusedBorder : transparentBorder,
        border: widget.showBorder ? outlineBorder : transparentBorder,
        errorBorder: widget.showBorder ? errorBorder : transparentBorder,
        enabledBorder: !widget.showBorder
            ? transparentBorder
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xFF1A1A1A).withOpacity(0.1),
                  width: 1,
                ),
              ),
        prefixIcon: widget.showPrefix
            ? const Icon(
                Icons.phone_outlined,
                color: Colors.grey,
              )
            : null,
        prefix: GestureDetector(
          onTap: _showCountryPicker,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _country != null
                ? [
                    // Image.asset(
                    //   _country!.flagUri,
                    //   package: countryCodePackageName,
                    //   width: 20,
                    // ),
                    _country!.flagImage(width: 20),
                    const SizedBox(width: 10),
                    Text(
                      _country!.dialCode,
                      style: const TextStyle(color: Colors.black),
                    )
                  ]
                : [],
          ),
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 14,
          color: const Color(0xFF1A1A1A).withOpacity(0.5),
        ),
        errorText: widget.errorText,
      ),
      enabled: widget.enabled,
      autofocus: widget.autofocus ?? false,
      initialValue: widget.initialValue != null && _country != null
          ? widget.initialValue!
              .substring(_country!.dialCode.substring(1).length)
          : null,
      onChanged: _changePhoneNumber,
      keyboardType: TextInputType.phone,
    );
  }

  Future<void> getDefaultCountry(BuildContext context) async {
    final list = countryPicker.countryCodes;
    setState(() {
      _country = list.firstWhere((element) => element.dialCode == "+254");
    });
  }

  void _showCountryPicker() async {
    final code = await countryPicker.showPicker(
        context: context, scrollToDeviceLocale: true);
    if (code != null) {
      setState(() {
        _country = code;
      });
    }
  }

  void _changePhoneNumber(String value) {
    if (value.length > 12) {
      return;
    }
    if (widget.onChanged != null) {
      if (Strings.isNullOrEmpty(value)) {
        return widget.onChanged!(null, null);
      }

      final callingCode = _country!.dialCode.replaceAll('+', '');
      return widget.onChanged!(callingCode, value);
    }
  }
}

Future<String> getCountryInitials(
    BuildContext context, String countryCode) async {
  print("COUNTRY CODE $countryCode");
  final list = const FlCountryCodePicker().countryCodes;
  final country =
      list.firstWhere((element) => element.dialCode == "+$countryCode");
  return country.code;
}
