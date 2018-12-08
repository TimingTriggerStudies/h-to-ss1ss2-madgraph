# h-to-ss1ss2-madgraph
Repo for generating the LHE files for h-to-ss1ss2 model to input to CMSSW
Also generates Delphes ROOT files to check if the LHE file makes sense

## LHE file Generation

### Generation of the Madgraph Output Directory
```bash
./bin/mg5_amC
generate p p > h > SS1 SS2, SS1 > b b~, SS2 > ve ve~
output mg5_amc_output/ppTohToSS1SS2_SS1Tobb_SS2Toveve
```
This creates the ```mg5_amc_output/ppTohToSS1SS2_SS1Tobb_SS2Toveve``` directory

### Create Events
Then run MadGraph with an input scan file, the creates runs with the specified number of events, decay width(GeV) and mass(GeV) of the LLP 
```bash
./bin/mg5_amC h-to-ss1ss2_m_scan.txt
```
The decay width doesn't actually matter in Madgraph, so it's set to a constant of 0.001GeV, and the decay length will be changed later by directly changing the LHE file event by event. 

## LHE file Modification & Verification
### Modification
To change the decay length of the LHE file, and pass the LHE file to run pythia and Delphes to create a ROOT file where we can visualiz the result:
```bash
. rerun_pythia.sh 10 "run_m60_w0p001"
```
First argument gives the proper lifetime (c&tau;) in mm.
Second argument is the name of the run directory.

After running this, an output ROOT file ```Delphes_output/run_m60_w0p001_pl_10.root``` is created.

### Verification
To plot the historgram of the decay length of the LLPs:
```bash
Delphes->Draw("sqrt( Particle.X*Particle.X + Particle.Y*Particle.Y+Particle.Z*Particle.Z)/(sqrt(Particle.Px[Particle.M1]*Particle.Px[Particle.M1] + Particle.Py[Particle.M1]*Particle.Py[Particle.M1]+Particle.Pz[Particle.M1]*Particle.Pz[Particle.M1])/Particle.E[Particle.M1]*1./sqrt(1-(Particle.Px[Particle.M1]*Particle.Px[Particle.M1] + Particle.Py[Particle.M1]*Particle.Py[Particle.M1]+Particle.Pz[Particle.M1]*Particle.Pz[Particle.M1])/(Particle.E[Particle.M1]*Particle.E[Particle.M1])))", "Particle.PID==5 && Particle.Status==23")
```
This should be an exponential with decaying length equal to the first argument given when ```rerun_pythia.sh``` is run
