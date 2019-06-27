#!/usr/bin/perl
use strict;
use warnings;
use threads;
 
use DBI;
my $dsn = "DBI:mysql:host=localhost;database=db1";
my $username = "root";
my $password = '';

sub run_inserts {
	my %attr = ( PrintError=>1,
				RaiseError=>0); 

	my $dbh = DBI->connect($dsn,$username,$password, \%attr);

	
	for (my $i=0; $i < 100000; $i++) {
		my $sql = "INSERT INTO insert_duplicate_update_tab (rnd) VALUES (" . int(rand(4000000)) . ");";
		my $stmt = $dbh->prepare($sql);
		$stmt->execute();
		$stmt->finish();
		
		$sql = "INSERT INTO insert_duplicate_update_tab (id, rnd) VALUES (LAST_INSERT_ID(), " . int(rand(4000000)) . ") ON DUPLICATE KEY UPDATE unq = LAST_INSERT_ID();";
		$stmt = $dbh->prepare($sql);
		$stmt->execute();
		$stmt->finish();
	}

	$dbh->disconnect();
	
	return 0;
}			 

my %attr = ( PrintError=>0,
			RaiseError=>1); 

my $dbh = DBI->connect($dsn,$username,$password, \%attr);

my @ddl = (
 "DROP TABLE IF EXISTS insert_duplicate_update_tab;",
 "CREATE TABLE insert_duplicate_update_tab(
   id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
   rnd int(11) NOT NULL,
   unq int(11) NULL,
   UNIQUE KEY (unq)
 ) ENGINE=InnoDB;"
);

for my $sql(@ddl) {
	$dbh->do($sql);
}

$dbh->disconnect();

my $num_threads=5;
my @threads;

for (my $i=0; $i < $num_threads; $i++) {
	print "Starting thread: " . int($i + 1) . "\n";
	
	my $thr = threads->create(\&run_inserts);
	push(@threads, $thr);
}

for (my $i=0; $i < $num_threads; $i++) {
	while ($threads[$i]->is_running()) {
		sleep(1);
	}
	
	print "Joining thread: " . int($i + 1) . "\n";
	$threads[$i]->join();
}