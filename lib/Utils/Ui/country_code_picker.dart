import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter/material.dart';
countryCodePicker(countryCode,  onCountryChange){

  return CountryCodePicker(
    textStyle:  TextStyle(color: Colors.white),
    enabled: true,
    showFlagMain: false	,
    onChanged: onCountryChange,
    initialSelection: 'JO',
    showCountryOnly: false,
    showOnlyCountryWhenClosed: false,
    favorite: const ['+46', 'Sweden'],
  );

}

