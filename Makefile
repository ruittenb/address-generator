
all: man

man:
	pod2man -s 6 -q none adres.pl > adres.6
