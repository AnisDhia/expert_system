import 'dart:ffi';

class Validators {
  static final RegExp 
      _ruleRegExp = RegExp(r'(\{.*?\})'),
      _ifRegExp = RegExp(r'^\{IF:\s+(\[.*?\])'),
      _thenRegExp = RegExp(r'THEN:\s+(\".*?\")'),
      _descriptionRegExp = RegExp(r'DESCRIPTION:\s+(\".*?\")');

  // static isValidEmail(String email) {
  //   return _emailRegExp.hasMatch(email);
  // }
}



// re_a_rule = re.compile(r'(\{.*?\})')
// re_if_part = re.compile(r'^\{IF:\s+(\[.*?\])')
// re_then_part = re.compile(r'THEN:\s+(\'.*?\')')
// re_description_part = re.compile(r'DESCRIPTION:\s+(\'.*?\')')