String? tansformCapitalizeText({required String? text}) {
  final transformed = text
      ?.toLowerCase()
      .trim()
      .split(RegExp(r'\s+'))
      .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
      .join(' ');

  return transformed;
}
