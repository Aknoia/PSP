///Input: aaaa/mm/gg
///Output: gg/mm/aaaa
String dataAmericaToIta(String data) {
  if (data.length < 10) {
    return 'n/a';
  } else {
    return '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)}';
  }
}

