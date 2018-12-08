pl=$1
echo $pl
run=$2
echo $run
mg_output_path="/afs/cern.ch/work/c/christiw/public/LLP/mg5_amc_output/ppTohToSS1SS2_SS1Tobb_SS2Toveve"
card="/afs/cern.ch/work/c/christiw/programs/DelphesTiming/cards/delphes_card_CMS.tcl"
#gunzip Events/${run}/unweighted_events.lhe.gz
python $mg_output_path/bin/internal/lhe_parser.py ${mg_output_path}/Events/${run}/unweighted_events.lhe.gz ${mg_output_path}/Events/${run}/unweighted_events_pl_${pl}.lhe $pl
gzip $mg_output_path/Events/$run/unweighted_events_pl_${pl}.lhe
mv $mg_output_path/Events/$run/unweighted_events_pl_${pl}.lhe.gz $mg_output_path/Events/$run/unweighted_events.lhe.gz
./bin/madevent pythia8 ${run} --tag=pl_$pl
gunzip Events/${run}/pl_${pl}_pythia8_events.hepmc.gz
/afs/cern.ch/work/c/christiw/programs/DelphesTiming/DelphesHepMC ${card} /afs/cern.ch/work/c/christiw/public/LLP/Delphes_output/${run}_pl_${pl}.root ${mg_output_path}/Events/${run}/pl_${pl}_pythia8_events.hepmc
