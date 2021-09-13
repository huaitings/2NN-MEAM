use File::Copy ;
use Cwd;
my $path  = getcwd();
$lammps_path = "/opt/lammps-mpich-3.4.2/lmp_20210827";
@file = glob "*_Fine"; 
`rm -rf @file`;
open my $perl , "<NPT.in" or die "NPT.in";
@data = glob "*.data"; 

my $NPTIn;
while($_=<$perl>){$NPTIn.=$_;}
close $perl;
my @testA = <"NPT*.in">;
my @tempA = grep (($_=~m/(\w+).data/g),@testA);
for (@tempA){unlink "$_";} 
#print @data;
 #$datab = join " ",@data;
my @datanew = map (($_ =~ m/(\w+?)\.data/g),@data);
#$path = "/root/run/" ;
for my $ID(@datanew){
	$data1[0] = "$ID.log";
    $data1[1] = "$ID.data";# jumpname
	$data1[2] = "$ID";#cd folder
	$data1[3] = "$ID";#
open my $crystalIn,">NPT$ID.in";
printf $crystalIn "$NPTIn",@data1;
close $crystalIn;
system " export PATH=/opt/mpich_download/mpich-3.4.2/mpich_install/bin:$PATH ";
system " export LD_LIBRARY_PATH=/opt/mpich_download/mpich-3.4.2/mpich_install/lib:$LD_LIBRARY_PATH ";
system "mpirun $lammps_path   -in NPT$ID.in";
}   	
 