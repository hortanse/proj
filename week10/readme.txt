The script q.pl read in an accession number and get the sequence from Genbank database. Then do the blast.
Retrieves the top non-self hit (i.e., the best hit that is not the sequence being BLASTed), does a BLAST search with that, and prints out information (accession, GI, name, species, etc.) from the top non-self hit of the second BLAST search. If the top non-self hit from the second search is the same as the original sequence provided as input, your program should note this in the output.

