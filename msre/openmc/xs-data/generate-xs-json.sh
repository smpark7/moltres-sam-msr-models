#!/bin/bash

cp ../900K/msre_ce.py msre-900K.py
cp ../1200K/msre_ce.py msre-1200K.py
cp ../900K/statepoint.150.h5 statepoint-900K.h5
cp ../1200K/statepoint.150.h5 statepoint-1200K.h5
cp ../900K/summary.h5 summary-900K.h5
cp ../1200K/summary.h5 summary-1200K.h5
python ~/projects/moltres/python/moltres_xs.py msre_mgxs.inp
rm *.py *.h5 *.xml
