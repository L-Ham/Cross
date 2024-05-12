import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/ensure_http.dart';

void main() {
  test('ensureHttp should add http prefix to url without http or https', () {
    String url = 'example.com';
    expect(ensureHttp(url), 'http://example.com');
  });

  test('ensureHttp should not modify url with http prefix', () {
    String url = 'http://example.com';
    expect(ensureHttp(url), 'http://example.com');
  });

  test('ensureHttp should not modify url with https prefix', () {
    String url = 'https://example.com';
    expect(ensureHttp(url), 'https://example.com');
  });
}