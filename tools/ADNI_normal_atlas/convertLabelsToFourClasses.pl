#/usr/bin/perl -w

use strict;

use Cwd 'realpath';
use Switch;
use File::Find;
use File::Basename;
use File::Path;
use File::Spec;
use FindBin qw($Bin);

my $usage = qq{
  Usage: convertLabels.pl <inputImage> <outputImage>
 };

my ( $inputImage, $outputImage ) = @ARGV;
my $ANTsPath = '/Users/ntustison/Pkg/ANTS/bin/bin/';

my @csfLabels = ( 4, 46, 49, 50, 51, 52 );
my @wmLabels = ( 44, 45 );
my @corticalLabels = ( 31, 32, 42, 43, 47, 48 );  # also anything >= 100
my @subcorticalLabels = ( 23, 30, 36, 37, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 75, 76 );
my @brainstemLabels = ( 35 );
my @cerebellumLabels = ( 11, 38, 39, 40, 41, 71, 72, 73 );

my ( $imagePrefix, $directories, $suffix ) = fileparse( $inputImage, ".nii.gz" );

print "************************\n";
print "Processing $imagePrefix\n";
print "************************\n";

my $tmp = "${directories}/${imagePrefix}_tmp.nii.gz";

`ThresholdImage 3 $inputImage $outputImage 100 207 2 0`;

print "csf: ";
for( my $j = 0; $j < @csfLabels; $j++ )
  {
  print "$csfLabels[$j] ";
  `ThresholdImage 3 $inputImage $tmp $csfLabels[$j] $csfLabels[$j] 1 0`;
  `BinaryOperateImages 3 $tmp max $outputImage $outputImage`;
  }
print "\n";

print "cortex: ";
for( my $j = 0; $j < @corticalLabels; $j++ )
  {
  print "$corticalLabels[$j] ";
  `ThresholdImage 3 $inputImage $tmp $corticalLabels[$j] $corticalLabels[$j] 2 0`;
  `BinaryOperateImages 3 $tmp max $outputImage $outputImage`;
  }
print "\n";

print "sub-cortex: ";
for( my $j = 0; $j < @subcorticalLabels; $j++ )
  {
  print "$subcorticalLabels[$j] ";
  `ThresholdImage 3 $inputImage $tmp $subcorticalLabels[$j] $subcorticalLabels[$j] 3 0`;
  `BinaryOperateImages 3 $tmp max $outputImage $outputImage`;
  }
print "\n";

print "white matter: ";
for( my $j = 0; $j < @wmLabels; $j++ )
  {
  print "$wmLabels[$j] ";
  `ThresholdImage 3 $inputImage $tmp $wmLabels[$j] $wmLabels[$j] 4 0`;
  `BinaryOperateImages 3 $tmp max $outputImage $outputImage`;
  }
print "\n";

print "brain stem: ";
for( my $j = 0; $j < @brainstemLabels; $j++ )
  {
  print "$brainstemLabels[$j] ";
  `ThresholdImage 3 $inputImage $tmp $brainstemLabels[$j] $brainstemLabels[$j] 5 0`;
  `BinaryOperateImages 3 $tmp max $outputImage $outputImage`;
  }
print "\n";

print "cerebellum: ";
for( my $j = 0; $j < @cerebellumLabels; $j++ )
  {
  print "$cerebellumLabels[$j] ";
  `ThresholdImage 3 $inputImage $tmp $cerebellumLabels[$j] $cerebellumLabels[$j] 6 0`;
  `BinaryOperateImages 3 $tmp max $outputImage $outputImage`;
  }
print "\n";
