use strict;
use warnings;

use Tree::DAG_Node;

my $dt = Tree::DAG_Node->new;
$dt->name('22');
$dt->new_daughter->name('23');
my $node = &by_name($dt,'23');
$node->new_daughter->name('24');



$dt->walk_down({
    callback => sub {
        my $node = shift;
            print "  " x $_[0]->{_depth};
            print "(*) " 
               if $node->name eq $_[0]->{treename};
            print $node->name, "\n"
        },
    _depth => 0,
    treename => 'S' 
});

sub by_name {
    my ($self, $name) = @_;
    my @found =();
    my $retvalue = wantarray ? 1 : 0;
    $self->walk_down({callback=>sub{
        if ($_[0]->name eq $name) {
            push @found, $_[0];
            return $retvalue;
        }
        1}});
    return wantarray? @found : @found ? $found[0] : undef;
}