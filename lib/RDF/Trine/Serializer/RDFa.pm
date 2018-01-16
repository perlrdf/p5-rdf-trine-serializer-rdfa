package RDF::Trine::Serializer::RDFa;

use 5.010001;
use strict;
use warnings;
use base qw(RDF::Trine::Serializer);
use RDF::RDFa::Generator;

our $AUTHORITY = 'cpan:KJETILK';
our ($VERSION);
BEGIN {
  $VERSION = '0.01';
  $RDF::Trine::Serializer::serializer_names{ 'rdfa' } = __PACKAGE__;
  $RDF::Trine::Serializer::format_uris{ 'http://www.w3.org/ns/formats/RDFa' } = __PACKAGE__;
  foreach my $type (qw(application/xhtml+xml text/html)) {
	 $RDF::Trine::Serializer::media_types{ $type } = __PACKAGE__;
  }
}


sub new {
	my ($class, %args) = @_;
	my $gen = RDF::RDFa::Generator->new(%args); 
	my $self = bless( { gen => $gen }, $class);
	return $self;
}

sub serialize_model_to_string
{
	my ($self, $model) = @_;
	return $self->{gen}->create_document($model)->toString;
}

sub serialize_model_to_file
{
	my ($self, $fh, $model) = @_;
	print {$fh} $self->{gen}->create_document($model)->toString;
}

sub serialize_iterator_to_string
{
	my ($self, $iter) = @_;
	my $model = RDF::Trine::Model->temporary_model;
	while (my $st = $iter->next)
	{
		$model->add_statement($st);
	}
	return $self->{gen}->serialize_model_to_string($model);
}

sub serialize_iterator_to_file
{
	my ($self, $fh, $iter) = @_;
	my $model = RDF::Trine::Model->temporary_model;
	while (my $st = $iter->next)
	{
		$model->add_statement($st);
	}
	return $self->{gen}->serialize_model_to_file($fh, $model);
}


1;

__END__

=pod

=encoding utf-8

=head1 NAME

RDF::Trine::Serializer::RDFa - RDFa Serializer for RDF::Trine

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS

Please report any bugs to
L<https://github.com/kjetilk/p5-rdf-trine-serializer-rdfa/issues>.

=head1 SEE ALSO

=head1 AUTHOR

Kjetil Kjernsmo E<lt>kjetilk@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2017, 2018 by Kjetil Kjernsmo.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

