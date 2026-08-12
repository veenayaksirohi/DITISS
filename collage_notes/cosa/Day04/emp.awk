#!/usr/bin/awk -f

# Shebang line - identification

BEGIN{
	print "-----Processing Employees------"
}

{
	print $1, $2, $5
}

END{
	print "----End of processing----"
}
