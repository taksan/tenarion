swipl -qs testes.pl | sed -n '/started/,$ p' | ./colorize red '\**FAILED.*' green PASSED:
