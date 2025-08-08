
% Increase counter:

if (exist('idx', 'var'));
  idx = idx + 1;
else;
  idx = 1;
end;

% Version, title and date:

VERSION                   (idx, [1:  13]) = 'Serpent 2.2.1' ;
COMPILE_DATE              (idx, [1:  20]) = 'Aug  7 2024 16:40:12' ;
DEBUG                     (idx, 1)        = 0 ;
TITLE                     (idx, [1:   5]) = 'N-1.1' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:   5]) = 'input' ;
WORKING_DIRECTORY         (idx, [1: 115]) = '/home/staff/r/rok.krpan/OpenFOAM/rok.krpan-v2312/run/MoltenSaltReactor/progression_problems/N_1/N_1_1/Serpent2/run2' ;
HOSTNAME                  (idx, [1:  27]) = 'nuen-mj0jdqvh.engr.tamu.edu' ;
CPU_TYPE                  (idx, [1:  36]) = '12th Gen Intel(R) Core(TM) i7-12700T' ;
CPU_MHZ                   (idx, 1)        = 53.0 ;
START_DATE                (idx, [1:  24]) = 'Thu Oct 17 17:43:40 2024' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Thu Oct 17 17:57:03 2024' ;

% Run parameters:

POP                       (idx, 1)        = 100000 ;
CYCLES                    (idx, 1)        = 100 ;
SKIP                      (idx, 1)        = 10 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1729205020055 ;
UFS_MODE                  (idx, 1)        = 0 ;
UFS_ORDER                 (idx, 1)        = 1.00000 ;
NEUTRON_TRANSPORT_MODE    (idx, 1)        = 1 ;
PHOTON_TRANSPORT_MODE     (idx, 1)        = 0 ;
GROUP_CONSTANT_GENERATION (idx, 1)        = 1 ;
B1_CALCULATION            (idx, [1:  3])  = [ 0 0 0 ] ;
B1_IMPLICIT_LEAKAGE       (idx, 1)        = 0 ;
B1_BURNUP_CORRECTION      (idx, 1)        = 0 ;

CRIT_SPEC_MODE            (idx, 1)        = 0 ;
IMPLICIT_REACTION_RATES   (idx, 1)        = 1 ;

% Optimization:

OPTIMIZATION_MODE         (idx, 1)        = 4 ;
RECONSTRUCT_MICROXS       (idx, 1)        = 1 ;
RECONSTRUCT_MACROXS       (idx, 1)        = 1 ;
DOUBLE_INDEXING           (idx, 1)        = 0 ;
MG_MAJORANT_MODE          (idx, 1)        = 0 ;

% Parallelization:

MPI_TASKS                 (idx, 1)        = 1 ;
OMP_THREADS               (idx, 1)        = 20 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  20]) = [  1.01319E+00  1.00853E+00  1.01617E+00  9.94819E-01  9.71836E-01  1.00025E+00  9.91329E-01  9.96289E-01  1.02066E+00  1.00542E+00  9.82126E-01  9.77997E-01  1.01318E+00  1.00478E+00  1.00035E+00  1.01275E+00  1.01359E+00  1.00630E+00  9.83657E-01  9.86769E-01  ];
SHARE_BUF_ARRAY           (idx, 1)        = 0 ;
SHARE_RES2_ARRAY          (idx, 1)        = 1 ;
OMP_SHARED_QUEUE_LIM      (idx, 1)        = 0 ;

% File paths:

XS_DATA_FILE_PATH         (idx, [1:  73]) = '/home/staff/r/rok.krpan/opt/serpent2/cross_sections/xsdata/endfb71.xsdata' ;
DECAY_DATA_FILE_PATH      (idx, [1:   3]) = 'N/A' ;
SFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
NFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
BRA_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;

% Collision and reaction sampling (neutrons/photons):

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 1.9E-09  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.19879E-03 0.00153  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.97801E-01 3.4E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  9.02115E-01 1.1E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  9.02138E-01 1.1E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  2.12605E+00 6.4E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  6.75098E-01 4.2E-06  3.23876E-01 8.8E-06  1.02580E-03 0.00024  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  1.52452E+02 0.00015  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  1.52452E+02 0.00015  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  1.65377E+01 0.00014  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  3.32872E-01 0.00164  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 100 ;
SIMULATED_HISTORIES       (idx, 1)        = 9999879 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  9.99988E+04 0.00067 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  9.99988E+04 0.00067 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  2.57140E+02 ;
RUNNING_TIME              (idx, 1)        =  1.33992E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  2.77833E-02  2.77833E-02 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  6.83331E-04  6.83331E-04 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  1.33707E+01  1.33707E+01  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  1.33976E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 19.19069 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  1.92262E+01 0.00248 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  9.83729E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 31772.43 ;
ALLOC_MEMSIZE             (idx, 1)        = 1324.46 ;
MEMSIZE                   (idx, 1)        = 1107.83 ;
XS_MEMSIZE                (idx, 1)        = 402.63 ;
MAT_MEMSIZE               (idx, 1)        = 22.20 ;
RES_MEMSIZE               (idx, 1)        = 14.92 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 668.08 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 216.63 ;

% Geometry parameters:

TOT_CELLS                 (idx, 1)        = 10 ;
UNION_CELLS               (idx, 1)        = 8 ;

% Neutron energy grid:

NEUTRON_ERG_TOL           (idx, 1)        =  0.00000E+00 ;
NEUTRON_ERG_NE            (idx, 1)        = 263747 ;
NEUTRON_EMIN              (idx, 1)        =  1.00000E-11 ;
NEUTRON_EMAX              (idx, 1)        =  2.00000E+01 ;

% Unresolved resonance probability table sampling:

URES_DILU_CUT             (idx, 1)        =  1.00000E-09 ;
URES_EMIN                 (idx, 1)        =  1.00000E+37 ;
URES_EMAX                 (idx, 1)        = -1.00000E+37 ;
URES_AVAIL                (idx, 1)        = 8 ;
URES_USED                 (idx, 1)        = 0 ;

% Nuclides and reaction channels:

TOT_NUCLIDES              (idx, 1)        = 17 ;
TOT_TRANSPORT_NUCLIDES    (idx, 1)        = 17 ;
TOT_DOSIMETRY_NUCLIDES    (idx, 1)        = 0 ;
TOT_DECAY_NUCLIDES        (idx, 1)        = 0 ;
TOT_PHOTON_NUCLIDES       (idx, 1)        = 0 ;
TOT_REA_CHANNELS          (idx, 1)        = 522 ;
TOT_TRANSMU_REA           (idx, 1)        = 0 ;

% Neutron physics options:

USE_DELNU                 (idx, 1)        = 1 ;
USE_URES                  (idx, 1)        = 0 ;
USE_DBRC                  (idx, 1)        = 0 ;
IMPL_CAPT                 (idx, 1)        = 0 ;
IMPL_NXN                  (idx, 1)        = 1 ;
IMPL_FISS                 (idx, 1)        = 0 ;
DOPPLER_PREPROCESSOR      (idx, 1)        = 0 ;
TMS_MODE                  (idx, 1)        = 0 ;
SAMPLE_FISS               (idx, 1)        = 1 ;
SAMPLE_CAPT               (idx, 1)        = 1 ;
SAMPLE_SCATT              (idx, 1)        = 1 ;

% Energy deposition:

EDEP_MODE                 (idx, 1)        = 0 ;
EDEP_DELAYED              (idx, 1)        = 1 ;
EDEP_KEFF_CORR            (idx, 1)        = 1 ;
EDEP_LOCAL_EGD            (idx, 1)        = 0 ;
EDEP_COMP                 (idx, [1:   9]) = [ 0 0 0 0 0 0 0 0 0 ] ;
EDEP_CAPT_E               (idx, 1)        =  0.00000E+00 ;

% Radioactivity data:

TOT_ACTIVITY              (idx, 1)        =  0.00000E+00 ;
TOT_DECAY_HEAT            (idx, 1)        =  0.00000E+00 ;
TOT_SF_RATE               (idx, 1)        =  0.00000E+00 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  0.00000E+00 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  0.00000E+00 ;
INGESTION_TOXICITY        (idx, 1)        =  0.00000E+00 ;
ACTINIDE_INH_TOX          (idx, 1)        =  0.00000E+00 ;
ACTINIDE_ING_TOX          (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  0.00000E+00 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  0.00000E+00 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  4.05957E+07 0.00034  0.00000E+00 0.0E+00 ];

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  1.55106E-01 0.00131 ];
U235_FISS                 (idx, [1:   4]) = [  1.60402E+12 0.00049  9.99523E-01 1.1E-05 ];
U238_FISS                 (idx, [1:   4]) = [  7.31911E+08 0.02447  4.55993E-04 0.02435 ];
U235_CAPT                 (idx, [1:   4]) = [  3.46220E+11 0.00114  1.40048E-01 0.00103 ];
U238_CAPT                 (idx, [1:   4]) = [  2.96952E+11 0.00123  1.20118E-01 0.00107 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 9999879 1.00000E+07 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 4.28041E+04 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 9999879 1.00428E+07 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 6063645 6.08969E+06 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 3936234 3.95312E+06 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 9999879 1.00428E+07 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -1.58884E-06 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   2]) = [  5.20000E+01 0.0E+00 ];
TOT_POWDENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_GENRATE               (idx, [1:   2]) = [  3.91024E+12 9.2E-08 ];
TOT_FISSRATE              (idx, [1:   2]) = [  1.60456E+12 5.9E-09 ];
TOT_CAPTRATE              (idx, [1:   2]) = [  2.47077E+12 0.00012 ];
TOT_ABSRATE               (idx, [1:   2]) = [  4.07533E+12 7.5E-05 ];
TOT_SRCRATE               (idx, [1:   2]) = [  4.05957E+12 0.00034 ];
TOT_FLUX                  (idx, [1:   2]) = [  1.55939E+15 0.00021 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  4.07533E+12 7.5E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  6.21447E+14 0.00021 ];
INI_FMASS                 (idx, 1)        =  0.00000E+00 ;
TOT_FMASS                 (idx, 1)        =  0.00000E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.80596E+00 0.00026 ];
SIX_FF_F                  (idx, [1:   2]) = [  5.80692E-01 0.00031 ];
SIX_FF_P                  (idx, [1:   2]) = [  8.24769E-01 0.00013 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.11379E+00 0.00018 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  9.63358E-01 0.00045 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  9.63358E-01 0.00045 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.43695E+00 9.7E-08 ];
FISSE                     (idx, [1:   2]) = [  2.02272E+02 5.0E-09 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  9.63399E-01 0.00047  9.57081E-01 0.00045  6.27740E-03 0.00642 ];
IMP_KEFF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  9.63227E-01 0.00034 ];
ABS_KEFF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.86072E+01 5.8E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.86063E+01 1.6E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  1.65985E-07 0.00108 ];
IMP_EALF                  (idx, [1:   2]) = [  1.66115E-07 0.00030 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  3.38517E-03 0.01449 ];
IMP_AFGE                  (idx, [1:   2]) = [  3.30356E-03 0.00063 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  6.79018E-03 0.00408  2.37081E-04 0.01937  1.23070E-03 0.00848  1.17031E-03 0.00877  2.62275E-03 0.00639  1.08060E-03 0.01060  4.48733E-04 0.01698 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  4.67822E-01 0.00593  1.33364E-02 1.6E-05  3.27375E-02 1.3E-05  1.20784E-01 8.1E-06  3.02810E-01 1.4E-05  8.49630E-01 3.2E-05  2.85333E+00 4.3E-05 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  6.53096E-03 0.00564  2.29039E-04 0.02937  1.19235E-03 0.01236  1.11435E-03 0.01271  2.53737E-03 0.00977  1.02518E-03 0.01491  4.32663E-04 0.02304 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  4.67189E-01 0.00872  1.33364E-02 2.0E-05  3.27379E-02 1.0E-05  1.20783E-01 1.0E-05  3.02804E-01 2.2E-05  8.49624E-01 5.6E-05  2.85342E+00 9.9E-05 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  3.74266E-04 0.00079  3.74274E-04 0.00078  3.73420E-04 0.00807 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  3.60560E-04 0.00062  3.60567E-04 0.00061  3.59735E-04 0.00802 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  6.51628E-03 0.00654  2.25426E-04 0.03122  1.18315E-03 0.01550  1.11642E-03 0.01700  2.52447E-03 0.01063  1.04619E-03 0.01657  4.20634E-04 0.02581 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  4.64929E-01 0.00957  1.33360E-02 0.0E+00  3.27373E-02 2.1E-05  1.20785E-01 1.4E-05  3.02810E-01 2.5E-05  8.49628E-01 5.0E-05  2.85339E+00 7.0E-05 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  3.55345E-04 0.02312  3.55441E-04 0.02312  3.36977E-04 0.03348 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  3.42371E-04 0.02311  3.42464E-04 0.02311  3.24691E-04 0.03347 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  6.10632E-03 0.03342  2.19478E-04 0.11768  1.13356E-03 0.04858  1.03319E-03 0.05886  2.34956E-03 0.04212  1.01913E-03 0.05504  3.51407E-04 0.09118 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  4.53254E-01 0.03392  1.33360E-02 0.0E+00  3.27390E-02 5.6E-09  1.20794E-01 7.7E-05  3.02832E-01 0.00015  8.49512E-01 2.6E-05  2.85300E+00 0.0E+00 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  6.14316E-03 0.03313  2.21290E-04 0.11769  1.14007E-03 0.04806  1.05270E-03 0.05760  2.34585E-03 0.04168  1.02907E-03 0.05417  3.54172E-04 0.08871 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  4.53061E-01 0.03338  1.33360E-02 0.0E+00  3.27390E-02 5.9E-09  1.20794E-01 7.8E-05  3.02821E-01 0.00011  8.49509E-01 2.2E-05  2.85300E+00 0.0E+00 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -1.71838E+01 0.02425 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  3.74277E-04 0.00055 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  3.60570E-04 0.00024 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  6.47485E-03 0.00428 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -1.73008E+01 0.00442 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  8.59821E-07 0.00021 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  3.09280E-05 0.00010  3.09284E-05 0.00010  3.08726E-05 0.00123 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  3.66229E-04 0.00035  3.66221E-04 0.00035  3.67575E-04 0.00402 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  8.27642E-01 0.00013  8.27867E-01 0.00014  7.96048E-01 0.00622 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.11267E+01 0.00781 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  1.52452E+02 0.00015  1.60344E+02 0.00025 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   1]) = '0' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  7.62993E+05 0.00225  3.66777E+06 0.00181  8.56131E+06 0.00061  1.62098E+07 0.00045  1.81116E+07 0.00032  1.81637E+07 0.00017  1.48412E+07 0.00013  1.21555E+07 0.00040  1.49408E+07 0.00012  1.47278E+07 9.9E-05  1.54334E+07 0.00016  1.52849E+07 8.1E-05  1.60837E+07 8.0E-05  1.58232E+07 0.00014  1.59294E+07 0.00014  1.40302E+07 0.00019  1.41548E+07 0.00013  1.41326E+07 0.00011  1.41017E+07 0.00018  2.81029E+07 0.00014  2.78971E+07 9.9E-05  2.07354E+07 0.00011  1.36903E+07 0.00012  1.64877E+07 0.00016  1.62211E+07 0.00022  1.39819E+07 0.00021  2.56305E+07 0.00023  5.52276E+06 0.00030  6.93540E+06 0.00015  6.24633E+06 0.00016  3.67486E+06 0.00030  6.40391E+06 0.00065  4.40565E+06 0.00039  3.84663E+06 0.00034  7.53391E+05 0.00049  7.46521E+05 0.00138  7.68306E+05 0.00046  7.91624E+05 0.00092  7.85312E+05 0.00053  7.76185E+05 0.00074  8.00905E+05 0.00094  7.55584E+05 0.00062  1.43369E+06 0.00029  2.32017E+06 0.00031  3.02530E+06 0.00073  8.62744E+06 0.00039  1.09664E+07 0.00025  1.50722E+07 0.00023  1.16956E+07 0.00053  9.08413E+06 0.00038  7.17580E+06 0.00059  8.23261E+06 0.00050  1.46069E+07 0.00070  1.79080E+07 0.00037  2.97255E+07 0.00059  3.71889E+07 0.00042  4.36162E+07 0.00048  2.28958E+07 0.00069  1.46547E+07 0.00060  9.60222E+06 0.00076  8.16119E+06 0.00044  7.73118E+06 0.00114  5.89461E+06 0.00060  3.87744E+06 0.00021  3.26326E+06 0.00087  2.97041E+06 0.00082  2.40868E+06 0.00140  1.66765E+06 0.00118  1.04992E+06 0.00166  3.26868E+05 0.00285 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  9.63227E-01 0.00042 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  9.71218E+14 0.00041  5.88183E+14 1.0E-04 ];
INF_FISS_FLX              (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  3.83949E-01 2.4E-05  4.22576E-01 1.1E-05 ];
INF_CAPT                  (idx, [1:   4]) = [  5.81798E-04 0.00046  3.24005E-03 8.9E-05 ];
INF_ABS                   (idx, [1:   4]) = [  7.50964E-04 0.00034  5.68875E-03 8.4E-05 ];
INF_FISS                  (idx, [1:   4]) = [  1.69166E-04 0.00012  2.44870E-03 0.00010 ];
INF_NSF                   (idx, [1:   4]) = [  4.12617E-04 0.00012  5.96676E-03 0.00010 ];
INF_NUBAR                 (idx, [1:   4]) = [  2.43912E+00 5.6E-07  2.43670E+00 8.3E-09 ];
INF_KAPPA                 (idx, [1:   4]) = [  2.02290E+02 4.4E-08  2.02270E+02 5.9E-09 ];
INF_INVV                  (idx, [1:   4]) = [  1.19251E-07 0.00014  2.08267E-06 9.1E-05 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  3.83198E-01 2.4E-05  4.16883E-01 1.4E-05 ];
INF_SCATT1                (idx, [1:   4]) = [  2.42367E-02 0.00035  1.21333E-02 0.00077 ];
INF_SCATT2                (idx, [1:   4]) = [  2.51963E-03 0.00280 -5.08852E-03 0.00192 ];
INF_SCATT3                (idx, [1:   4]) = [  4.45083E-04 0.00556 -4.54642E-03 0.00126 ];
INF_SCATT4                (idx, [1:   4]) = [ -2.99029E-04 0.01544 -5.17751E-03 0.00086 ];
INF_SCATT5                (idx, [1:   4]) = [  1.38127E-04 0.02490 -3.02819E-03 0.00115 ];
INF_SCATT6                (idx, [1:   4]) = [ -4.64288E-04 0.00384 -4.88277E-03 0.00057 ];
INF_SCATT7                (idx, [1:   4]) = [  1.60820E-04 0.01922 -6.48188E-04 0.00387 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  3.83216E-01 2.4E-05  4.16883E-01 1.4E-05 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.42414E-02 0.00035  1.21333E-02 0.00077 ];
INF_SCATTP2               (idx, [1:   4]) = [  2.52048E-03 0.00281 -5.08852E-03 0.00192 ];
INF_SCATTP3               (idx, [1:   4]) = [  4.45158E-04 0.00559 -4.54642E-03 0.00126 ];
INF_SCATTP4               (idx, [1:   4]) = [ -2.99041E-04 0.01546 -5.17751E-03 0.00086 ];
INF_SCATTP5               (idx, [1:   4]) = [  1.38136E-04 0.02494 -3.02819E-03 0.00115 ];
INF_SCATTP6               (idx, [1:   4]) = [ -4.64285E-04 0.00385 -4.88277E-03 0.00057 ];
INF_SCATTP7               (idx, [1:   4]) = [  1.60781E-04 0.01921 -6.48188E-04 0.00387 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  3.37820E-01 7.9E-05  4.08972E-01 2.7E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  9.86718E-01 7.9E-05  8.15052E-01 2.7E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  7.33072E-04 0.00036  5.68875E-03 8.4E-05 ];
INF_REMXS                 (idx, [1:   4]) = [  5.37920E-03 0.00019  7.64326E-03 0.00023 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_I135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MACRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison universe-averaged densities:

I135_ADENS                (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
XE135_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM147_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148M_ADENS              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
SM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Poison decay constants:

PM147_LAMBDA              (idx, 1)        =  0.00000E+00 ;
PM148_LAMBDA              (idx, 1)        =  0.00000E+00 ;
PM148M_LAMBDA             (idx, 1)        =  0.00000E+00 ;
PM149_LAMBDA              (idx, 1)        =  0.00000E+00 ;
I135_LAMBDA               (idx, 1)        =  0.00000E+00 ;
XE135_LAMBDA              (idx, 1)        =  0.00000E+00 ;
XE135M_LAMBDA             (idx, 1)        =  0.00000E+00 ;
I135_BR                   (idx, 1)        =  0.00000E+00 ;

% Fission spectra:

INF_CHIT                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHIP                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHID                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

INF_S0                    (idx, [1:   8]) = [  3.78570E-01 2.3E-05  4.62887E-03 0.00022  1.95080E-03 0.00037  4.14932E-01 1.3E-05 ];
INF_S1                    (idx, [1:   8]) = [  2.53420E-02 0.00034 -1.10531E-03 0.00044 -1.67001E-04 0.00325  1.23003E-02 0.00078 ];
INF_S2                    (idx, [1:   8]) = [  2.69179E-03 0.00250 -1.72153E-04 0.00318 -1.41689E-04 0.00244 -4.94683E-03 0.00204 ];
INF_S3                    (idx, [1:   8]) = [  4.86747E-04 0.00538 -4.16643E-05 0.01208 -5.33635E-05 0.00740 -4.49305E-03 0.00130 ];
INF_S4                    (idx, [1:   8]) = [ -2.60667E-04 0.01695 -3.83624E-05 0.01551 -3.20848E-05 0.00752 -5.14543E-03 0.00086 ];
INF_S5                    (idx, [1:   8]) = [  1.38965E-04 0.02418 -8.38076E-07 0.49015 -6.78311E-06 0.07455 -3.02140E-03 0.00108 ];
INF_S6                    (idx, [1:   8]) = [ -4.37590E-04 0.00468 -2.66981E-05 0.01646 -2.29077E-05 0.00623 -4.85986E-03 0.00057 ];
INF_S7                    (idx, [1:   8]) = [  1.33724E-04 0.02333  2.70968E-05 0.00782  9.17129E-06 0.03343 -6.57360E-04 0.00339 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  3.78587E-01 2.3E-05  4.62887E-03 0.00022  1.95080E-03 0.00037  4.14932E-01 1.3E-05 ];
INF_SP1                   (idx, [1:   8]) = [  2.53467E-02 0.00034 -1.10531E-03 0.00044 -1.67001E-04 0.00325  1.23003E-02 0.00078 ];
INF_SP2                   (idx, [1:   8]) = [  2.69263E-03 0.00251 -1.72153E-04 0.00318 -1.41689E-04 0.00244 -4.94683E-03 0.00204 ];
INF_SP3                   (idx, [1:   8]) = [  4.86823E-04 0.00543 -4.16643E-05 0.01208 -5.33635E-05 0.00740 -4.49305E-03 0.00130 ];
INF_SP4                   (idx, [1:   8]) = [ -2.60678E-04 0.01699 -3.83624E-05 0.01551 -3.20848E-05 0.00752 -5.14543E-03 0.00086 ];
INF_SP5                   (idx, [1:   8]) = [  1.38974E-04 0.02422 -8.38076E-07 0.49015 -6.78311E-06 0.07455 -3.02140E-03 0.00108 ];
INF_SP6                   (idx, [1:   8]) = [ -4.37587E-04 0.00469 -2.66981E-05 0.01646 -2.29077E-05 0.00623 -4.85986E-03 0.00057 ];
INF_SP7                   (idx, [1:   8]) = [  1.33684E-04 0.02332  2.70968E-05 0.00782  9.17129E-06 0.03343 -6.57360E-04 0.00339 ];

% Micro-group spectrum:

B1_MICRO_FLX              (idx, [1: 140]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Integral parameters:

B1_KINF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_KEFF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_B2                     (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_ERR                    (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Critical spectra in infinite geometry:

B1_FLX                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS_FLX               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

B1_TOT                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CAPT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_ABS                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NSF                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NUBAR                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_KAPPA                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_INVV                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering cross sections:

B1_SCATT0                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT1                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT2                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT3                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT4                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT5                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT6                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT7                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering production cross sections:

B1_SCATTP0                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP1                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP2                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP3                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP4                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP5                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP6                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP7                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Diffusion parameters:

B1_TRANSPXS               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_DIFFCOEF               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reduced absoption and removal:

B1_RABSXS                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_REMXS                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison cross sections:

B1_I135_YIELD             (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_I135_MICRO_ABS         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Fission spectra:

B1_CHIT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHIP                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHID                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

B1_S0                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S1                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S2                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S3                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S4                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S5                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S6                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S7                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering production matrixes:

B1_SP0                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP1                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP2                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP3                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP4                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP5                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP6                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP7                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Additional diffusion parameters:

CMM_TRANSPXS              (idx, [1:   4]) = [  3.32616E-01 0.00039  4.08464E-01 0.00048 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  3.33053E-01 0.00041  4.09469E-01 0.00072 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  3.32951E-01 0.00034  4.09017E-01 0.00070 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  3.31847E-01 0.00065  4.06922E-01 0.00167 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  1.00216E+00 0.00039  8.16065E-01 0.00048 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  1.00084E+00 0.00041  8.14065E-01 0.00071 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  1.00115E+00 0.00034  8.14964E-01 0.00070 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  1.00448E+00 0.00065  8.19167E-01 0.00167 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  6.53096E-03 0.00564  2.29039E-04 0.02937  1.19235E-03 0.01236  1.11435E-03 0.01271  2.53737E-03 0.00977  1.02518E-03 0.01491  4.32663E-04 0.02304 ];
LAMBDA                    (idx, [1:  14]) = [  4.67189E-01 0.00872  1.33364E-02 2.0E-05  3.27379E-02 1.0E-05  1.20783E-01 1.0E-05  3.02804E-01 2.2E-05  8.49624E-01 5.6E-05  2.85342E+00 9.9E-05 ];


% Increase counter:

if (exist('idx', 'var'));
  idx = idx + 1;
else;
  idx = 1;
end;

% Version, title and date:

VERSION                   (idx, [1:  13]) = 'Serpent 2.2.1' ;
COMPILE_DATE              (idx, [1:  20]) = 'Aug  7 2024 16:40:12' ;
DEBUG                     (idx, 1)        = 0 ;
TITLE                     (idx, [1:   5]) = 'N-1.1' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:   5]) = 'input' ;
WORKING_DIRECTORY         (idx, [1: 115]) = '/home/staff/r/rok.krpan/OpenFOAM/rok.krpan-v2312/run/MoltenSaltReactor/progression_problems/N_1/N_1_1/Serpent2/run2' ;
HOSTNAME                  (idx, [1:  27]) = 'nuen-mj0jdqvh.engr.tamu.edu' ;
CPU_TYPE                  (idx, [1:  36]) = '12th Gen Intel(R) Core(TM) i7-12700T' ;
CPU_MHZ                   (idx, 1)        = 53.0 ;
START_DATE                (idx, [1:  24]) = 'Thu Oct 17 17:43:40 2024' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Thu Oct 17 17:57:03 2024' ;

% Run parameters:

POP                       (idx, 1)        = 100000 ;
CYCLES                    (idx, 1)        = 100 ;
SKIP                      (idx, 1)        = 10 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1729205020055 ;
UFS_MODE                  (idx, 1)        = 0 ;
UFS_ORDER                 (idx, 1)        = 1.00000 ;
NEUTRON_TRANSPORT_MODE    (idx, 1)        = 1 ;
PHOTON_TRANSPORT_MODE     (idx, 1)        = 0 ;
GROUP_CONSTANT_GENERATION (idx, 1)        = 1 ;
B1_CALCULATION            (idx, [1:  3])  = [ 0 0 0 ] ;
B1_IMPLICIT_LEAKAGE       (idx, 1)        = 0 ;
B1_BURNUP_CORRECTION      (idx, 1)        = 0 ;

CRIT_SPEC_MODE            (idx, 1)        = 0 ;
IMPLICIT_REACTION_RATES   (idx, 1)        = 1 ;

% Optimization:

OPTIMIZATION_MODE         (idx, 1)        = 4 ;
RECONSTRUCT_MICROXS       (idx, 1)        = 1 ;
RECONSTRUCT_MACROXS       (idx, 1)        = 1 ;
DOUBLE_INDEXING           (idx, 1)        = 0 ;
MG_MAJORANT_MODE          (idx, 1)        = 0 ;

% Parallelization:

MPI_TASKS                 (idx, 1)        = 1 ;
OMP_THREADS               (idx, 1)        = 20 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  20]) = [  1.01319E+00  1.00853E+00  1.01617E+00  9.94819E-01  9.71836E-01  1.00025E+00  9.91329E-01  9.96289E-01  1.02066E+00  1.00542E+00  9.82126E-01  9.77997E-01  1.01318E+00  1.00478E+00  1.00035E+00  1.01275E+00  1.01359E+00  1.00630E+00  9.83657E-01  9.86769E-01  ];
SHARE_BUF_ARRAY           (idx, 1)        = 0 ;
SHARE_RES2_ARRAY          (idx, 1)        = 1 ;
OMP_SHARED_QUEUE_LIM      (idx, 1)        = 0 ;

% File paths:

XS_DATA_FILE_PATH         (idx, [1:  73]) = '/home/staff/r/rok.krpan/opt/serpent2/cross_sections/xsdata/endfb71.xsdata' ;
DECAY_DATA_FILE_PATH      (idx, [1:   3]) = 'N/A' ;
SFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
NFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
BRA_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;

% Collision and reaction sampling (neutrons/photons):

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 1.9E-09  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.19879E-03 0.00153  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.97801E-01 3.4E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  9.02115E-01 1.1E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  9.02138E-01 1.1E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  2.12605E+00 6.4E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  6.75098E-01 4.2E-06  3.23876E-01 8.8E-06  1.02580E-03 0.00024  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  1.52452E+02 0.00015  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  1.52452E+02 0.00015  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  1.65377E+01 0.00014  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  3.32872E-01 0.00164  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 100 ;
SIMULATED_HISTORIES       (idx, 1)        = 9999879 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  9.99988E+04 0.00067 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  9.99988E+04 0.00067 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  2.57140E+02 ;
RUNNING_TIME              (idx, 1)        =  1.33992E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  2.77833E-02  2.77833E-02 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  6.83331E-04  6.83331E-04 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  1.33707E+01  1.33707E+01  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  1.33976E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 19.19069 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  1.92262E+01 0.00248 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  9.83729E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 31772.43 ;
ALLOC_MEMSIZE             (idx, 1)        = 1324.46 ;
MEMSIZE                   (idx, 1)        = 1107.83 ;
XS_MEMSIZE                (idx, 1)        = 402.63 ;
MAT_MEMSIZE               (idx, 1)        = 22.20 ;
RES_MEMSIZE               (idx, 1)        = 14.92 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 668.08 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 216.63 ;

% Geometry parameters:

TOT_CELLS                 (idx, 1)        = 10 ;
UNION_CELLS               (idx, 1)        = 8 ;

% Neutron energy grid:

NEUTRON_ERG_TOL           (idx, 1)        =  0.00000E+00 ;
NEUTRON_ERG_NE            (idx, 1)        = 263747 ;
NEUTRON_EMIN              (idx, 1)        =  1.00000E-11 ;
NEUTRON_EMAX              (idx, 1)        =  2.00000E+01 ;

% Unresolved resonance probability table sampling:

URES_DILU_CUT             (idx, 1)        =  1.00000E-09 ;
URES_EMIN                 (idx, 1)        =  1.00000E+37 ;
URES_EMAX                 (idx, 1)        = -1.00000E+37 ;
URES_AVAIL                (idx, 1)        = 8 ;
URES_USED                 (idx, 1)        = 0 ;

% Nuclides and reaction channels:

TOT_NUCLIDES              (idx, 1)        = 17 ;
TOT_TRANSPORT_NUCLIDES    (idx, 1)        = 17 ;
TOT_DOSIMETRY_NUCLIDES    (idx, 1)        = 0 ;
TOT_DECAY_NUCLIDES        (idx, 1)        = 0 ;
TOT_PHOTON_NUCLIDES       (idx, 1)        = 0 ;
TOT_REA_CHANNELS          (idx, 1)        = 522 ;
TOT_TRANSMU_REA           (idx, 1)        = 0 ;

% Neutron physics options:

USE_DELNU                 (idx, 1)        = 1 ;
USE_URES                  (idx, 1)        = 0 ;
USE_DBRC                  (idx, 1)        = 0 ;
IMPL_CAPT                 (idx, 1)        = 0 ;
IMPL_NXN                  (idx, 1)        = 1 ;
IMPL_FISS                 (idx, 1)        = 0 ;
DOPPLER_PREPROCESSOR      (idx, 1)        = 0 ;
TMS_MODE                  (idx, 1)        = 0 ;
SAMPLE_FISS               (idx, 1)        = 1 ;
SAMPLE_CAPT               (idx, 1)        = 1 ;
SAMPLE_SCATT              (idx, 1)        = 1 ;

% Energy deposition:

EDEP_MODE                 (idx, 1)        = 0 ;
EDEP_DELAYED              (idx, 1)        = 1 ;
EDEP_KEFF_CORR            (idx, 1)        = 1 ;
EDEP_LOCAL_EGD            (idx, 1)        = 0 ;
EDEP_COMP                 (idx, [1:   9]) = [ 0 0 0 0 0 0 0 0 0 ] ;
EDEP_CAPT_E               (idx, 1)        =  0.00000E+00 ;

% Radioactivity data:

TOT_ACTIVITY              (idx, 1)        =  0.00000E+00 ;
TOT_DECAY_HEAT            (idx, 1)        =  0.00000E+00 ;
TOT_SF_RATE               (idx, 1)        =  0.00000E+00 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  0.00000E+00 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  0.00000E+00 ;
INGESTION_TOXICITY        (idx, 1)        =  0.00000E+00 ;
ACTINIDE_INH_TOX          (idx, 1)        =  0.00000E+00 ;
ACTINIDE_ING_TOX          (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  0.00000E+00 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  0.00000E+00 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  4.05957E+07 0.00034  0.00000E+00 0.0E+00 ];

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  1.55106E-01 0.00131 ];
U235_FISS                 (idx, [1:   4]) = [  1.60402E+12 0.00049  9.99523E-01 1.1E-05 ];
U238_FISS                 (idx, [1:   4]) = [  7.31911E+08 0.02447  4.55993E-04 0.02435 ];
U235_CAPT                 (idx, [1:   4]) = [  3.46220E+11 0.00114  1.40048E-01 0.00103 ];
U238_CAPT                 (idx, [1:   4]) = [  2.96952E+11 0.00123  1.20118E-01 0.00107 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 9999879 1.00000E+07 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 4.28041E+04 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 9999879 1.00428E+07 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 6063645 6.08969E+06 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 3936234 3.95312E+06 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 9999879 1.00428E+07 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -1.58884E-06 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   2]) = [  5.20000E+01 0.0E+00 ];
TOT_POWDENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_GENRATE               (idx, [1:   2]) = [  3.91024E+12 9.2E-08 ];
TOT_FISSRATE              (idx, [1:   2]) = [  1.60456E+12 5.9E-09 ];
TOT_CAPTRATE              (idx, [1:   2]) = [  2.47077E+12 0.00012 ];
TOT_ABSRATE               (idx, [1:   2]) = [  4.07533E+12 7.5E-05 ];
TOT_SRCRATE               (idx, [1:   2]) = [  4.05957E+12 0.00034 ];
TOT_FLUX                  (idx, [1:   2]) = [  1.55939E+15 0.00021 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  4.07533E+12 7.5E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  6.21447E+14 0.00021 ];
INI_FMASS                 (idx, 1)        =  0.00000E+00 ;
TOT_FMASS                 (idx, 1)        =  0.00000E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.80596E+00 0.00026 ];
SIX_FF_F                  (idx, [1:   2]) = [  5.80692E-01 0.00031 ];
SIX_FF_P                  (idx, [1:   2]) = [  8.24769E-01 0.00013 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.11379E+00 0.00018 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  9.63358E-01 0.00045 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  9.63358E-01 0.00045 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.43695E+00 9.7E-08 ];
FISSE                     (idx, [1:   2]) = [  2.02272E+02 5.0E-09 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  9.63399E-01 0.00047  9.57081E-01 0.00045  6.27740E-03 0.00642 ];
IMP_KEFF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  9.63227E-01 0.00034 ];
ABS_KEFF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.86072E+01 5.8E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.86063E+01 1.6E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  1.65985E-07 0.00108 ];
IMP_EALF                  (idx, [1:   2]) = [  1.66115E-07 0.00030 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  3.38517E-03 0.01449 ];
IMP_AFGE                  (idx, [1:   2]) = [  3.30356E-03 0.00063 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  6.79018E-03 0.00408  2.37081E-04 0.01937  1.23070E-03 0.00848  1.17031E-03 0.00877  2.62275E-03 0.00639  1.08060E-03 0.01060  4.48733E-04 0.01698 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  4.67822E-01 0.00593  1.33364E-02 1.6E-05  3.27375E-02 1.3E-05  1.20784E-01 8.1E-06  3.02810E-01 1.4E-05  8.49630E-01 3.2E-05  2.85333E+00 4.3E-05 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  6.53096E-03 0.00564  2.29039E-04 0.02937  1.19235E-03 0.01236  1.11435E-03 0.01271  2.53737E-03 0.00977  1.02518E-03 0.01491  4.32663E-04 0.02304 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  4.67189E-01 0.00872  1.33364E-02 2.0E-05  3.27379E-02 1.0E-05  1.20783E-01 1.0E-05  3.02804E-01 2.2E-05  8.49624E-01 5.6E-05  2.85342E+00 9.9E-05 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  3.74266E-04 0.00079  3.74274E-04 0.00078  3.73420E-04 0.00807 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  3.60560E-04 0.00062  3.60567E-04 0.00061  3.59735E-04 0.00802 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  6.51628E-03 0.00654  2.25426E-04 0.03122  1.18315E-03 0.01550  1.11642E-03 0.01700  2.52447E-03 0.01063  1.04619E-03 0.01657  4.20634E-04 0.02581 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  4.64929E-01 0.00957  1.33360E-02 0.0E+00  3.27373E-02 2.1E-05  1.20785E-01 1.4E-05  3.02810E-01 2.5E-05  8.49628E-01 5.0E-05  2.85339E+00 7.0E-05 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  3.55345E-04 0.02312  3.55441E-04 0.02312  3.36977E-04 0.03348 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  3.42371E-04 0.02311  3.42464E-04 0.02311  3.24691E-04 0.03347 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  6.10632E-03 0.03342  2.19478E-04 0.11768  1.13356E-03 0.04858  1.03319E-03 0.05886  2.34956E-03 0.04212  1.01913E-03 0.05504  3.51407E-04 0.09118 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  4.53254E-01 0.03392  1.33360E-02 0.0E+00  3.27390E-02 5.6E-09  1.20794E-01 7.7E-05  3.02832E-01 0.00015  8.49512E-01 2.6E-05  2.85300E+00 0.0E+00 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  6.14316E-03 0.03313  2.21290E-04 0.11769  1.14007E-03 0.04806  1.05270E-03 0.05760  2.34585E-03 0.04168  1.02907E-03 0.05417  3.54172E-04 0.08871 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  4.53061E-01 0.03338  1.33360E-02 0.0E+00  3.27390E-02 5.9E-09  1.20794E-01 7.8E-05  3.02821E-01 0.00011  8.49509E-01 2.2E-05  2.85300E+00 0.0E+00 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -1.71838E+01 0.02425 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  3.74277E-04 0.00055 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  3.60570E-04 0.00024 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  6.47485E-03 0.00428 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -1.73008E+01 0.00442 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  8.59821E-07 0.00021 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  3.09280E-05 0.00010  3.09284E-05 0.00010  3.08726E-05 0.00123 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  3.66229E-04 0.00035  3.66221E-04 0.00035  3.67575E-04 0.00402 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  8.27642E-01 0.00013  8.27867E-01 0.00014  7.96048E-01 0.00622 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.11267E+01 0.00781 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  1.52452E+02 0.00015  1.60344E+02 0.00025 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   1]) = '1' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  1.90966E+05 0.00306  9.09160E+05 0.00220  2.09498E+06 0.00062  3.81283E+06 0.00056  4.21992E+06 0.00029  4.18693E+06 0.00036  3.22000E+06 0.00055  2.73141E+06 0.00051  3.51568E+06 0.00051  3.39236E+06 0.00041  3.41291E+06 0.00042  3.36497E+06 0.00045  3.66931E+06 0.00024  3.52883E+06 0.00027  3.55119E+06 0.00051  3.12524E+06 0.00072  3.15305E+06 0.00070  3.14873E+06 0.00062  3.14308E+06 0.00039  6.25963E+06 0.00048  6.20676E+06 0.00037  4.61213E+06 0.00016  3.03969E+06 0.00049  3.65574E+06 0.00040  3.58773E+06 0.00048  3.10751E+06 0.00100  5.65911E+06 0.00055  1.22744E+06 0.00091  1.54235E+06 0.00057  1.39160E+06 0.00083  8.18937E+05 0.00059  1.42701E+06 0.00118  9.80395E+05 0.00043  8.55896E+05 0.00086  1.67012E+05 0.00145  1.65602E+05 0.00228  1.70465E+05 0.00126  1.75767E+05 0.00220  1.74188E+05 0.00125  1.72557E+05 0.00262  1.78475E+05 0.00136  1.67636E+05 0.00185  3.18096E+05 0.00099  5.16617E+05 0.00120  6.72592E+05 0.00094  1.91749E+06 0.00091  2.43632E+06 0.00089  3.34520E+06 0.00064  2.59372E+06 0.00075  2.01110E+06 0.00074  1.58859E+06 0.00073  1.81924E+06 0.00041  3.23075E+06 0.00067  3.96091E+06 0.00048  6.58507E+06 0.00065  8.22793E+06 0.00044  9.63815E+06 0.00041  5.05494E+06 0.00068  3.22853E+06 0.00034  2.11853E+06 0.00053  1.79553E+06 0.00069  1.69369E+06 0.00132  1.29861E+06 0.00064  8.49490E+05 0.00050  7.20160E+05 0.00115  6.47268E+05 0.00044  5.23802E+05 0.00136  3.67033E+05 0.00112  2.28886E+05 0.00097  7.27514E+04 0.00322 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  1.55212E+00 0.00061 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  2.18283E+14 0.00039  1.29980E+14 0.00010 ];
INF_FISS_FLX              (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  3.13693E-01 3.3E-05  3.05459E-01 1.2E-05 ];
INF_CAPT                  (idx, [1:   4]) = [  1.96341E-03 0.00064  3.87306E-03 0.00011 ];
INF_ABS                   (idx, [1:   4]) = [  2.71609E-03 0.00046  1.49539E-02 0.00012 ];
INF_FISS                  (idx, [1:   4]) = [  7.52679E-04 0.00012  1.10809E-02 0.00012 ];
INF_NSF                   (idx, [1:   4]) = [  1.83588E-03 0.00012  2.70007E-02 0.00012 ];
INF_NUBAR                 (idx, [1:   4]) = [  2.43912E+00 5.6E-07  2.43670E+00 0.0E+00 ];
INF_KAPPA                 (idx, [1:   4]) = [  2.02290E+02 4.4E-08  2.02270E+02 0.0E+00 ];
INF_INVV                  (idx, [1:   4]) = [  1.17874E-07 0.00020  2.07989E-06 0.00010 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  3.10979E-01 3.3E-05  2.90501E-01 2.7E-05 ];
INF_SCATT1                (idx, [1:   4]) = [  2.01775E-02 0.00035  1.34539E-02 0.00224 ];
INF_SCATT2                (idx, [1:   4]) = [  4.41191E-03 0.00253  9.03627E-04 0.01550 ];
INF_SCATT3                (idx, [1:   4]) = [  9.24259E-04 0.00514  1.70925E-04 0.08914 ];
INF_SCATT4                (idx, [1:   4]) = [  4.03322E-04 0.01258  8.01660E-05 0.11905 ];
INF_SCATT5                (idx, [1:   4]) = [  8.84593E-05 0.06486  3.02411E-05 0.33058 ];
INF_SCATT6                (idx, [1:   4]) = [  1.06344E-05 0.81961  1.49069E-05 0.85554 ];
INF_SCATT7                (idx, [1:   4]) = [  1.02985E-05 1.00000  1.49554E-05 0.62346 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  3.11059E-01 3.3E-05  2.90501E-01 2.7E-05 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.01984E-02 0.00035  1.34539E-02 0.00224 ];
INF_SCATTP2               (idx, [1:   4]) = [  4.41566E-03 0.00256  9.03627E-04 0.01550 ];
INF_SCATTP3               (idx, [1:   4]) = [  9.24595E-04 0.00517  1.70925E-04 0.08914 ];
INF_SCATTP4               (idx, [1:   4]) = [  4.03271E-04 0.01251  8.01660E-05 0.11905 ];
INF_SCATTP5               (idx, [1:   4]) = [  8.84971E-05 0.06466  3.02411E-05 0.33058 ];
INF_SCATTP6               (idx, [1:   4]) = [  1.06489E-05 0.81651  1.49069E-05 0.85554 ];
INF_SCATTP7               (idx, [1:   4]) = [  1.01245E-05 1.00000  1.49554E-05 0.62346 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  2.79162E-01 7.6E-05  2.90873E-01 9.9E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  1.19405E+00 7.6E-05  1.14598E+00 9.9E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  2.63649E-03 0.00048  1.49539E-02 0.00012 ];
INF_REMXS                 (idx, [1:   4]) = [  5.74627E-03 0.00079  1.64151E-02 0.00048 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_I135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MACRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison universe-averaged densities:

I135_ADENS                (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
XE135_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM147_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148M_ADENS              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
SM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Poison decay constants:

PM147_LAMBDA              (idx, 1)        =  0.00000E+00 ;
PM148_LAMBDA              (idx, 1)        =  0.00000E+00 ;
PM148M_LAMBDA             (idx, 1)        =  0.00000E+00 ;
PM149_LAMBDA              (idx, 1)        =  0.00000E+00 ;
I135_LAMBDA               (idx, 1)        =  0.00000E+00 ;
XE135_LAMBDA              (idx, 1)        =  0.00000E+00 ;
XE135M_LAMBDA             (idx, 1)        =  0.00000E+00 ;
I135_BR                   (idx, 1)        =  0.00000E+00 ;

% Fission spectra:

INF_CHIT                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHIP                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHID                  (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

INF_S0                    (idx, [1:   8]) = [  3.07947E-01 3.0E-05  3.03224E-03 0.00072  1.45675E-03 0.00202  2.89044E-01 3.5E-05 ];
INF_S1                    (idx, [1:   8]) = [  2.08498E-02 0.00031 -6.72322E-04 0.00241 -7.40886E-05 0.01889  1.35280E-02 0.00215 ];
INF_S2                    (idx, [1:   8]) = [  4.50551E-03 0.00235 -9.36033E-05 0.01379 -7.08733E-05 0.01157  9.74501E-04 0.01511 ];
INF_S3                    (idx, [1:   8]) = [  9.45405E-04 0.00538 -2.11462E-05 0.05186 -3.00175E-05 0.02568  2.00942E-04 0.07298 ];
INF_S4                    (idx, [1:   8]) = [  4.12469E-04 0.01325 -9.14707E-06 0.10679 -1.60910E-05 0.05508  9.62570E-05 0.09604 ];
INF_S5                    (idx, [1:   8]) = [  9.25757E-05 0.06294 -4.11633E-06 0.19540 -8.23305E-06 0.08537  3.84742E-05 0.25165 ];
INF_S6                    (idx, [1:   8]) = [  1.43931E-05 0.60319 -3.75877E-06 0.16110 -5.57896E-06 0.06705  2.04859E-05 0.61071 ];
INF_S7                    (idx, [1:   8]) = [  1.22250E-05 1.00000 -1.92650E-06 0.32689 -3.04290E-06 0.13734  1.79983E-05 0.51034 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  3.08027E-01 3.1E-05  3.03224E-03 0.00072  1.45675E-03 0.00202  2.89044E-01 3.5E-05 ];
INF_SP1                   (idx, [1:   8]) = [  2.08707E-02 0.00031 -6.72322E-04 0.00241 -7.40886E-05 0.01889  1.35280E-02 0.00215 ];
INF_SP2                   (idx, [1:   8]) = [  4.50926E-03 0.00237 -9.36033E-05 0.01379 -7.08733E-05 0.01157  9.74501E-04 0.01511 ];
INF_SP3                   (idx, [1:   8]) = [  9.45741E-04 0.00544 -2.11462E-05 0.05186 -3.00175E-05 0.02568  2.00942E-04 0.07298 ];
INF_SP4                   (idx, [1:   8]) = [  4.12418E-04 0.01322 -9.14707E-06 0.10679 -1.60910E-05 0.05508  9.62570E-05 0.09604 ];
INF_SP5                   (idx, [1:   8]) = [  9.26134E-05 0.06273 -4.11633E-06 0.19540 -8.23305E-06 0.08537  3.84742E-05 0.25165 ];
INF_SP6                   (idx, [1:   8]) = [  1.44076E-05 0.60156 -3.75877E-06 0.16110 -5.57896E-06 0.06705  2.04859E-05 0.61071 ];
INF_SP7                   (idx, [1:   8]) = [  1.20510E-05 1.00000 -1.92650E-06 0.32689 -3.04290E-06 0.13734  1.79983E-05 0.51034 ];

% Micro-group spectrum:

B1_MICRO_FLX              (idx, [1: 140]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Integral parameters:

B1_KINF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_KEFF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_B2                     (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_ERR                    (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Critical spectra in infinite geometry:

B1_FLX                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS_FLX               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

B1_TOT                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CAPT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_ABS                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NSF                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NUBAR                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_KAPPA                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_INVV                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering cross sections:

B1_SCATT0                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT1                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT2                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT3                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT4                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT5                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT6                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT7                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering production cross sections:

B1_SCATTP0                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP1                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP2                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP3                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP4                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP5                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP6                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP7                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Diffusion parameters:

B1_TRANSPXS               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_DIFFCOEF               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reduced absoption and removal:

B1_RABSXS                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_REMXS                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison cross sections:

B1_I135_YIELD             (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_I135_MICRO_ABS         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Fission spectra:

B1_CHIT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHIP                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHID                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

B1_S0                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S1                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S2                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S3                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S4                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S5                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S6                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S7                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering production matrixes:

B1_SP0                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP1                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP2                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP3                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP4                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP5                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP6                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP7                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Additional diffusion parameters:

CMM_TRANSPXS              (idx, [1:   4]) = [  3.92886E-01 0.00089  3.80979E-01 0.00105 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  3.95043E-01 0.00140  3.86711E-01 0.00145 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  3.93652E-01 0.00103  3.85253E-01 0.00149 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  3.90002E-01 0.00150  3.71362E-01 0.00186 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  8.48425E-01 0.00089  8.74942E-01 0.00105 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  8.43797E-01 0.00140  8.61977E-01 0.00145 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  8.46775E-01 0.00103  8.65240E-01 0.00149 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  8.54703E-01 0.00150  8.97610E-01 0.00186 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  6.53096E-03 0.00564  2.29039E-04 0.02937  1.19235E-03 0.01236  1.11435E-03 0.01271  2.53737E-03 0.00977  1.02518E-03 0.01491  4.32663E-04 0.02304 ];
LAMBDA                    (idx, [1:  14]) = [  4.67189E-01 0.00872  1.33364E-02 2.0E-05  3.27379E-02 1.0E-05  1.20783E-01 1.0E-05  3.02804E-01 2.2E-05  8.49624E-01 5.6E-05  2.85342E+00 9.9E-05 ];


% Increase counter:

if (exist('idx', 'var'));
  idx = idx + 1;
else;
  idx = 1;
end;

% Version, title and date:

VERSION                   (idx, [1:  13]) = 'Serpent 2.2.1' ;
COMPILE_DATE              (idx, [1:  20]) = 'Aug  7 2024 16:40:12' ;
DEBUG                     (idx, 1)        = 0 ;
TITLE                     (idx, [1:   5]) = 'N-1.1' ;
CONFIDENTIAL_DATA         (idx, 1)        = 0 ;
INPUT_FILE_NAME           (idx, [1:   5]) = 'input' ;
WORKING_DIRECTORY         (idx, [1: 115]) = '/home/staff/r/rok.krpan/OpenFOAM/rok.krpan-v2312/run/MoltenSaltReactor/progression_problems/N_1/N_1_1/Serpent2/run2' ;
HOSTNAME                  (idx, [1:  27]) = 'nuen-mj0jdqvh.engr.tamu.edu' ;
CPU_TYPE                  (idx, [1:  36]) = '12th Gen Intel(R) Core(TM) i7-12700T' ;
CPU_MHZ                   (idx, 1)        = 53.0 ;
START_DATE                (idx, [1:  24]) = 'Thu Oct 17 17:43:40 2024' ;
COMPLETE_DATE             (idx, [1:  24]) = 'Thu Oct 17 17:57:03 2024' ;

% Run parameters:

POP                       (idx, 1)        = 100000 ;
CYCLES                    (idx, 1)        = 100 ;
SKIP                      (idx, 1)        = 10 ;
BATCH_INTERVAL            (idx, 1)        = 1 ;
SRC_NORM_MODE             (idx, 1)        = 2 ;
SEED                      (idx, 1)        = 1729205020055 ;
UFS_MODE                  (idx, 1)        = 0 ;
UFS_ORDER                 (idx, 1)        = 1.00000 ;
NEUTRON_TRANSPORT_MODE    (idx, 1)        = 1 ;
PHOTON_TRANSPORT_MODE     (idx, 1)        = 0 ;
GROUP_CONSTANT_GENERATION (idx, 1)        = 1 ;
B1_CALCULATION            (idx, [1:  3])  = [ 0 0 0 ] ;
B1_IMPLICIT_LEAKAGE       (idx, 1)        = 0 ;
B1_BURNUP_CORRECTION      (idx, 1)        = 0 ;

CRIT_SPEC_MODE            (idx, 1)        = 0 ;
IMPLICIT_REACTION_RATES   (idx, 1)        = 1 ;

% Optimization:

OPTIMIZATION_MODE         (idx, 1)        = 4 ;
RECONSTRUCT_MICROXS       (idx, 1)        = 1 ;
RECONSTRUCT_MACROXS       (idx, 1)        = 1 ;
DOUBLE_INDEXING           (idx, 1)        = 0 ;
MG_MAJORANT_MODE          (idx, 1)        = 0 ;

% Parallelization:

MPI_TASKS                 (idx, 1)        = 1 ;
OMP_THREADS               (idx, 1)        = 20 ;
MPI_REPRODUCIBILITY       (idx, 1)        = 0 ;
OMP_REPRODUCIBILITY       (idx, 1)        = 1 ;
OMP_HISTORY_PROFILE       (idx, [1:  20]) = [  1.01319E+00  1.00853E+00  1.01617E+00  9.94819E-01  9.71836E-01  1.00025E+00  9.91329E-01  9.96289E-01  1.02066E+00  1.00542E+00  9.82126E-01  9.77997E-01  1.01318E+00  1.00478E+00  1.00035E+00  1.01275E+00  1.01359E+00  1.00630E+00  9.83657E-01  9.86769E-01  ];
SHARE_BUF_ARRAY           (idx, 1)        = 0 ;
SHARE_RES2_ARRAY          (idx, 1)        = 1 ;
OMP_SHARED_QUEUE_LIM      (idx, 1)        = 0 ;

% File paths:

XS_DATA_FILE_PATH         (idx, [1:  73]) = '/home/staff/r/rok.krpan/opt/serpent2/cross_sections/xsdata/endfb71.xsdata' ;
DECAY_DATA_FILE_PATH      (idx, [1:   3]) = 'N/A' ;
SFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
NFY_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;
BRA_DATA_FILE_PATH        (idx, [1:   3]) = 'N/A' ;

% Collision and reaction sampling (neutrons/photons):

MIN_MACROXS               (idx, [1:   4]) = [  5.00000E-02 1.9E-09  0.00000E+00 0.0E+00 ];
DT_THRESH                 (idx, [1:   2]) = [  9.00000E-01  9.00000E-01 ] ;
ST_FRAC                   (idx, [1:   4]) = [  2.19879E-03 0.00153  0.00000E+00 0.0E+00 ];
DT_FRAC                   (idx, [1:   4]) = [  9.97801E-01 3.4E-06  0.00000E+00 0.0E+00 ];
DT_EFF                    (idx, [1:   4]) = [  9.02115E-01 1.1E-05  0.00000E+00 0.0E+00 ];
REA_SAMPLING_EFF          (idx, [1:   4]) = [  1.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
REA_SAMPLING_FAIL         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_COL_EFF               (idx, [1:   4]) = [  9.02138E-01 1.1E-05  0.00000E+00 0.0E+00 ];
AVG_TRACKING_LOOPS        (idx, [1:   8]) = [  2.12605E+00 6.4E-05  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
CELL_SEARCH_FRAC          (idx, [1:  10]) = [  6.75098E-01 4.2E-06  3.23876E-01 8.8E-06  1.02580E-03 0.00024  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
AVG_TRACKS                (idx, [1:   4]) = [  1.52452E+02 0.00015  0.00000E+00 0.0E+00 ];
AVG_REAL_COL              (idx, [1:   4]) = [  1.52452E+02 0.00015  0.00000E+00 0.0E+00 ];
AVG_VIRT_COL              (idx, [1:   4]) = [  1.65377E+01 0.00014  0.00000E+00 0.0E+00 ];
AVG_SURF_CROSS            (idx, [1:   4]) = [  3.32872E-01 0.00164  0.00000E+00 0.0E+00 ];
LOST_PARTICLES            (idx, 1)        = 0 ;

% Run statistics:

CYCLE_IDX                 (idx, 1)        = 100 ;
SIMULATED_HISTORIES       (idx, 1)        = 9999879 ;
MEAN_POP_SIZE             (idx, [1:   2]) = [  9.99988E+04 0.00067 ] ;
MEAN_POP_WGT              (idx, [1:   2]) = [  9.99988E+04 0.00067 ] ;
SIMULATION_COMPLETED      (idx, 1)        = 1 ;

% Running times:

TOT_CPU_TIME              (idx, 1)        =  2.57140E+02 ;
RUNNING_TIME              (idx, 1)        =  1.33992E+01 ;
INIT_TIME                 (idx, [1:   2]) = [  2.77833E-02  2.77833E-02 ] ;
PROCESS_TIME              (idx, [1:   2]) = [  6.83331E-04  6.83331E-04 ] ;
TRANSPORT_CYCLE_TIME      (idx, [1:   3]) = [  1.33707E+01  1.33707E+01  0.00000E+00 ] ;
MPI_OVERHEAD_TIME         (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
ESTIMATED_RUNNING_TIME    (idx, [1:   2]) = [  1.33976E+01  0.00000E+00 ] ;
CPU_USAGE                 (idx, 1)        = 19.19069 ;
TRANSPORT_CPU_USAGE       (idx, [1:   2]) = [  1.92262E+01 0.00248 ];
OMP_PARALLEL_FRAC         (idx, 1)        =  9.83729E-01 ;

% Memory usage:

AVAIL_MEM                 (idx, 1)        = 31772.43 ;
ALLOC_MEMSIZE             (idx, 1)        = 1324.46 ;
MEMSIZE                   (idx, 1)        = 1107.83 ;
XS_MEMSIZE                (idx, 1)        = 402.63 ;
MAT_MEMSIZE               (idx, 1)        = 22.20 ;
RES_MEMSIZE               (idx, 1)        = 14.92 ;
IFC_MEMSIZE               (idx, 1)        = 0.00 ;
MISC_MEMSIZE              (idx, 1)        = 668.08 ;
UNKNOWN_MEMSIZE           (idx, 1)        = 0.00 ;
UNUSED_MEMSIZE            (idx, 1)        = 216.63 ;

% Geometry parameters:

TOT_CELLS                 (idx, 1)        = 10 ;
UNION_CELLS               (idx, 1)        = 8 ;

% Neutron energy grid:

NEUTRON_ERG_TOL           (idx, 1)        =  0.00000E+00 ;
NEUTRON_ERG_NE            (idx, 1)        = 263747 ;
NEUTRON_EMIN              (idx, 1)        =  1.00000E-11 ;
NEUTRON_EMAX              (idx, 1)        =  2.00000E+01 ;

% Unresolved resonance probability table sampling:

URES_DILU_CUT             (idx, 1)        =  1.00000E-09 ;
URES_EMIN                 (idx, 1)        =  1.00000E+37 ;
URES_EMAX                 (idx, 1)        = -1.00000E+37 ;
URES_AVAIL                (idx, 1)        = 8 ;
URES_USED                 (idx, 1)        = 0 ;

% Nuclides and reaction channels:

TOT_NUCLIDES              (idx, 1)        = 17 ;
TOT_TRANSPORT_NUCLIDES    (idx, 1)        = 17 ;
TOT_DOSIMETRY_NUCLIDES    (idx, 1)        = 0 ;
TOT_DECAY_NUCLIDES        (idx, 1)        = 0 ;
TOT_PHOTON_NUCLIDES       (idx, 1)        = 0 ;
TOT_REA_CHANNELS          (idx, 1)        = 522 ;
TOT_TRANSMU_REA           (idx, 1)        = 0 ;

% Neutron physics options:

USE_DELNU                 (idx, 1)        = 1 ;
USE_URES                  (idx, 1)        = 0 ;
USE_DBRC                  (idx, 1)        = 0 ;
IMPL_CAPT                 (idx, 1)        = 0 ;
IMPL_NXN                  (idx, 1)        = 1 ;
IMPL_FISS                 (idx, 1)        = 0 ;
DOPPLER_PREPROCESSOR      (idx, 1)        = 0 ;
TMS_MODE                  (idx, 1)        = 0 ;
SAMPLE_FISS               (idx, 1)        = 1 ;
SAMPLE_CAPT               (idx, 1)        = 1 ;
SAMPLE_SCATT              (idx, 1)        = 1 ;

% Energy deposition:

EDEP_MODE                 (idx, 1)        = 0 ;
EDEP_DELAYED              (idx, 1)        = 1 ;
EDEP_KEFF_CORR            (idx, 1)        = 1 ;
EDEP_LOCAL_EGD            (idx, 1)        = 0 ;
EDEP_COMP                 (idx, [1:   9]) = [ 0 0 0 0 0 0 0 0 0 ] ;
EDEP_CAPT_E               (idx, 1)        =  0.00000E+00 ;

% Radioactivity data:

TOT_ACTIVITY              (idx, 1)        =  0.00000E+00 ;
TOT_DECAY_HEAT            (idx, 1)        =  0.00000E+00 ;
TOT_SF_RATE               (idx, 1)        =  0.00000E+00 ;
ACTINIDE_ACTIVITY         (idx, 1)        =  0.00000E+00 ;
ACTINIDE_DECAY_HEAT       (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ACTIVITY  (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_DECAY_HEAT(idx, 1)        =  0.00000E+00 ;
INHALATION_TOXICITY       (idx, 1)        =  0.00000E+00 ;
INGESTION_TOXICITY        (idx, 1)        =  0.00000E+00 ;
ACTINIDE_INH_TOX          (idx, 1)        =  0.00000E+00 ;
ACTINIDE_ING_TOX          (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_INH_TOX   (idx, 1)        =  0.00000E+00 ;
FISSION_PRODUCT_ING_TOX   (idx, 1)        =  0.00000E+00 ;
SR90_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
TE132_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
I131_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
I132_ACTIVITY             (idx, 1)        =  0.00000E+00 ;
CS134_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
CS137_ACTIVITY            (idx, 1)        =  0.00000E+00 ;
PHOTON_DECAY_SOURCE       (idx, [1:   2]) = [  0.00000E+00  0.00000E+00 ] ;
NEUTRON_DECAY_SOURCE      (idx, 1)        =  0.00000E+00 ;
ALPHA_DECAY_SOURCE        (idx, 1)        =  0.00000E+00 ;
ELECTRON_DECAY_SOURCE     (idx, 1)        =  0.00000E+00 ;

% Normalization coefficient:

NORM_COEF                 (idx, [1:   4]) = [  4.05957E+07 0.00034  0.00000E+00 0.0E+00 ];

% Analog reaction rate estimators:

CONVERSION_RATIO          (idx, [1:   2]) = [  1.55106E-01 0.00131 ];
U235_FISS                 (idx, [1:   4]) = [  1.60402E+12 0.00049  9.99523E-01 1.1E-05 ];
U238_FISS                 (idx, [1:   4]) = [  7.31911E+08 0.02447  4.55993E-04 0.02435 ];
U235_CAPT                 (idx, [1:   4]) = [  3.46220E+11 0.00114  1.40048E-01 0.00103 ];
U238_CAPT                 (idx, [1:   4]) = [  2.96952E+11 0.00123  1.20118E-01 0.00107 ];

% Neutron balance (particles/weight):

BALA_SRC_NEUTRON_SRC      (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_FISS     (idx, [1:   2]) = [ 9999879 1.00000E+07 ] ;
BALA_SRC_NEUTRON_NXN      (idx, [1:   2]) = [ 0 4.28041E+04 ] ;
BALA_SRC_NEUTRON_VR       (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_SRC_NEUTRON_TOT      (idx, [1:   2]) = [ 9999879 1.00428E+07 ] ;

BALA_LOSS_NEUTRON_CAPT    (idx, [1:   2]) = [ 6063645 6.08969E+06 ] ;
BALA_LOSS_NEUTRON_FISS    (idx, [1:   2]) = [ 3936234 3.95312E+06 ] ;
BALA_LOSS_NEUTRON_LEAK    (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_CUT     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_ERR     (idx, [1:   2]) = [ 0 0.00000E+00 ] ;
BALA_LOSS_NEUTRON_TOT     (idx, [1:   2]) = [ 9999879 1.00428E+07 ] ;

BALA_NEUTRON_DIFF         (idx, [1:   2]) = [ 0 -1.58884E-06 ] ;

% Normalized total reaction rates (neutrons):

TOT_POWER                 (idx, [1:   2]) = [  5.20000E+01 0.0E+00 ];
TOT_POWDENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_GENRATE               (idx, [1:   2]) = [  3.91024E+12 9.2E-08 ];
TOT_FISSRATE              (idx, [1:   2]) = [  1.60456E+12 5.9E-09 ];
TOT_CAPTRATE              (idx, [1:   2]) = [  2.47077E+12 0.00012 ];
TOT_ABSRATE               (idx, [1:   2]) = [  4.07533E+12 7.5E-05 ];
TOT_SRCRATE               (idx, [1:   2]) = [  4.05957E+12 0.00034 ];
TOT_FLUX                  (idx, [1:   2]) = [  1.55939E+15 0.00021 ];
TOT_PHOTON_PRODRATE       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
TOT_LEAKRATE              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
ALBEDO_LEAKRATE           (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_LOSSRATE              (idx, [1:   2]) = [  4.07533E+12 7.5E-05 ];
TOT_CUTRATE               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
TOT_RR                    (idx, [1:   2]) = [  6.21447E+14 0.00021 ];
INI_FMASS                 (idx, 1)        =  0.00000E+00 ;
TOT_FMASS                 (idx, 1)        =  0.00000E+00 ;

% Six-factor formula:

SIX_FF_ETA                (idx, [1:   2]) = [  1.80596E+00 0.00026 ];
SIX_FF_F                  (idx, [1:   2]) = [  5.80692E-01 0.00031 ];
SIX_FF_P                  (idx, [1:   2]) = [  8.24769E-01 0.00013 ];
SIX_FF_EPSILON            (idx, [1:   2]) = [  1.11379E+00 0.00018 ];
SIX_FF_LF                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_LT                 (idx, [1:   2]) = [  1.00000E+00 0.0E+00 ];
SIX_FF_KINF               (idx, [1:   2]) = [  9.63358E-01 0.00045 ];
SIX_FF_KEFF               (idx, [1:   2]) = [  9.63358E-01 0.00045 ];

% Fission neutron and energy production:

NUBAR                     (idx, [1:   2]) = [  2.43695E+00 9.7E-08 ];
FISSE                     (idx, [1:   2]) = [  2.02272E+02 5.0E-09 ];

% Criticality eigenvalues:

ANA_KEFF                  (idx, [1:   6]) = [  9.63399E-01 0.00047  9.57081E-01 0.00045  6.27740E-03 0.00642 ];
IMP_KEFF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
COL_KEFF                  (idx, [1:   2]) = [  9.63227E-01 0.00034 ];
ABS_KEFF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
ABS_KINF                  (idx, [1:   2]) = [  9.63594E-01 7.4E-05 ];
GEOM_ALBEDO               (idx, [1:   6]) = [  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00  1.00000E+00 0.0E+00 ];

% ALF (Average lethargy of neutrons causing fission):
% Based on E0 = 2.000000E+01 MeV

ANA_ALF                   (idx, [1:   2]) = [  1.86072E+01 5.8E-05 ];
IMP_ALF                   (idx, [1:   2]) = [  1.86063E+01 1.6E-05 ];

% EALF (Energy corresponding to average lethargy of neutrons causing fission):

ANA_EALF                  (idx, [1:   2]) = [  1.65985E-07 0.00108 ];
IMP_EALF                  (idx, [1:   2]) = [  1.66115E-07 0.00030 ];

% AFGE (Average energy of neutrons causing fission):

ANA_AFGE                  (idx, [1:   2]) = [  3.38517E-03 0.01449 ];
IMP_AFGE                  (idx, [1:   2]) = [  3.30356E-03 0.00063 ];

% Forward-weighted delayed neutron parameters:

PRECURSOR_GROUPS          (idx, 1)        = 6 ;
FWD_ANA_BETA_ZERO         (idx, [1:  14]) = [  6.79018E-03 0.00408  2.37081E-04 0.01937  1.23070E-03 0.00848  1.17031E-03 0.00877  2.62275E-03 0.00639  1.08060E-03 0.01060  4.48733E-04 0.01698 ];
FWD_ANA_LAMBDA            (idx, [1:  14]) = [  4.67822E-01 0.00593  1.33364E-02 1.6E-05  3.27375E-02 1.3E-05  1.20784E-01 8.1E-06  3.02810E-01 1.4E-05  8.49630E-01 3.2E-05  2.85333E+00 4.3E-05 ];

% Beta-eff using Meulekamp's method:

ADJ_MEULEKAMP_BETA_EFF    (idx, [1:  14]) = [  6.53096E-03 0.00564  2.29039E-04 0.02937  1.19235E-03 0.01236  1.11435E-03 0.01271  2.53737E-03 0.00977  1.02518E-03 0.01491  4.32663E-04 0.02304 ];
ADJ_MEULEKAMP_LAMBDA      (idx, [1:  14]) = [  4.67189E-01 0.00872  1.33364E-02 2.0E-05  3.27379E-02 1.0E-05  1.20783E-01 1.0E-05  3.02804E-01 2.2E-05  8.49624E-01 5.6E-05  2.85342E+00 9.9E-05 ];

% Adjoint weighted time constants using Nauchi's method:

IFP_CHAIN_LENGTH          (idx, 1)        = 15 ;
ADJ_NAUCHI_GEN_TIME       (idx, [1:   6]) = [  3.74266E-04 0.00079  3.74274E-04 0.00078  3.73420E-04 0.00807 ];
ADJ_NAUCHI_LIFETIME       (idx, [1:   6]) = [  3.60560E-04 0.00062  3.60567E-04 0.00061  3.59735E-04 0.00802 ];
ADJ_NAUCHI_BETA_EFF       (idx, [1:  14]) = [  6.51628E-03 0.00654  2.25426E-04 0.03122  1.18315E-03 0.01550  1.11642E-03 0.01700  2.52447E-03 0.01063  1.04619E-03 0.01657  4.20634E-04 0.02581 ];
ADJ_NAUCHI_LAMBDA         (idx, [1:  14]) = [  4.64929E-01 0.00957  1.33360E-02 0.0E+00  3.27373E-02 2.1E-05  1.20785E-01 1.4E-05  3.02810E-01 2.5E-05  8.49628E-01 5.0E-05  2.85339E+00 7.0E-05 ];

% Adjoint weighted time constants using IFP:

ADJ_IFP_GEN_TIME          (idx, [1:   6]) = [  3.55345E-04 0.02312  3.55441E-04 0.02312  3.36977E-04 0.03348 ];
ADJ_IFP_LIFETIME          (idx, [1:   6]) = [  3.42371E-04 0.02311  3.42464E-04 0.02311  3.24691E-04 0.03347 ];
ADJ_IFP_IMP_BETA_EFF      (idx, [1:  14]) = [  6.10632E-03 0.03342  2.19478E-04 0.11768  1.13356E-03 0.04858  1.03319E-03 0.05886  2.34956E-03 0.04212  1.01913E-03 0.05504  3.51407E-04 0.09118 ];
ADJ_IFP_IMP_LAMBDA        (idx, [1:  14]) = [  4.53254E-01 0.03392  1.33360E-02 0.0E+00  3.27390E-02 5.6E-09  1.20794E-01 7.7E-05  3.02832E-01 0.00015  8.49512E-01 2.6E-05  2.85300E+00 0.0E+00 ];
ADJ_IFP_ANA_BETA_EFF      (idx, [1:  14]) = [  6.14316E-03 0.03313  2.21290E-04 0.11769  1.14007E-03 0.04806  1.05270E-03 0.05760  2.34585E-03 0.04168  1.02907E-03 0.05417  3.54172E-04 0.08871 ];
ADJ_IFP_ANA_LAMBDA        (idx, [1:  14]) = [  4.53061E-01 0.03338  1.33360E-02 0.0E+00  3.27390E-02 5.9E-09  1.20794E-01 7.8E-05  3.02821E-01 0.00011  8.49509E-01 2.2E-05  2.85300E+00 0.0E+00 ];
ADJ_IFP_ROSSI_ALPHA       (idx, [1:   2]) = [ -1.71838E+01 0.02425 ];

% Adjoint weighted time constants using perturbation technique:

ADJ_PERT_GEN_TIME         (idx, [1:   2]) = [  3.74277E-04 0.00055 ];
ADJ_PERT_LIFETIME         (idx, [1:   2]) = [  3.60570E-04 0.00024 ];
ADJ_PERT_BETA_EFF         (idx, [1:   2]) = [  6.47485E-03 0.00428 ];
ADJ_PERT_ROSSI_ALPHA      (idx, [1:   2]) = [ -1.73008E+01 0.00442 ];

% Inverse neutron speed :

ANA_INV_SPD               (idx, [1:   2]) = [  8.59821E-07 0.00021 ];

% Analog slowing-down and thermal neutron lifetime (total/prompt/delayed):

ANA_SLOW_TIME             (idx, [1:   6]) = [  3.09280E-05 0.00010  3.09284E-05 0.00010  3.08726E-05 0.00123 ];
ANA_THERM_TIME            (idx, [1:   6]) = [  3.66229E-04 0.00035  3.66221E-04 0.00035  3.67575E-04 0.00402 ];
ANA_THERM_FRAC            (idx, [1:   6]) = [  8.27642E-01 0.00013  8.27867E-01 0.00014  7.96048E-01 0.00622 ];
ANA_DELAYED_EMTIME        (idx, [1:   2]) = [  1.11267E+01 0.00781 ];
ANA_MEAN_NCOL             (idx, [1:   4]) = [  1.52452E+02 0.00015  1.60344E+02 0.00025 ];

% Group constant generation:

GC_UNIVERSE_NAME          (idx, [1:   1]) = '2' ;

% Micro- and macro-group structures:

MICRO_NG                  (idx, 1)        = 70 ;
MICRO_E                   (idx, [1:  71]) = [  2.00000E+01  6.06550E+00  3.67900E+00  2.23100E+00  1.35300E+00  8.21000E-01  5.00000E-01  3.02500E-01  1.83000E-01  1.11000E-01  6.74300E-02  4.08500E-02  2.47800E-02  1.50300E-02  9.11800E-03  5.50000E-03  3.51910E-03  2.23945E-03  1.42510E-03  9.06898E-04  3.67262E-04  1.48728E-04  7.55014E-05  4.80520E-05  2.77000E-05  1.59680E-05  9.87700E-06  4.00000E-06  3.30000E-06  2.60000E-06  2.10000E-06  1.85500E-06  1.50000E-06  1.30000E-06  1.15000E-06  1.12300E-06  1.09700E-06  1.07100E-06  1.04500E-06  1.02000E-06  9.96000E-07  9.72000E-07  9.50000E-07  9.10000E-07  8.50000E-07  7.80000E-07  6.25000E-07  5.00000E-07  4.00000E-07  3.50000E-07  3.20000E-07  3.00000E-07  2.80000E-07  2.50000E-07  2.20000E-07  1.80000E-07  1.40000E-07  1.00000E-07  8.00000E-08  6.70000E-08  5.80000E-08  5.00000E-08  4.20000E-08  3.50000E-08  3.00000E-08  2.50000E-08  2.00000E-08  1.50000E-08  1.00000E-08  5.00000E-09  1.00000E-11 ];

MACRO_NG                  (idx, 1)        = 2 ;
MACRO_E                   (idx, [1:   3]) = [  1.00000E+37  6.25000E-07  0.00000E+00 ];

% Micro-group spectrum:

INF_MICRO_FLX             (idx, [1: 140]) = [  5.72027E+05 0.00214  2.75861E+06 0.00175  6.46633E+06 0.00070  1.23969E+07 0.00051  1.38917E+07 0.00040  1.39768E+07 0.00025  1.16212E+07 0.00023  9.42407E+06 0.00057  1.14251E+07 0.00015  1.13355E+07 0.00015  1.20205E+07 0.00019  1.19200E+07 0.00015  1.24144E+07 0.00011  1.22944E+07 0.00015  1.23782E+07 0.00012  1.09049E+07 0.00016  1.10017E+07 0.00016  1.09839E+07 0.00026  1.09587E+07 0.00014  2.18432E+07 5.8E-05  2.16904E+07 0.00016  1.61233E+07 0.00016  1.06507E+07 0.00016  1.28320E+07 0.00018  1.26334E+07 0.00021  1.08743E+07 0.00018  1.99714E+07 0.00018  4.29532E+06 0.00020  5.39304E+06 0.00028  4.85473E+06 0.00026  2.85593E+06 0.00035  4.97690E+06 0.00067  3.42526E+06 0.00048  2.99073E+06 0.00033  5.86379E+05 0.00071  5.80919E+05 0.00136  5.97841E+05 0.00077  6.15857E+05 0.00072  6.11124E+05 0.00089  6.03629E+05 0.00063  6.22429E+05 0.00105  5.87948E+05 0.00069  1.11559E+06 0.00021  1.80356E+06 0.00029  2.35271E+06 0.00074  6.70995E+06 0.00025  8.53009E+06 0.00015  1.17270E+07 0.00021  9.10184E+06 0.00052  7.07303E+06 0.00034  5.58720E+06 0.00061  6.41337E+06 0.00059  1.13762E+07 0.00078  1.39471E+07 0.00046  2.31405E+07 0.00058  2.89610E+07 0.00041  3.39780E+07 0.00052  1.78409E+07 0.00070  1.14262E+07 0.00070  7.48369E+06 0.00088  6.36565E+06 0.00038  6.03749E+06 0.00116  4.59600E+06 0.00065  3.02795E+06 0.00027  2.54310E+06 0.00088  2.32314E+06 0.00097  1.88488E+06 0.00156  1.30062E+06 0.00128  8.21030E+05 0.00188  2.54117E+05 0.00297 ];

% Integral parameters:

INF_KINF                  (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Flux spectra in infinite geometry:

INF_FLX                   (idx, [1:   4]) = [  7.52935E+14 0.00042  4.58203E+14 0.00011 ];
INF_FISS_FLX              (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

INF_TOT                   (idx, [1:   4]) = [  4.04316E-01 2.5E-05  4.55798E-01 4.3E-06 ];
INF_CAPT                  (idx, [1:   4]) = [  1.81254E-04 0.00014  3.06048E-03 9.0E-05 ];
INF_ABS                   (idx, [1:   4]) = [  1.81254E-04 0.00014  3.06048E-03 9.0E-05 ];
INF_FISS                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_NSF                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_NUBAR                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_KAPPA                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_INVV                  (idx, [1:   4]) = [  1.19650E-07 0.00013  2.08346E-06 9.0E-05 ];

% Total scattering cross sections:

INF_SCATT0                (idx, [1:   4]) = [  4.04135E-01 2.5E-05  4.52734E-01 6.0E-06 ];
INF_SCATT1                (idx, [1:   4]) = [  2.54135E-02 0.00037  1.17586E-02 0.00074 ];
INF_SCATT2                (idx, [1:   4]) = [  1.97104E-03 0.00337 -6.78833E-03 0.00148 ];
INF_SCATT3                (idx, [1:   4]) = [  3.06165E-04 0.01016 -5.88460E-03 0.00093 ];
INF_SCATT4                (idx, [1:   4]) = [ -5.02648E-04 0.01196 -6.66897E-03 0.00108 ];
INF_SCATT5                (idx, [1:   4]) = [  1.52526E-04 0.03011 -3.89578E-03 0.00086 ];
INF_SCATT6                (idx, [1:   4]) = [ -6.01973E-04 0.00601 -6.27211E-03 0.00081 ];
INF_SCATT7                (idx, [1:   4]) = [  2.04458E-04 0.00984 -8.36305E-04 0.00487 ];

% Total scattering production cross sections:

INF_SCATTP0               (idx, [1:   4]) = [  4.04135E-01 2.5E-05  4.52734E-01 6.0E-06 ];
INF_SCATTP1               (idx, [1:   4]) = [  2.54135E-02 0.00037  1.17586E-02 0.00074 ];
INF_SCATTP2               (idx, [1:   4]) = [  1.97104E-03 0.00337 -6.78833E-03 0.00148 ];
INF_SCATTP3               (idx, [1:   4]) = [  3.06165E-04 0.01016 -5.88460E-03 0.00093 ];
INF_SCATTP4               (idx, [1:   4]) = [ -5.02648E-04 0.01196 -6.66897E-03 0.00108 ];
INF_SCATTP5               (idx, [1:   4]) = [  1.52526E-04 0.03011 -3.89578E-03 0.00086 ];
INF_SCATTP6               (idx, [1:   4]) = [ -6.01973E-04 0.00601 -6.27211E-03 0.00081 ];
INF_SCATTP7               (idx, [1:   4]) = [  2.04458E-04 0.00984 -8.36305E-04 0.00487 ];

% Diffusion parameters:

INF_TRANSPXS              (idx, [1:   4]) = [  3.49883E-01 8.9E-05  4.42387E-01 2.3E-05 ];
INF_DIFFCOEF              (idx, [1:   4]) = [  9.52701E-01 8.9E-05  7.53489E-01 2.3E-05 ];

% Reduced absoption and removal:

INF_RABSXS                (idx, [1:   4]) = [  1.81254E-04 0.00014  3.06048E-03 9.0E-05 ];
INF_REMXS                 (idx, [1:   4]) = [  5.27278E-03 0.00022  5.15494E-03 0.00032 ];

% Poison cross sections:

INF_I135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_YIELD          (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_I135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MICRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_I135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_XE135_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM147_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM148M_MACRO_ABS      (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_PM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_SM149_MACRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison universe-averaged densities:

I135_ADENS                (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
XE135_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM147_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM148M_ADENS              (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
PM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
SM149_ADENS               (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Poison decay constants:

PM147_LAMBDA              (idx, 1)        =  0.00000E+00 ;
PM148_LAMBDA              (idx, 1)        =  0.00000E+00 ;
PM148M_LAMBDA             (idx, 1)        =  0.00000E+00 ;
PM149_LAMBDA              (idx, 1)        =  0.00000E+00 ;
I135_LAMBDA               (idx, 1)        =  0.00000E+00 ;
XE135_LAMBDA              (idx, 1)        =  0.00000E+00 ;
XE135M_LAMBDA             (idx, 1)        =  0.00000E+00 ;
I135_BR                   (idx, 1)        =  0.00000E+00 ;

% Fission spectra:

INF_CHIT                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHIP                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
INF_CHID                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

INF_S0                    (idx, [1:   8]) = [  3.99044E-01 2.4E-05  5.09174E-03 0.00024  2.09095E-03 0.00047  4.50643E-01 6.2E-06 ];
INF_S1                    (idx, [1:   8]) = [  2.66443E-02 0.00036 -1.23083E-03 0.00073 -1.93358E-04 0.00442  1.19520E-02 0.00074 ];
INF_S2                    (idx, [1:   8]) = [  2.16597E-03 0.00289 -1.94925E-04 0.00446 -1.61777E-04 0.00199 -6.62655E-03 0.00155 ];
INF_S3                    (idx, [1:   8]) = [  3.53778E-04 0.00933 -4.76127E-05 0.01027 -5.99861E-05 0.00623 -5.82461E-03 0.00099 ];
INF_S4                    (idx, [1:   8]) = [ -4.55815E-04 0.01226 -4.68322E-05 0.01278 -3.66218E-05 0.00783 -6.63235E-03 0.00106 ];
INF_S5                    (idx, [1:   8]) = [  1.52414E-04 0.02954  1.12363E-07 1.00000 -6.37180E-06 0.09760 -3.88941E-03 0.00084 ];
INF_S6                    (idx, [1:   8]) = [ -5.68624E-04 0.00658 -3.33484E-05 0.01551 -2.78234E-05 0.00778 -6.24429E-03 0.00082 ];
INF_S7                    (idx, [1:   8]) = [  1.68947E-04 0.01236  3.55110E-05 0.00826  1.26361E-05 0.02584 -8.48941E-04 0.00444 ];

% Scattering production matrixes:

INF_SP0                   (idx, [1:   8]) = [  3.99044E-01 2.4E-05  5.09174E-03 0.00024  2.09095E-03 0.00047  4.50643E-01 6.2E-06 ];
INF_SP1                   (idx, [1:   8]) = [  2.66443E-02 0.00036 -1.23083E-03 0.00073 -1.93358E-04 0.00442  1.19520E-02 0.00074 ];
INF_SP2                   (idx, [1:   8]) = [  2.16597E-03 0.00289 -1.94925E-04 0.00446 -1.61777E-04 0.00199 -6.62655E-03 0.00155 ];
INF_SP3                   (idx, [1:   8]) = [  3.53778E-04 0.00933 -4.76127E-05 0.01027 -5.99861E-05 0.00623 -5.82461E-03 0.00099 ];
INF_SP4                   (idx, [1:   8]) = [ -4.55815E-04 0.01226 -4.68322E-05 0.01278 -3.66218E-05 0.00783 -6.63235E-03 0.00106 ];
INF_SP5                   (idx, [1:   8]) = [  1.52414E-04 0.02954  1.12363E-07 1.00000 -6.37180E-06 0.09760 -3.88941E-03 0.00084 ];
INF_SP6                   (idx, [1:   8]) = [ -5.68624E-04 0.00658 -3.33484E-05 0.01551 -2.78234E-05 0.00778 -6.24429E-03 0.00082 ];
INF_SP7                   (idx, [1:   8]) = [  1.68947E-04 0.01236  3.55110E-05 0.00826  1.26361E-05 0.02584 -8.48941E-04 0.00444 ];

% Micro-group spectrum:

B1_MICRO_FLX              (idx, [1: 140]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Integral parameters:

B1_KINF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_KEFF                   (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_B2                     (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];
B1_ERR                    (idx, [1:   2]) = [  0.00000E+00 0.0E+00 ];

% Critical spectra in infinite geometry:

B1_FLX                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS_FLX               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reaction cross sections:

B1_TOT                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CAPT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_ABS                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_FISS                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NSF                    (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_NUBAR                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_KAPPA                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_INVV                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering cross sections:

B1_SCATT0                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT1                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT2                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT3                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT4                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT5                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT6                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATT7                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Total scattering production cross sections:

B1_SCATTP0                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP1                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP2                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP3                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP4                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP5                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP6                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SCATTP7                (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Diffusion parameters:

B1_TRANSPXS               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_DIFFCOEF               (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Reduced absoption and removal:

B1_RABSXS                 (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_REMXS                  (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Poison cross sections:

B1_I135_YIELD             (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_YIELD           (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_YIELD            (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_I135_MICRO_ABS         (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM147_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM148M_MICRO_ABS       (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_PM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MICRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_XE135_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SM149_MACRO_ABS        (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Fission spectra:

B1_CHIT                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHIP                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_CHID                   (idx, [1:   4]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering matrixes:

B1_S0                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S1                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S2                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S3                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S4                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S5                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S6                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_S7                     (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Scattering production matrixes:

B1_SP0                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP1                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP2                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP3                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP4                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP5                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP6                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
B1_SP7                    (idx, [1:   8]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

% Additional diffusion parameters:

CMM_TRANSPXS              (idx, [1:   4]) = [  3.18454E-01 0.00044  4.16999E-01 0.00059 ];
CMM_TRANSPXS_X            (idx, [1:   4]) = [  3.18562E-01 0.00049  4.16423E-01 0.00121 ];
CMM_TRANSPXS_Y            (idx, [1:   4]) = [  3.18704E-01 0.00039  4.16303E-01 0.00103 ];
CMM_TRANSPXS_Z            (idx, [1:   4]) = [  3.18097E-01 0.00064  4.18285E-01 0.00180 ];
CMM_DIFFCOEF              (idx, [1:   4]) = [  1.04673E+00 0.00044  7.99364E-01 0.00059 ];
CMM_DIFFCOEF_X            (idx, [1:   4]) = [  1.04637E+00 0.00049  8.00473E-01 0.00121 ];
CMM_DIFFCOEF_Y            (idx, [1:   4]) = [  1.04590E+00 0.00039  8.00703E-01 0.00103 ];
CMM_DIFFCOEF_Z            (idx, [1:   4]) = [  1.04790E+00 0.00064  7.96915E-01 0.00180 ];

% Delayed neutron parameters (Meulekamp method):

BETA_EFF                  (idx, [1:  14]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];
LAMBDA                    (idx, [1:  14]) = [  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00  0.00000E+00 0.0E+00 ];

