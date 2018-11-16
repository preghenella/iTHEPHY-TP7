#include "Pythia8/Pythia.h"
#include "Pythia8Plugins/HepMC2.h"

using namespace Pythia8;

int main()
{

  double px = 0., py = 0., pz = 1., m = 1.019461;
  double e = sqrt(px * px + py * py + pz * pz + m * m);

  HepMC::Pythia8ToHepMC ToHepMC;
  HepMC::IO_GenEvent ascii_io("gun.hepmc", std::ios::out);
  
  // init pythia
  Pythia pythia;
  pythia.readString("SoftQCD:elastic on");
  pythia.init();

  // force decays
  pythia.readString("333:mayDecay = on");
  // [mother]:oneChannel = 1 1. 0 [list of daughters]
  pythia.readString("333:oneChannel = 1 1. 0 -11 11"); // phi -> e+ e-

  // event loop
  for (int iev = 0; iev < 10; ++iev) {
    pythia.event.clear();
    pythia.event.append(333, 11, 0, 0, px, py, pz, e, m);
    pythia.moreDecays();
    pythia.event.list();

    HepMC::GenEvent *hepmcevt = new HepMC::GenEvent();
    ToHepMC.fill_next_event(pythia, hepmcevt);
    ascii_io << hepmcevt;
    delete hepmcevt;
  }
  
}
