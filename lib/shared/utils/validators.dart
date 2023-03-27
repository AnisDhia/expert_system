String generateRegexPattern(String input) {
  // Escape any special characters in the input string
  // input = RegExp.escape(input);
  

  // Replace the logical operator "AND" with a lookahead assertion
  input = input.replaceAll('and', '.*');
  // input = input.replaceAll(r'\band\b', '');

  // Replace the logical operator "OR" with a |
  input = input.replaceAll('or', '|');
  
  // Replace the logical operator "OR" with a non-capturing group
  // input = input.replaceAllMapped(
  //     RegExp(r'(\bor\b)'), (Match match) => '(?:${match.group(0)})');
  
  // Remove all whitespace characters
  input = input.replaceAll(RegExp(r'\s+'), '\\s*');

  // Return the final regex pattern
  return input;
}
