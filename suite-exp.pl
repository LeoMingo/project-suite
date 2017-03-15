#!/usr/bin/perl

##############################################
#Suite Experiment Commands
#
# 0 suite-exp file --<option> <args...> 
#
# 1 -Ei --Extract-integration-marked
#
# 2 -Eq --Extract-question-marked
#
# 3 -SU --Section-Upgrade
#
# 4 -SUi --Section-Upgrade-of-integration-marked
# 
# 5 -SUq --Section-Upgrade-of-question-marked
# 4 -SUiq -SUqi --Section-Upgrade-of-integration-marked-and-question-marked
#
##############################################

use strict;

use feature 'say';

use v5.24.1;


if ($ARGV[0]) {
    if ($ARGV[0] =~ /-h/ || $ARGV[0] =~ /--help/) { 
        say $help_msg;
    }elsif ($ARGV[1]) {#the two propositions have no connections, only for using one of the options
 
        my $file_name = $ARGV[0];
        
        open(my $in, '<', $file_name); 
        #    or die "Unable to open to read file: $file_name $!";

        my $new_file_name = $file_name."-trimmed";
        open(my $out, '>', $new_file_name);
        #   or die "Unable to open to write file: $new_file_name $!";

        my @lines_of_file = <$in>;



        if ($ARGV[1] =~ /-Ei/ || $ARGV[1] =~ /--Extract-integration-marked/) {
        
        } elsif ($ARGV[1] =~ /-Eq/ || $ARGV[1] =~ /--Extract-question-marked/) {
        
        
        } elsif ($ARGV[1] =~ /-SU/ || $ARGV[1] =~ /--Section-Upgrade/) {
            say "Specify the upgration mode type : i for integration-marked sections and q for question-marked sections";
        
        } elsif ($ARGV[1] =~ /-SUiq/ || $ARGV[1] =~ /--Section-Upgrade/) {
        
        
        } elsif ($ARGV[1] =~ /-SUiq/ || $ARGV[1] =~ /--Section-Upgrade/) {
        
        
        }      
    }

} else {
    say "Please specify arguments , add -h or --help to print a help message";
}

