#! /usr/bin/env bash

TP7_SOURCE=$TP7_ROOT/SOFT/SOURCE
TP7_INSTALL=$TP7_ROOT/SOFT/INSTALL

commands="download build hepmc lhapdf pythia6 pythia8 agile sacrifice root delphes"

### MAIN ###
main() {

    # prepare software tree
    mkdir -p $TP7_SOURCE
    mkdir -p $TP7_INSTALL

    export MAKEFLAGS=-j5
    
    # check if commands provided
    if [ $# -gt 0 ]; then
	commands="$@"
    fi

    # download and build HepMC
    if [[ $commands =~ "hepmc" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_hepmc
	fi
	if [[ $commands =~ "build" ]]; then
	    build_hepmc
	fi
    fi
	
    # download and build LHAPDF
    if [[ $commands =~ "lhapdf" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_lhapdf
	fi
	if [[ $commands =~ "build" ]]; then
	    build_lhapdf
	fi
    fi
    
    # download and build Pythia6
    if [[ $commands =~ "pythia6" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_pythia6
	fi
	if [[ $commands =~ "build" ]]; then
	    build_pythia6
	fi
    fi
    
    # download and build Pythia8
    if [[ $commands =~ "pythia8" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_pythia8
	fi
	if [[ $commands =~ "build" ]]; then
	    build_pythia8
	fi
    fi
    
    # download and build AGILe
    if [[ $commands =~ "agile" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_agile
	fi
	if [[ $commands =~ "build" ]]; then
	    build_agile
	fi
    fi
    
    # download and build Sacrifice
    if [[ $commands =~ "sacrifice" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_sacrifice
	fi
	if [[ $commands =~ "build" ]]; then
	    build_sacrifice
	fi
    fi

    # download and build ROOT
    if [[ $commands =~ "root" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_root
	fi
	if [[ $commands =~ "build" ]]; then
	    build_root
	fi
    fi

    # download and build Delphes
    if [[ $commands =~ "delphes" ]]; then
	if [[ $commands =~ "download" ]]; then
	    download_delphes
	fi
	if [[ $commands =~ "build" ]]; then
	    build_delphes
	fi
    fi
}

### HepMC ###
download_hepmc() {
    mkdir -p $TP7_SOURCE
    echo "--- Downloading HepMC ---" && \
	curl -k -L -O http://lcgapp.cern.ch/project/simu/HepMC/download/HepMC-2.06.09.tar.gz && \
	echo "--- Extracting HepMC ---" && \
	tar -zxf HepMC-2.06.09.tar.gz -C $TP7_SOURCE && \
	rm HepMC-2.06.09.tar.gz
}
build_hepmc() {
    SOURCE=$TP7_SOURCE/HepMC-2.06.09
    INSTALL=$TP7_INSTALL/HepMC-2.06.09
    mkdir -p $INSTALL
    cd $SOURCE
    echo "--- Building HepMC ---" && \
	./configure --with-momentum=GEV --with-length=CM --prefix=$INSTALL \
	&& make && make install
    cd -
    rm -rf $TP7_INSTALL/HepMC
    ln -s $INSTALL $TP7_INSTALL/HepMC
}

### Pythia6 ###
download_pythia6() {
    mkdir -p $TP7_SOURCE/pythia-6.4.28
    echo "--- Downloading Pythia6 ---" && \
	curl -k -L -O https://pythiasix.hepforge.org/downloads/pythia-6.4.28.tgz && \
	echo "--- Extracting Pythia6 ---" && \
	tar -zxf pythia-6.4.28.tgz -C $TP7_SOURCE/pythia-6.4.28 && \
	rm pythia-6.4.28.tgz
}
build_pythia6() {
    SOURCE=$TP7_SOURCE/pythia-6.4.28
    INSTALL=$TP7_INSTALL/pythia-6.4.28
    mkdir -p $INSTALL/lib
    cd $SOURCE
    echo "--- Building Pythia6 ---" && \
	make lib && \
	echo "--- Installing Pythia6 ---" && \
	cp libpythia.a $INSTALL/lib/libpythia6.a && \
	ln -sf $INSTALL/lib/libpythia6.a $INSTALL/lib/libpythia6.so && \
	touch $INSTALL/lib/libpythia6_dummy.so && \
	touch $INSTALL/lib/libpythia6_pdfdummy.so && \
	ln -sf $INSTALL/lib/libpythia6.a $INSTALL/lib/libpythia6.dylib && \
	touch $INSTALL/lib/libpythia6.a $INSTALL/lib/libpythia6_dummy.dylib
	touch $INSTALL/lib/libpythia6.a $INSTALL/lib/libpythia6_pdfdummy.dylib
    cd -
    rm -rf $TP7_INSTALL/Pythia6
    ln -s $INSTALL $TP7_INSTALL/Pythia6    
}

### Pythia8 ###
download_pythia8() {
    mkdir -p $TP7_SOURCE
    echo "--- Downloading Pythia8 ---" && \
	curl -k -L -O http://home.thep.lu.se/~torbjorn/pythia8/pythia8235.tgz && \
	echo "--- Extracting Pythia8 ---" && \
	tar -zxf pythia8235.tgz -C $TP7_SOURCE && \
	rm pythia8235.tgz
}
build_pythia8() {
    SOURCE=$TP7_SOURCE/pythia8235
    INSTALL=$TP7_INSTALL/pythia8235
    mkdir -p $INSTALL
    cd $SOURCE
    echo "--- Building Pythia8 ---" && \
	./configure --enable-shared --with-hepmc2=$HEPMC_ROOT --with-lhapdf6=$LHAPDF_ROOT --prefix=$INSTALL && \
	make && make install 
    cd -
    rm -rf $TP7_INSTALL/Pythia8 
    ln -s $INSTALL $TP7_INSTALL/Pythia8 
}

### LHAPDF ###
download_lhapdf() {
    mkdir -p $TP7_SOURCE
    echo "--- Downloading LHAPDF ---" && \
	curl -k -L -O https://lhapdf.hepforge.org/downloads/LHAPDF-6.2.1.tar.gz
	echo "--- Extracting LHAPDF ---" && \
	tar -zxf LHAPDF-6.2.1.tar.gz -C $TP7_SOURCE && \
	rm LHAPDF-6.2.1.tar.gz
}
build_lhapdf() {
    SOURCE=$TP7_SOURCE/LHAPDF-6.2.1
    INSTALL=$TP7_INSTALL/LHAPDF-6.2.1
    mkdir -p $INSTALL
    cd $SOURCE
    echo "--- Building LHAPDF ---" && \
	./configure --prefix=$INSTALL && \
	make && make install
    cd -
    rm -rf $TP7_INSTALL/LHAPDF
    ln -s $INSTALL $TP7_INSTALL/LHAPDF
}

### AGILe ###
download_agile() {
    mkdir -p $TP7_SOURCE
    echo "--- Downloading AGILe ---" && \
	curl -k -L -O https://agile.hepforge.org/downloads/AGILe-1.5.0b1.tar.gz
	echo "--- Extracting AGILe ---" && \
	tar -zxf AGILe-1.5.0b1.tar.gz -C $TP7_SOURCE && \
	rm AGILe-1.5.0b1.tar.gz
}
build_agile() {
    SOURCE=$TP7_SOURCE/AGILe-1.5.0b1
    INSTALL=$TP7_INSTALL/AGILe-1.5.0b1
    mkdir -p $INSTALL
    cd $SOURCE
    echo "--- Building AGILe ---" && \
	./configure --with-hepmc=$HEPMC_ROOT --prefix=$INSTALL && \
	make && make install
    cd -
    rm -rf $TP7_INSTALL/AGILe
    ln -s $INSTALL $TP7_INSTALL/AGILe
}

### Sacrifice ###
download_sacrifice() {
    mkdir -p $TP7_SOURCE
    echo "--- Downloading Sacrifice ---" && \
	curl -k -L -O https://agile.hepforge.org/downloads/Sacrifice-1.1.2.tar.gz
	echo "--- Extracting Sacrifice ---" && \
	tar -zxf Sacrifice-1.1.2.tar.gz -C $TP7_SOURCE && \
	rm Sacrifice-1.1.2.tar.gz
}
build_sacrifice() {
    SOURCE=$TP7_SOURCE/Sacrifice-1.1.2
    INSTALL=$TP7_INSTALL/Sacrifice-1.1.2
    mkdir -p $INSTALL
    cd $SOURCE
    echo "--- Building Sacrifice ---" && \
	autoreconf -ivf && \
	./configure --with-HepMC=$HEPMC_ROOT --with-LHAPDF=$LHAPDF_ROOT --with-pythia=$PYTHIA8_ROOT --prefix=$INSTALL && \
	make && make install
    cd -
    rm -rf $TP7_INSTALL/Sacrifice
    ln -s $INSTALL $TP7_INSTALL/Sacrifice
}

### ROOT ###
download_root() {
    mkdir -p $TP7_SOURCE
    echo "--- Downloading ROOT ---" && \
	curl -k -L -O https://root.cern.ch/download/root_v6.14.04.source.tar.gz && \
	echo "--- Extracting ROOT ---" && \
	tar zxf root_v6.14.04.source.tar.gz -C $TP7_SOURCE && \
	rm root_v6.14.04.source.tar.gz
}
build_root() {
    SOURCE=$TP7_SOURCE/root-6.14.04
    INSTALL=$TP7_INSTALL/root-6.14.04
    mkdir -p $INSTALL
    cd $SOURCE
    mkdir obj
    cd obj
    echo "--- Building ROOT ---" && \
	cmake $SOURCE -DCMAKE_INSTALL_PREFIX=$INSTALL -Dpythia6_nolink=ON -DPYTHIA8_DATA=$PYTHIA8DATA && \
	make && make install && cd ..    
    cd -
    rm -rf $TP7_INSTALL/ROOT
    ln -s $INSTALL $TP7_INSTALL/ROOT
}

### Delphes ###
download_delphes() {
    mkdir -p $TP7_SOURCE
    echo "--- Downloading Delphes ---" && \
	curl -k -L -O http://cp3.irmp.ucl.ac.be/downloads/Delphes-3.4.1.tar.gz && \
	echo "--- Extracting Delphes ---" && \
	tar zxf Delphes-3.4.1.tar.gz -C $TP7_SOURCE && \
	rm Delphes-3.4.1.tar.gz
}
build_delphes() {
    SOURCE=$TP7_SOURCE/Delphes-3.4.1
    INSTALL=$TP7_INSTALL/Delphes-3.4.1
    ### apply patches
    patch $SOURCE/modules/TreeWriter.cc patches/Delphes-3.4.1/modules/TreeWriter.cc.patch

    mkdir -p $INSTALL
    cd $SOURCE
    mkdir obj
    cd obj
    echo "--- Building Delphes ---" && \
	cmake $SOURCE -DCMAKE_POLICY_DEFAULT_CMP0074=NEW -DCMAKE_INSTALL_PREFIX=$INSTALL && \
	make && make install && cd ..    
    cd -
    rm -rf $TP7_INSTALL/Delphes
    ln -s $INSTALL $TP7_INSTALL/Delphes
}



main $@
