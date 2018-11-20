#lang racket/base

#|
this file defines the structure used for storing information about
1 : elements and
2 : nuclear isotopes.

The elements.
An element is defined by its number in the periodic table which is determined by the number (P) of protons in the nucleus. We shall use the elemental number P as the identifier for the currently 118 known elements.
Examples: element number 1 is Hydrogen, element number 26 i Iron.
Some elements have more than one allotrope, meaning that they have differing characteristics based on their binding/crystalline structure. Think graphite vs diamond ! The data for certain elements will depend on where the elements originate from (based on isotopic distribution)

Nuclear isotopes
Any given isotope is defined by having a number of protons (P)and neutrons (N). The number of nucleons (A) = protons (P) + neutrons (N), ie. a proton and a neutron are both nucleons.
We shall use CAPITAL LETTERS P;N;A to denote the full number of nucleons in a isotope and the small letters p,n,a to denote a single nucleon.
Any isotope can be defined and identified by any combination of two of the three P, N and A. We shall use the combination '(P A) to uniquely identify an isotope. Therefore the number of neutrons are calculated as N=A-P.
Examples:
'(1 1) is P=1, N=0 and A=1 is a Hydrogen-1 (a stable isotope).
'(9 20) is P=9, N=20-9=11 and A=20 is Fluor-20 (happens to be radioactive)
Since the Karlsruher Nuklidkarte contains some 3200 isotopes, it is worthwhile storing the information in a hash rather than a simple list.
|#

(struct element (symbol name atomic-wt) #:transparent)
;; hashed table of elements.
;; Key = elemental number
(define *elm*
  (hash 1  (element 'H  'hydrogen       1.00797)
        2  (element 'He 'helium         4.00260)
        3  (element 'Li 'lithium        6.941)
        4  (element 'Be 'beryllium      9.01218)
        5  (element 'B  'boron         10.81)
        6  (element 'C  'carbon        12.011)
        7  (element 'N  'nitrogen      14.0067)
        8  (element 'O  'oxygen        15.9994)
        9  (element 'F  'fluorine      18.9984)
        10 (element 'Ne 'neon          20.179)
        11 (element 'Na 'sodium        22.9898)
        12 (element 'Mg 'magnesium     24.305)
        13 (element 'Al 'aluminum      26.9815)
        14 (element 'Si 'silicon       28.086)
        15 (element 'P  'phosphorous   30.9738)
        16 (element 'S  'sulphur       32.06)
        17 (element 'Cl 'chlorine      35.453)
        18 (element 'Ar 'argon         39.948)
        19 (element 'K  'potassium     39.0983)
        20 (element 'Ca 'calcium       40.08)
        21 (element 'Sc 'scandium      44.9559)
        22 (element 'Ti 'titanium      47.90)
        23 (element 'V  'vanadium      50.9414)
        24 (element 'Cr 'chromium      51.996)
        25 (element 'Mn 'manganese     54.9380)
        26 (element 'Fe 'iron          55.847)
        27 (element 'Co 'cobalt        58.9332)
        28 (element 'Ni 'nickel        58.71)
        29 (element 'Cu 'copper        63.546)
        30 (element 'Zn 'zinc          65.38)
        31 (element 'Ga 'gallium       69.72)
        32 (element 'Ge 'germanium     72.59)
        33 (element 'As 'arsene        74.9216)
        34 (element 'Se 'selene        78.96) 
        35 (element 'Br 'bromine       79.904)
        36 (element 'Kr 'krypton       83.80)
        37 (element 'Rb 'rubidium      85.4678)
        38 (element 'Sr 'strontium     87.62)
        39 (element 'Y  'yttrium       88.9059)
        40 (element 'Zr 'zirconium     91.22)
        41 (element 'Nb 'niobium       92.9064)
        42 (element 'Mo 'molybdenum    95.94)
        43 (element 'Tc 'technetium    98.9062) ; non-stable
        44 (element 'Ru 'ruthenium    101.07)
        45 (element 'Rh 'rhodium      102.9055)
        46 (element 'Pd 'palladium    106.4)
        47 (element 'Ag 'silver       107.868)
        48 (element 'Cd 'cadmium      112.41)
        49 (element 'In 'indium       114.82)
        50 (element 'Sn 'tin          118.69)
        51 (element 'Sb 'antimony     121.75)
        52 (element 'Te 'tellurium    127.60)
        53 (element 'I  'iodine       126.9045)
        54 (element 'Xe 'xenon        131.30)
        55 (element 'Cs 'cesium       132.9054)
        56 (element 'Ba 'barium       137.34)
        57 (element 'La 'lanthan      138.9055)
        58 (element 'Ce 'cerium       140.12)
        59 (element 'Pr 'praseodymium 140.9077)
        60 (element 'Nd 'neodymium    144.24)
        61 (element 'Pm 'promethium   145) ; non-stable
        62 (element 'Sm 'samarium     150.4)
        63 (element 'Eu 'europium     151.96)
        64 (element 'Gd 'gadolinium   157.25)
        65 (element 'Tb 'terbium      158.9254)
        66 (element 'Dy 'dysprosium   162.50)
        67 (element 'Ho 'holmium      164.9304)
        68 (element 'Er 'erbium       167.26)
        69 (element 'Tm 'thulium      168.9342)
        70 (element 'Yb 'ytterbium    173.04)
        71 (element 'Lu 'luthetium    174.97)
        72 (element 'Hf 'hafnium      178.49)
        73 (element 'Ta 'tantalum     180.9479)
        74 (element 'W  'wolfram      183.85)
        75 (element 'Re 'rhenium      186.2)
        76 (element 'Os 'osmium       190.2)
        77 (element 'Ir 'iridium      192.22)
        78 (element 'Pt 'platinum     195.09)
        79 (element 'Au 'gold         196.9665)
        80 (element 'Hg 'quicksilver  299.59)
        81 (element 'Tl 'thallium     204.37)
        82 (element 'Pb 'lead         207.2)
        83 (element 'Bi 'bismuth      208.9808)
        84 (element 'Po 'polonium     209) ; non-stable
        85 (element 'At 'astatine     210) ; non-stable
        86 (element 'Rn 'radon        222) ; non-stable
        87 (element 'Fr 'francium     223) ; non-stable
        88 (element 'Ra 'radium       226.0254)
        89 (element 'Ac 'actinium     227) ; non-stable
        90 (element 'Th 'thorium      232.0381)
        91 (element 'Pa 'protactinium 231.0359) ; non-stable
        92 (element 'U  'uranium      238.029)
        93 (element 'Np 'neptunium    237.0482)
        94 (element 'Pu 'plutonium    244) ; non-stable
        95 (element 'Am 'americium    243) ; non-stable
        96 (element 'Cm 'curium       247) ; non-stable
        97 (element 'Bk 'berkelium    247) ; non-stable
        98 (element 'Cf 'californium  251) ; non-stable
        99 (element 'Es 'einsteinium  252) ; non-stable
        100 (element 'Fm 'fermium     257) ; non-stable
        101 (element 'Md 'mendelevium 258) ; non-stable
        102 (element 'No 'nobelium    259) ; non-stable
        103 (element 'Lr 'lawrencium  260) ; non-stable
        104 (element 'Rf 'rutherfordium 261) ; non-stable
        105 (element 'Db 'dubnium      'NaN) ; non-stable
        106 (element 'Sg 'seaborgium   'NaN) ; non-stable
        107 (element 'Bh 'bohrium      'NaN) ; non-stable
        108 (element 'Hs 'hassium      'NaN) ; non-stable
        109 (element 'Mt 'meitnerium   'NaN) ; non-stable
        110 (element 'Ds 'darmstadtium 'NaN) ; non-stable
        111 (element 'Rg 'roengtenium  'NaN) ; non-stable
        112 (element 'Cn 'copernicium  'NaN) ; non-stable
        113 (element 'Nh 'nihonium     'NaN) ; non-stable
        114 (element 'Fl 'flerovium    'NaN) ; non-stable
        115 (element 'Mc 'moscovium    'NaN) ; non-stable
        116 (element 'Lv 'livermorium  'NaN) ; non-stable
        117 (element 'Ts 'tennesine    'NaN) ; non-stable
        118 (element 'Og 'oganneson    'NaN) ; non-stable
        ))


























        