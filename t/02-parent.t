#!perl -T

use Test::More tests => 14;

use XML::Snap;

$xml = XML::Snap->parse ('<test2><this><this2/><this3/></this></test2>');
isa_ok ($xml, 'XML::Snap');

$p1 = $xml->parent;
ok (not defined $p1);

$first_not_found = $xml->first ("not_found_thing");
ok (not defined $first_not_found);

$this3 = $xml->first ('this3');
ok (defined $this3);
isa_ok ($this3, 'XML::Snap');
is ($this3->name, 'this3');

$p = $this3->parent;
is ($p->name, 'this');

$a = $this3->ancestor('test2');
is ($a->name, 'test2');
is ($a, $xml);

$a2 = $this3->ancestor;
is ($a2->name, 'test2');
is ($a2, $xml);

$a3 = $this3->ancestor('notthere');
ok (not defined $a3);

$a4 = $this3->ancestor('this');
is ($a4->name, 'this');
is ($a4, $p);