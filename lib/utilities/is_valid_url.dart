bool isValidUrl(String url) {
  Uri? uri = Uri.tryParse(url);

  if (uri == null) {
    return false;
  }

  List<String> validTlds = [
    '.com',
    '.org',
    '.net',
    '.int',
    '.edu',
    '.gov',
    '.eg',
    '.co'
  ];

  for (String tld in validTlds) {
    if (uri.toString().endsWith(tld)) {
      return true;
    }
  }

  return false;
}
