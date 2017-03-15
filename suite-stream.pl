#!/usr/bin/perl 
# -w to enable warnings

##########################################################
# Suite Stream Commands
#
# 0 suite-stream file --<option> <args...> 
#
# 1 -T --trim-line (<line ID number...>) <num>
#           Trim off <num> characters of the start of each line specified in a file, if the line ID is not specified, all lines would be applied with this operation.
# 
# 2 -I --insert-start (<line ID number...>) <num>
#           Insert <num> characters into the start of each line specified in a file, if the line ID is not specified, all lines would be applied with this operation.
#
##########################################################

use strict;
#use warnings;
#use diagnostics;

use feature 'say';

use v5.24.1;



my $help_msg = 
"Suite Stream Commands
 
 suite-strean file --<option> <args...> 
 
 -T --trim-line (<line ID number...>) <num>
            Trim <num> characters off the line start.
 -I --insert-start (<line ID number...>) <num>
            Insert <num> characters into the line start.
";



my @c_argv = @ARGV;         #copied argv
my $argc = $#ARGV + 1;  




sub trim_line {
    my @l_o_f = @_;         #lines_of_file
    my @new_lines_of_file = ();
    
    my $num_of_trim = $c_argv[$argc-1];
    
    if ($argc == 3){  #without line number specification 
        for my $line (@l_o_f) {
            $line =~ s/^.{$num_of_trim}//;
            if (length($line)-1 < $num_of_trim) {
                $line =~ s/.//g;
            }
            push(@new_lines_of_file, $line);
        }
    } elsif($argc > 3) {        #With line number specification, this case the last argument is the number of times of trimming chars, and all the previous num args are line ID numbers
        my @line_num_arr = ();
        my $line = "";

        #Store line ID numbers
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


sub insert_start {
    my @l_o_f = @_;         #lines_of_file
    my @new_lines_of_file = ();
    
    my $inserted_string = $c_argv[$argc-1];
    
    if ($argc == 3){  #without line ID number specification 
        for my $line (@l_o_f) {
            $line =~ s/^/$inserted_string/;
            push(@new_lines_of_file, $line);
        }
    } elsif($argc > 3) {        #With line ID number specification, this case the last argument is the number of times of trimming chars, and all the previous num args are line ID numbers
        my @line_num_arr = ();
        my $line = "";

        #Store line ID numbers
        for (my $i = 2; $i < $argc-1; $i++) {
            push(@line_num_arr, $c_argv[$i]);
        }
        
        say "line ID: ", join(", ", @line_num_arr), "\n";
        
        for (my $i = 0; $i < $#l_o_f; $i++) {
            $line = $l_o_f[$i];

            if ( grep (/^$i$/, @line_num_arr) ) {
                say "ID: $i";
                print "original: ", $line;      #Each $line has a line feed terminator so use print
                
                $line =~ s/^/$inserted_string/;

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
    }elsif ($ARGV[1]) {#the two propositions have no connections, only for using one of the options
 
        my $file_name = $ARGV[0];
        
        open(my $in, '<', $file_name); 
        #    or die "Unable to open to read file: $file_name $!";

        my $new_file_name = $file_name."-trimmed";
        open(my $out, '>', $new_file_name);
        #   or die "Unable to open to write file: $new_file_name $!";

        my @lines_of_file = <$in>;


           
        if ($ARGV[1] =~ /-T/ || $ARGV[1] =~ /--trim-line/ ) {
        
            print $out trim_line(@lines_of_file);
        
        } elsif ($ARGV[1] =~ /-I/ || $ARGV[1] =~ /--insert-string/) {
            print $out insert_start(@lines_of_file);
        
        }     
    }

} else {
    say "Please specify arguments , add -h or --help to print a help message";
}







