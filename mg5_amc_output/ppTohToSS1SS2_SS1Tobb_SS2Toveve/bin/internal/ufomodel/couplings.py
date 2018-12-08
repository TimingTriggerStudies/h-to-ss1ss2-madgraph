# This file was automatically created by FeynRules 2.3.13
# Mathematica version: 11.0.1 for Mac OS X x86 (64-bit) (September 21, 2016)
# Date: Wed 23 May 2018 22:20:22


from object_library import all_couplings, Coupling

from function_library import complexconjugate, re, im, csc, sec, acsc, asec, cot



GC_1 = Coupling(name = 'GC_1',
                value = '-(ee*complex(0,1))/3.',
                order = {'QED':1})

GC_2 = Coupling(name = 'GC_2',
                value = '(2*ee*complex(0,1))/3.',
                order = {'QED':1})

GC_3 = Coupling(name = 'GC_3',
                value = 'ee*complex(0,1)',
                order = {'QED':1})

GC_4 = Coupling(name = 'GC_4',
                value = 'ee**2*complex(0,1)',
                order = {'QED':2})

GC_5 = Coupling(name = 'GC_5',
                value = '-G',
                order = {'QCD':1})

GC_6 = Coupling(name = 'GC_6',
                value = 'complex(0,1)*G',
                order = {'QCD':1})

GC_7 = Coupling(name = 'GC_7',
                value = 'complex(0,1)*G**2',
                order = {'QCD':2})

GC_8 = Coupling(name = 'GC_8',
                value = '-(complex(0,1)*GH)',
                order = {'HIG':1})

GC_9 = Coupling(name = 'GC_9',
                value = '-(G*GH)',
                order = {'HIG':1,'QCD':1})

GC_10 = Coupling(name = 'GC_10',
                 value = 'complex(0,1)*G**2*GH',
                 order = {'HIG':1,'QCD':2})

GC_11 = Coupling(name = 'GC_11',
                 value = 'complex(0,1)*gHSS',
                 order = {'HIG':1})

GC_12 = Coupling(name = 'GC_12',
                 value = 'complex(0,1)*gS1',
                 order = {'HIG':1})

GC_13 = Coupling(name = 'GC_13',
                 value = 'complex(0,1)*gS2',
                 order = {'HIG':1})

GC_14 = Coupling(name = 'GC_14',
                 value = '-6*complex(0,1)*lam',
                 order = {'QED':2})

GC_15 = Coupling(name = 'GC_15',
                 value = '(ee**2*complex(0,1))/(2.*sw**2)',
                 order = {'QED':2})

GC_16 = Coupling(name = 'GC_16',
                 value = '-((ee**2*complex(0,1))/sw**2)',
                 order = {'QED':2})

GC_17 = Coupling(name = 'GC_17',
                 value = '(cw**2*ee**2*complex(0,1))/sw**2',
                 order = {'QED':2})

GC_18 = Coupling(name = 'GC_18',
                 value = '(ee*complex(0,1))/(sw*cmath.sqrt(2))',
                 order = {'QED':1})

GC_19 = Coupling(name = 'GC_19',
                 value = '-(cw*ee*complex(0,1))/(2.*sw)',
                 order = {'QED':1})

GC_20 = Coupling(name = 'GC_20',
                 value = '(cw*ee*complex(0,1))/(2.*sw)',
                 order = {'QED':1})

GC_21 = Coupling(name = 'GC_21',
                 value = '(cw*ee*complex(0,1))/sw',
                 order = {'QED':1})

GC_22 = Coupling(name = 'GC_22',
                 value = '(-2*cw*ee**2*complex(0,1))/sw',
                 order = {'QED':2})

GC_23 = Coupling(name = 'GC_23',
                 value = '-(ee*complex(0,1)*sw)/(6.*cw)',
                 order = {'QED':1})

GC_24 = Coupling(name = 'GC_24',
                 value = 'ee**2*complex(0,1) + (cw**2*ee**2*complex(0,1))/(2.*sw**2) + (ee**2*complex(0,1)*sw**2)/(2.*cw**2)',
                 order = {'QED':2})

GC_25 = Coupling(name = 'GC_25',
                 value = '-6*complex(0,1)*lam*vev',
                 order = {'QED':1})

GC_26 = Coupling(name = 'GC_26',
                 value = '(ee**2*complex(0,1)*vev)/(2.*sw**2)',
                 order = {'QED':1})

GC_27 = Coupling(name = 'GC_27',
                 value = 'ee**2*complex(0,1)*vev + (cw**2*ee**2*complex(0,1)*vev)/(2.*sw**2) + (ee**2*complex(0,1)*sw**2*vev)/(2.*cw**2)',
                 order = {'QED':1})

GC_28 = Coupling(name = 'GC_28',
                 value = '-((complex(0,1)*yb)/cmath.sqrt(2))',
                 order = {'QED':1})

GC_29 = Coupling(name = 'GC_29',
                 value = '-((complex(0,1)*yt)/cmath.sqrt(2))',
                 order = {'QED':1})

