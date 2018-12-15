#!/usr/bin/perl

open $YAML, "<", $ARGV[0];

my @components = ();
my $contents = "";

while (<$YAML>) {
    if (/---/) {
        if (length($contents) > 0) {
            push @components, $contents;
        }
        $contents = "";
    } else {
        $contents .= $_;
    }
}
close($YAML);

# Strip duplicates
for (my $i = 0; $i < @components; $i++) {
    $component = $components[$i];

    for ($j = $i + 1; $j < @components; $j++) {
        if ($component eq @components[$j]) {
            splice(@components, $j, 1);
            $j = $j-1;
        }
    }
}

# Add Helm CRD hooks
for ($i = 0; $i < @components; $i++) {
    $component = $components[$i];
    if ($component =~ m/CustomResourceDefinition/) {
        $component =~ s/metadata:\n/metadata:\n  annotations:\n    "helm.sh\/hook": crd-install\n/;
        @components[$i] = $component;
    }

    print "---\n";
    print @components[$i];
}

print "---\n";
