all: pythia-gun

pythia-gun: pythia-gun.cxx
	g++ -o pythia-gun pythia-gun.cxx -I${PYTHIA8_ROOT}/include -L${PYTHIA8_ROOT}/lib -lpythia8 -I${HEPMC_ROOT}/include -L${HEPMC_ROOT}/lib -lHepMC -lboost_program_options
