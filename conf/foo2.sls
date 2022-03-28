/tmp:
  file.recurse:
    - source: salt://dir2

/tmp/bar:
  file.managed:
    - source: salt://dir2/file3
