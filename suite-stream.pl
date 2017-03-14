#!/usr/bin/perl 
# -w to enable warnings

##########################################################
# Suite Stream Commands
#
# 0 suite-exp file --<option> <args...> 
#
# 1 -T --trim-line (<line number...>) <num>
# 
# 2 -Ei --Extract-integration-marked <output_file>      Extract code sectioned by -s^[  ]^s-
# 3 -Eq --Extract-question-marked <output_file>         Extract code sectioned by -s?[  ]?s-
#
# 4 -SUiq --Section-Upgrade<section_option> <input_file>                  Upgrade code section incrementally from input file
#
##########################################################

use strict;
#use warnings;
#use diagnostics;

use feature 'say';

use v5.24.1;



my $help_msg = 
"Suite Stream Commands
 
 suite-exp file --<option> <args...> 
 
 -T --trim-line (<line number...>) <num>

 -Ei --Extract-integration-marked <output_file>      
            Extract code sectioned by -s^[  ]^s-
 -Eq --Extract-question-marked <output_file>         
            Extract code sectioned by -s?[]?s-
 
 -SUiq --Section-Upgrade<section_option> <input_file>                  
            Upgrade code section incrementally from input file
";



my @c_argv = @ARGV;         #copied argv
my $argc = $#ARGV + 1;  


#-e^[
#]^e-

=begin
print for @lines_of_file;
=cut


sub trim {
    my @l_o_f = @_;         #lines_of_file
    my @new_lines_of_file = ();
    
    my $num_of_trim = $c_argv[$argc-1];
    
    if ($argc == 3){   
        for my $line (@l_o_f) {
            $line =~ s/^.{$num_of_trim}//;
            if (length($line)-1 < $num_of_trim) {
                $line =~ s/.//g;
            }
            push(@new_lines_of_file, $line);
        }
    } elsif($argc > 3) {        #This case the last argument is the number of times trimming chars, and all the previous num args are line numbers
        my @line_num_arr = ();
        my $line = "";

        for (my $i = 2; $i < $argc-1; $i++) {
            push(@line_num_arr, $c_argv[$i]);
        }
        
        say "line ID: ", join(", ", @line_num_arr), "\n";
        
        for (my $i = 0; $i < $#l_o_f; $i++) {
            $line = $l_o_f[$i];

            if ( grep (/^$i$/, @line_num_arr) ) {
                say "ID: $i";
                print "original: ", $line;      #Each $line has a line feed terminator so use print
                
                $line =~ s/^.{$num_of_trim}//;
                if ( length($line)-1 < $num_of_trim ) {
                    $line =~ s/.//g;
                }

                say "modified: ", $line;
                push(@new_lines_of_file, $line);
            }else {
                push(@new_lines_of_file, $line);
            }
        }
    
    }

    return @new_lines_of_file;
}




if ($ARGV[0]) {
    if ($ARGV[0] =~ /-h/ || $ARGV[0] =~ /--help/) { 
        say $help_msg;
        
    }elsif ($ARGV[1]) {#the two propositions have no connections, only for using only one of the options
 
        my $file_name = $ARGV[0];
        
        ## FILE HANDLES
        open(my $in, '<', $file_name); 
        #    or die "Unable to open to read file: $file_name $!";

        my $new_file_name = $file_name."-trimmed";
        open(my $out, '>', $new_file_name);
        #   or die "Unable to open to write file: $new_file_name $!";

        my @lines_of_file = <$in>;


           
        if ($ARGV[1] =~ /-T/ || $ARGV[1] =~ /--trim-line/ ) {
            print $out trim(@lines_of_file);
        
        } elsif ($ARGV[1] =~ /-Ei/ || $ARGV[1] =~ /--Extract-integration-marked/) {
        
        
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







