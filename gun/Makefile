all: gun

gun: gun.cxx
	g++ -o gun gun.cxx -I${PYTHIA8_ROOT}/include -L${PYTHIA8_ROOT}/lib -lpythia8 -I${HEPMC_ROOT}/include -L${HEPMC_ROOT}/lib -lHepMC
