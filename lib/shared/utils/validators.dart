class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }
}



// re_a_rule = re.compile(r'(\{.*?\})')
// re_if_part = re.compile(r'^\{IF:\s+(\[.*?\])')
// re_then_part = re.compile(r'THEN:\s+(\'.*?\')')
// re_description_part = re.compile(r'DESCRIPTION:\s+(\'.*?\')')