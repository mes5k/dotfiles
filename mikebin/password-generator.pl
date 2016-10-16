#!/usr/bin/perl
my @chars = ('A'..'Z', '0'..'9', 'a'..'z', '!', '@', '#', '$', '%', '^', '&', '*', ':', ';');
my $len = 10 + int(rand(4));
my $rpass = '';
for(my $i = 0; $i < $len; ++$i) {
       $rpass .= $chars[int(rand(@chars - 1))];
}
print "$rpass\n"
