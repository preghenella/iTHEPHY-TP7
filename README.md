# iTHEPHY-TP7

## Load software environment
You can load the software environment with

`$ ./tp7env.sh`

The shell prompt will be modified to signal that you are within the TP7 software environment

`[tp7env]$`

## Download and build software
`$ ./tp7build.sh`

## Event generation with Pythia8
Event generation with Pythia8 is interfaced by the Sacrifice software program.
Make sure you have all the software installed and that you have loaded the software environment

`$ ./tp7env.sh`

Chech the usage of Sacrifice and the available options

`[tp7env]$ pyhtia-run --help`

Here is a simple example of running 1000 inelastic proton-proton collisions at the centre-of-mass energy of 14 TeV with the output written to a HepMC file

`[tp7env]$ run-pythia -n 1000 -f PROTON -b PROTON -e 14000. -c "SoftQCD:inelastic on" -o pythia8.hepmc`

The setting for Pythia8 are in this case passed with the `-c` option. It is good practice to have the settings written to a file and use the `-i` option

`[tp7env]$ run-pythia -n 1000 -f PROTON -b PROTON -e 14000. -i evgen/pythia8/inelastic.params -o pythia8.hepmc`

## Simulation with Delphes
Detector simulation with Delphes needs the following input:
* configuration file (Tcl format)
* output file (ROOT format)
* input files (HepMC format)

Make sure you have all the software installed and that you have loaded the software environment.
Check the usage of Delphes

`[tp7env]$ DelphesHepMC --help`

Here is a simple example of simulation reading the 1000 inelastic proton-proton collisions at the centre-of-mass energy of 14 TeV that we generated before

`[tp7end]$ DelphesHepMC $DELPHES_ROOT/cards/validation_card.tcl delphes.root pythia8.hepmc`

The detector configuration fo Delphes simulation is provided by the so-called Tcl cards. You can find several examples of cards in `$DELPHES_ROOT/cards`. Please, get familiar with Tcl scripting and in the Delphes flow by looking at the examples provided.
