# h-to-ss1ss2-madgraph
Repo for generating the LHE files for h-to-ss1ss2 model to input to CMSSW.
Also generates Delphes ROOT files to check if the LHE file makes sense

## LHE file Generation

### Generation of the Madgraph Output Directory
```bash
./bin/mg5_amC
import model SM-HS1S2
generate p p > h > SS1 SS2, SS1 > b b~, SS2 > ve ve~
output mg5_amc_output/ppTohToSS1SS2_SS1Tobb_SS2Toveve
```
This creates the ```mg5_amc_output/ppTohToSS1SS2_SS1Tobb_SS2Toveve``` directory

#### ggH with ISR:
```bash
generate p p > h > SS1 SS2, SS1 > b b~, SS2 > ve ve~
add process p p > h j, (h > SS1 SS2, SS1 > b b~, SS2 > ve ve~)
```
#### VBFH with ISR
```bash
generate p p > j j h / g QCD=0 QED=3 HIG=0 , (h > SS1 SS2, SS1 > b b~,SS2 > ve ve~) 
add process p p > j j j h / g QCD=1 QED=3 HIG=0 , (h > SS1 SS2, SS1 > b b~,SS2 > ve ve~) 

```

#### WH & ZH
```bash
define w = w+ w-
generate p p > w h, (h > SS1 SS2, SS1 > b b~, SS2 > ve ve~)
add process p p > w j h, (h > SS1 SS2, SS1 > b b~, SS2 > ve ve~)
add process p p > z h, (h > SS1 SS2, SS1 > b b~, SS2 > ve ve~) 
add process p p > z j h, (h > SS1 SS2, SS1 > b b~, SS2 > ve ve~) 

```

### Create Events
Launch Madgraph to generate events.

Can run the command below to automatically create multiple runs with the specified number of events, decay width(GeV) and mass(GeV) of the LLP:
```bash
./bin/mg5_amC h-to-ss1ss2_m_scan.txt
```
The decay width doesn't actually matter in Madgraph, so it's set to a constant of 0.001GeV, and the decay length will be changed later by directly changing the LHE file event by event. 

## LHE file Modification & Verification
### Modification
Run the following command to change the decay length of the LHE file, and pass the LHE file to run pythia and Delphes to create a ROOT file where we can visualiz the result:
```bash
. rerun_pythia.sh 10 "run_m50_w0p001"
```
First argument gives the proper lifetime (c&tau;) in mm.

Second argument is the name of the run directory.

#### Three steps are performed in ```rerun_pythia.sh```:

1. Run the python script ```lhe_parser.py``` to modify the LHE file:
```bash
python bin/internal/lhe_parser.py input.lhe.gz output.lhe c&tau;
```
2. Use madevent to run pythia on the existing run. Have to rename and gzip the modified LHE file ```output.lhe``` to ```unweighted_events.lhe.gz``` for pythia8 to recognize and run it. This processes produces a ```.hepmc``` file that Delphes will take as input:
```bash
./bin/madevent pythia8 run_name --tag=tag_name
```
3. Run Delphes using the default CMS card. An output ROOT file is created:
```bash
/DelphesTiming/DelphesHepMC cards/delphes_card_CMS.tcl output.root input.hepmc
```

### Verification
Open the output ROOT file from Delphes and plot the historgram of the decay length of the LLPs:
```bash
Delphes->Draw("sqrt( Particle.X*Particle.X + Particle.Y*Particle.Y+Particle.Z*Particle.Z)/(sqrt(Particle.Px[Particle.M1]*Particle.Px[Particle.M1] + Particle.Py[Particle.M1]*Particle.Py[Particle.M1]+Particle.Pz[Particle.M1]*Particle.Pz[Particle.M1])/Particle.E[Particle.M1]*1./sqrt(1-(Particle.Px[Particle.M1]*Particle.Px[Particle.M1] + Particle.Py[Particle.M1]*Particle.Py[Particle.M1]+Particle.Pz[Particle.M1]*Particle.Pz[Particle.M1])/(Particle.E[Particle.M1]*Particle.E[Particle.M1])))", "Particle.PID==5 && Particle.Status==23")
```
This should be an exponential with decaying length equal to the first argument (c&tau;) given when ```rerun_pythia.sh``` is run

## Pass through CMSSW to get AOD files
Get the modified LHE files.
Put the LHE files in: /store/group/phys_susy/razor/christiw/ppTohToSS1SS2_SS1Tobb_SS2Toveve_ggh_withISR_LHE/
crab config files
MC_production output: 


