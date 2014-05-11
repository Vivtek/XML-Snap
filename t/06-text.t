#!perl -T

use Test::More;
use XML::Snap;
use Data::Dumper;

my $text = <<'EOF';
<test>
This is a rather typical example of the use of XML
for <i>formatted text</i> instead of as a
<i>structured data format</i>.
</test>
EOF

$xml = XML::Snap->parse ($text);

@list0 = $xml->children ();
is (@list0, 5);
@list1 = $xml->elements ();
is (@list1, 2);

is (ref($list0[0]), '');

$xml2 = XML::Snap->parse_with_refs ($text);

@list0 = $xml2->children ();
is (@list0, 5);
@list1 = $xml2->elements ();
is (@list1, 2);

is (ref($list0[0]), 'XML::Snap');
ok ($list0[0]->is_text);
ok (not $list0[1]->is_text);
is ($list0[0]->get_text, "\nThis is a rather typical example of the use of XML\nfor ");

#diag Dumper($xml2);

done_testing();