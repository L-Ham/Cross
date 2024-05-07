String ensureHttp(String url) {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    return 'http://$url';
  }
  return url;
}
