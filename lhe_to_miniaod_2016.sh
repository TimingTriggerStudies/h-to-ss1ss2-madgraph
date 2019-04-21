#!/bin/bash

#Format: bash lhe_to_miniaod_test.sh [step] [mass] [pl]
STEP=$1
MH=$2
MX=$3
RUN=run_mh${MH}_mx${MX}_ev${N_EV}
PL=$4
N_EV=$5
mode=$6
root_file_step0=root://cms-xrd-global.cern.ch//store//user/christiw/ppTohToSS1SS2_SS1Tobb_SS2Toveve_MC_prod/ppTohToSS1SS2_SS1Tobb_SS2Toveve_run_m50_w0p001_pl_10_step0/crab_CMSSW_7_6_3_ppTohToSS1SS2_SS1Tobb_SS2Toveve_run_m50_w0p001_pl_10_GENSIM_CaltechT2/190108_064437/0000/ppTohToSS1SS2_SS1Tobb_SS2Toveve_run_m50_w0p001_pl_10_step0_1.root
OUTPUT_FILE=ppTohToSS1SS2_SS1Tobb_SS2Toveve_${mode}_withISR
lhe_file=root://cms-xrd-global.cern.ch//store/user/christiw/RunIISummer16_withISR/LHE_files/${OUTPUT_FILE}/unweighted_events_mh${MH}_mx${MX}_pl${PL}_ev${N_EV}.lhe
#lhe_file=/afs/cern.ch/work/c/christiw/public/LLP/mg5_amc_output_new/test_crab/Events/run_mh500_mx200_ev100/unweighted_events_mh500_mx200_pl1000_ev100.lhe
#lhe_file=/afs/cern.ch/work/c/christiw/public/LLP/mg5_amc_output_new/test_crab/ppTohToSS1SS2_SS1Tobb_SS2Toveve_vh_ISR/Events/run_mh500_mx200_ev100/unweighted_events_mh500_mx200_pl1000_ev100.lhe
LHE_OUTPUT=${OUTPUT_FILE}_mh${MH}_mx${MX}_pl${PL}_ev${N_EV}
OUTPUT_DIR=/afs/cern.ch/work/c/christiw/public/LLP/miniaod_sim/config/RunIISummer16_withISR/${OUTPUT_FILE}/
if [ $STEP -eq 0 ] 
then
cd /afs/cern.ch/work/c/christiw/public/releases/CMSSW_7_6_3/src
eval `scramv1 runtime -sh`
cmsDriver.py Configuration/Generator/python/ppTohToSS1SS2_SS1Tobb_SS2Toveve.py --filein ${lhe_file} --fileout file:${OUTPUT_FILE}_step0.root --step GEN,SIM --conditions 76X_mcRun2_asymptotic_v12 --no_exec --eventcontent RAWSIM --datatier GEN-SIM --mc --era Run2_25ns -n ${N_EV}  --python_filename ${OUTPUT_DIR}${LHE_OUTPUT}_step0_cfg.py
#sed -i "s/t.outputCommands/t.outputCommands + ['keep *_genParticles_xyz0_*', 'keep *_genParticles_t0_*',]/g" ${OUTPUT_DIR}${LHE_OUTPUT}_step0_cfg.py
#cmsRun ${OUTPUT_DIR}${LHE_OUTPUT}_step0_cfg.py
cd /afs/cern.ch/work/c/christiw/public/LLP/
echo "step 0 completed"

#step 1, from GENSIm to DIGI-RECO
elif [ $STEP -eq 1 ] 
then
cd /afs/cern.ch/work/c/christiw/public/releases/CMSSW_8_0_21/src
eval `scramv1 runtime -sh`
cmsDriver.py step1 --filein file:${OUTPUT_DIR}${OUTPUT_FILE}_step0.root --fileout file:${OUTPUT_FILE}_step1.root  --pileup_input "dbs:/Neutrino_E-10_gun/RunIISpring15PrePremix-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v2-v2/GEN-SIM-DIGI-RAW" --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step DIGIPREMIX_S2,DATAMIX,L1,DIGI2RAW,HLT:@frozen2016 --nThreads 1 --datamix PreMix --era Run2_2016 --python_filename ${OUTPUT_DIR}${OUTPUT_FILE}_step1_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n ${N_EV}
#sed -i "s/t.outputCommands/t.outputCommands + ['keep *_genParticles_xyz0_*', 'keep *_genParticles_t0_*',]/g" ${OUTPUT_DIR}${OUTPUT_FILE}_step1_cfg.py
#cmsRun ${OUTPUT_DIR}${OUTPUT_FILE}_step1_cfg.py
cd /afs/cern.ch/work/c/christiw/public/LLP/
echo "step 1 completed"

#====== step 2, from DR to AODSIM
elif [ $STEP -eq 2 ]
then
cd /afs/cern.ch/work/c/christiw/public/releases/CMSSW_8_0_21/src
eval `scramv1 runtime -sh`
cmsDriver.py step2 --filein file:${OUTPUT_DIR}${OUTPUT_FILE}_step1.root --fileout file:${OUTPUT_FILE}_step2.root --mc --eventcontent AODSIM --runUnscheduled --datatier AODSIM --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step RAW2DIGI,RECO,EI --nThreads 1 --era Run2_2016 --python_filename ${OUTPUT_DIR}${OUTPUT_FILE}_step2_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n ${N_EV}
#sed -i "s/t.outputCommands/t.outputCommands + ['keep *_genParticles_xyz0_*', 'keep *_genParticles_t0_*',]/g" ${OUTPUT_DIR}${OUTPUT_FILE}_step2_cfg.py
cmsRun ${OUTPUT_DIR}${OUTPUT_FILE}_step2_cfg.py
cd /afs/cern.ch/work/c/christiw/public/LLP/
#====== step 3, from AODSIM to MINIAODSIM
elif [ $STEP -eq 3 ]
then
cd /afs/cern.ch/work/c/christiw/public/releases/CMSSW_9_3_6/src
eval `scramv1 runtime -sh`
cmsDriver.py step3 --filein file:${OUTPUT_DIR}${OUTPUT_FILE}_step2.root --fileout file:${OUTPUT_DIR}${OUTPUT_FILE}_step3.root --mc --eventcontent MINIAODSIM --runUnscheduled --datatier MINIAODSIM --conditions 80X_mcRun2_asymptotic_2016_TrancheIV_v6 --step PAT --nThreads 8 --era Run2_2016,run2_miniAOD_80XLegacy --python_filename ${OUTPUT_DIR}${OUTPUT_FILE}_step3_cfg.py --no_exec --customise Configuration/DataProcessing/Utils.addMonitoring -n ${N_EV}
cd /afs/cern.ch/work/c/christiw/public/LLP/
fi
#cmsRun ${OUTPUT_DIR}${OUTPUT_FILE}_step3_cfg.py
