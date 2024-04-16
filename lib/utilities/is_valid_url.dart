bool isValidUrl(String? url) {
  if (url == null) {
    return false;
  }
  Uri? uri = Uri.tryParse(url);

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
