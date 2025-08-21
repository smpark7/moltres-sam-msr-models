import openmc
import sys
import os
import matplotlib.pyplot as plt
import numpy as np
#sys.path.insert(1, '/home/smpark/projects/hybrid-sn-diff')
#sys.path.insert(1, '/home/smpark/projects/alt-moltres/python')
sys.path.insert(1,
                '/home1/10525/smpark3/projects/moltres/python')
from moltres_xs import openmc_xs # noqa: E402

inch = 2.54

# %% Materials

fuel = openmc.Material(material_id=103)
# Fuel composition after additional loadings (U235 = 71.71kg)
r = (71.71-65.25) / (72-65.25)
r = 0
fuel_dens = 2.3275 * (1 + ((4641.50 / 4629.80) - 1) * r)
fuel.set_density('g/cm3', fuel_dens)
fuel_elements = {'Li7': (507.27 + (507.85-507.27) * r) * .99995,
                 'Li6': (507.27 + (507.85-507.27) * r) * .00005,
                 'Be': 293.96,
                 'F': 3103.22 + (3107.08-3103.22) * r,
                 'Zr': 513.97,
                 'Hf': 0.0029,
                 'Fe': 0.75,
                 'Cr': 0.13,
                 'Ni': 0.14,
                 'O16': 2.27,
                 'U234': .67 + (.73-.67) * r,
                 'U235': 65.25 + (72-65.25) * r,
                 'U236': .27 + (.30-.27) * r,
                 'U238': 141.91 + (142.32-141.91) * r}
total_fuel_weight = sum(fuel_elements.values())
for i in fuel_elements.keys():
    if len(i) < 3:
        fuel.add_element(i, fuel_elements[i]/total_fuel_weight, 'wo')
    else:
        fuel.add_nuclide(i, fuel_elements[i]/total_fuel_weight, 'wo')
fuel.temperature = 900

ctrlrod = openmc.Material(material_id=101)
ctrlrod.set_density('g/cm3', 5.873)
ctrlrod_elements = {'Gd': 70 * 157.25 * 2 / (157.25 * 2 + 15.999 * 3),
                    'Al': 30 * 26.982 * 2 / (26.982 * 2 + 15.999 * 3),
                    'O16': 15.999 * 3 * (70 / (157.25 * 2 + 15.999 * 3) +
                                       30 / (26.982 * 2 + 15.999 * 3))}
total_ctrlrod_weight = sum(ctrlrod_elements.values())
for i in ctrlrod_elements.keys():
    if len(i) < 3:
        ctrlrod.add_element(i, ctrlrod_elements[i]/total_ctrlrod_weight, 'wo')
    else:
        ctrlrod.add_nuclide(i, ctrlrod_elements[i]/total_ctrlrod_weight, 'wo')
ctrlrod.temperature = 900

air = openmc.Material(material_id=102)
air.set_density('g/cm3', .006)
air_elements = {'N': 14.007 * .95,
                'O16': 15.999 * .05}
total_air_weight = sum(air_elements.values())
for i in air_elements.keys():
    if len(i) < 3:
        air.add_element(i, air_elements[i]/total_air_weight, 'wo')
    else:
        air.add_nuclide(i, air_elements[i]/total_air_weight, 'wo')
air.temperature = 900

graphite = openmc.Material(material_id=104)
graphite_dens = 1.86
graphite.set_density('g/cm3', graphite_dens)
graphite.add_nuclide('C0', 1, 'wo')
graphite.temperature = 900

# water = openmc.Material()
# water_dens = .997
# water.set_density('g/cm3', water_dens)
# water.add_element('H', 2/3, 'ao')
# water.add_element('O', 1/3, 'ao')
# water.temperature = 300
# 
# steel = openmc.Material()
# steel_dens = 7.87
# steel.set_density('g/cm3', steel_dens)
# steel.add_element('Fe', 1, 'ao')
# steel.temperature = 300
# 
# reflector = openmc.Material.mix_materials([water, steel], [.5, .5], 'vo')
# reflector.temperature = 300
# reflector.id = 105

inor = openmc.Material(material_id=106)
inor.set_density('g/cm3', 8.7745)
inor_elements = {'Ni': 71,
                 'Mo': 18,
                 'Cr': 8,
                 'Fe': 5,
                 'C': 0.08,
                 'Ti': 0.25,
                 'Al': 0.25,
                 'S': 0.02,
                 'Mn': 1,
                 'Si': 1,
                 'Cu': 0.35,
                 'B': 0.01,
                 'W': 0.5,
                 'P': 0.015,
                 'Co': 0.2}
total_inor_weight = sum(inor_elements.values())
for i in inor_elements.keys():
    inor.add_element(i, inor_elements[i]/total_inor_weight, 'wo')
inor.temperature = 900

basket_total_vol = np.pi * (inch * 2.25 / 2) ** 2
basket_inor_vol = (np.pi * ((2.25/2)**2 - (2.1875/2)**2)*3/4 + (1/16*2.1875*3)
                   + np.pi * (1/8)**2 * 12) * inch**2
basket_graphite_vol = 0.25 * 0.47 * 15 * inch**2
basket_fuel_vol = basket_total_vol - basket_inor_vol - basket_graphite_vol
basket = openmc.Material.mix_materials(
    [inor, graphite, fuel],
    [basket_inor_vol/basket_total_vol,
     basket_graphite_vol/basket_total_vol,
     basket_fuel_vol/basket_total_vol],
    'vo',
    name='basket')
basket.id = 107

lower_head = openmc.Material.mix_materials([fuel, inor], [0.908, 0.092], 'vo')
lower_head.temperature = 900
lower_head.id = 108

# Add thermal scattering data
fuel.add_s_alpha_beta('c_Be')
lower_head.add_s_alpha_beta('c_Be')
graphite.add_s_alpha_beta('c_Graphite')
# reflector.add_s_alpha_beta('c_H_in_H2O')
# reflector.add_s_alpha_beta('c_Fe56')

mats = openmc.Materials((ctrlrod, air, fuel, graphite, inor,
                         basket, lower_head))

# %% Geometry

# Graphite lattice surfaces
pitch = np.sqrt(2) * inch

zcyl1 = openmc.ZCylinder(x0=0.4/np.sqrt(2)*inch, y0=0.4/np.sqrt(2)*inch,
                         r=0.2*inch)
zcyl2 = openmc.ZCylinder(x0=-0.4/np.sqrt(2)*inch, y0=-0.4/np.sqrt(2)*inch,
                         r=0.2*inch)
diag_plane1 = openmc.Plane(a=-1, b=1, d=np.sqrt(2)*0.2*inch)
diag_plane2 = openmc.Plane(a=-1, b=1, d=-np.sqrt(2)*0.2*inch)
diag_plane3 = openmc.Plane(a=1, b=1, d=np.sqrt(2)*0.4*inch)
diag_plane4 = openmc.Plane(a=1, b=1, d=-np.sqrt(2)*0.4*inch)

# Vertical channel fuel cell
fuel_cell_v = openmc.Cell(fill=fuel)
fuel_region_v = (-diag_plane1 & +diag_plane2 & -diag_plane3 & +diag_plane4) | \
    -zcyl1 | -zcyl2
fuel_cell_v.region = fuel_region_v

# Vertical channel graphite cell
graphite_cell_v = openmc.Cell(fill=graphite)
graphite_cell_v.region = ~fuel_region_v

# Horizontal channel fuel cell
fuel_cell_h = openmc.Cell(fill=fuel)
fuel_region_h = fuel_region_v.rotate([0, 0, 90])
fuel_cell_h.region = fuel_region_h

# Horizontal channel graphite cell
graphite_cell_h = openmc.Cell(fill=graphite)
graphite_cell_h.region = ~fuel_region_h

# Graphite filler cell
graphite_cell = openmc.Cell(fill=graphite)
graphite_universe = openmc.Universe(cells=[graphite_cell])

# Vertical channel universe
channel_universe_v = openmc.Universe(cells=[fuel_cell_v, graphite_cell_v])

# Horizontal channel universe
channel_universe_h = openmc.Universe(cells=[fuel_cell_h, graphite_cell_h])

# Sample basket surfaces
zcyl_origin = np.sqrt(2) * inch / 2
basket_diag_plane = openmc.Plane(a=-1, b=1, d=0)
basket_zcyl1 = openmc.ZCylinder(x0=zcyl_origin,
                                y0=-zcyl_origin,
                                r=2.25*inch/2)
basket_zcyl2 = openmc.ZCylinder(x0=zcyl_origin,
                                y0=-zcyl_origin,
                                r=3.197)

# Sample basket cells
basket_graphite_cell = openmc.Cell(fill=graphite)
basket_graphite_cell.region = +basket_diag_plane & +basket_zcyl2
basket_fuel_cell = openmc.Cell(fill=fuel)
basket_fuel_cell.region = (-basket_diag_plane | -basket_zcyl2) & +basket_zcyl1
basket_sample_cell = openmc.Cell(fill=basket)
basket_sample_cell.region = -basket_zcyl1

# Sample basket universes
basket_top_left_universe = openmc.Universe(
    cells=[basket_graphite_cell, basket_fuel_cell, basket_sample_cell])
basket_bot_left_cell = openmc.Cell(fill=basket_top_left_universe)
basket_bot_left_cell.rotation = [0, 0, 90]
basket_bot_left_universe = openmc.Universe(
    cells=[basket_bot_left_cell])
basket_bot_right_cell = openmc.Cell(fill=basket_top_left_universe)
basket_bot_right_cell.rotation = [0, 0, 180]
basket_bot_right_universe = openmc.Universe(
    cells=[basket_bot_right_cell])
basket_top_right_cell = openmc.Cell(fill=basket_top_left_universe)
basket_top_right_cell.rotation = [0, 0, 270]
basket_top_right_universe = openmc.Universe(
    cells=[basket_top_right_cell])

# Control thimble surfaces
rod_zcyl1 = openmc.ZCylinder(x0=zcyl_origin,
                             y0=-zcyl_origin,
                             r=inch)
rod_zcyl2 = openmc.ZCylinder(x0=zcyl_origin,
                             y0=-zcyl_origin,
                             r=inch*(1-0.065))
rod_zcyl3 = openmc.ZCylinder(x0=zcyl_origin,
                             y0=-zcyl_origin,
                             r=1.08*inch/2)
rod_zcyl4 = openmc.ZCylinder(x0=zcyl_origin,
                             y0=-zcyl_origin,
                             r=0.84*inch/2)
rod1_zplane = openmc.ZPlane(z0=200.3425-(4.4+2.75)*inch)
rod2_zplane = openmc.ZPlane(z0=200.3425-2.75*inch)
rod3_zplane = openmc.ZPlane(z0=200.3425-2.75*inch)

# Control thimble cells
rod1_graphite_cell = openmc.Cell(fill=graphite)
rod1_graphite_cell.region = +basket_diag_plane & +basket_zcyl2
rod1_fuel_cell = openmc.Cell(fill=fuel)
rod1_fuel_cell.region = (-basket_diag_plane | -basket_zcyl2) & +rod_zcyl1
rod1_inor_cell = openmc.Cell(fill=inor)
rod1_inor_cell.region = -rod_zcyl1 & +rod_zcyl2
rod1_outer_air_cell = openmc.Cell(fill=air)
rod1_outer_air_cell.region = -rod_zcyl2 & +rod_zcyl3
rod1_inner_air_cell = openmc.Cell(fill=air)
rod1_inner_air_cell.region = -rod_zcyl4
rod2_graphite_cell = openmc.Cell(fill=graphite)
rod2_graphite_cell.region = +basket_diag_plane & +basket_zcyl2
rod2_fuel_cell = openmc.Cell(fill=fuel)
rod2_fuel_cell.region = (-basket_diag_plane | -basket_zcyl2) & +rod_zcyl1
rod2_inor_cell = openmc.Cell(fill=inor)
rod2_inor_cell.region = -rod_zcyl1 & +rod_zcyl2
rod2_outer_air_cell = openmc.Cell(fill=air)
rod2_outer_air_cell.region = -rod_zcyl2 & +rod_zcyl3
rod2_inner_air_cell = openmc.Cell(fill=air)
rod2_inner_air_cell.region = -rod_zcyl4
rod3_graphite_cell = openmc.Cell(fill=graphite)
rod3_graphite_cell.region = +basket_diag_plane & +basket_zcyl2
rod3_fuel_cell = openmc.Cell(fill=fuel)
rod3_fuel_cell.region = (-basket_diag_plane | -basket_zcyl2) & +rod_zcyl1
rod3_inor_cell = openmc.Cell(fill=inor)
rod3_inor_cell.region = -rod_zcyl1 & +rod_zcyl2
rod3_outer_air_cell = openmc.Cell(fill=air)
rod3_outer_air_cell.region = -rod_zcyl2 & +rod_zcyl3
rod3_inner_air_cell = openmc.Cell(fill=air)
rod3_inner_air_cell.region = -rod_zcyl4

rod1_ctrlrod_cell = openmc.Cell(fill=ctrlrod)
rod1_ctrlrod_cell.region = -rod_zcyl3 & +rod_zcyl4 & +rod1_zplane
rod1_air_cell = openmc.Cell(fill=air)
rod1_air_cell.region = -rod_zcyl3 & +rod_zcyl4 & -rod1_zplane
rod2_ctrlrod_cell = openmc.Cell(fill=ctrlrod)
rod2_ctrlrod_cell.region = -rod_zcyl3 & +rod_zcyl4 & +rod2_zplane
rod2_air_cell = openmc.Cell(fill=air)
rod2_air_cell.region = -rod_zcyl3 & +rod_zcyl4 & -rod2_zplane
rod3_ctrlrod_cell = openmc.Cell(fill=ctrlrod)
rod3_ctrlrod_cell.region = -rod_zcyl3 & +rod_zcyl4 & +rod3_zplane
rod3_air_cell = openmc.Cell(fill=air)
rod3_air_cell.region = -rod_zcyl3 & +rod_zcyl4 & -rod3_zplane

# Control rod universes
rod1_top_left_universe = openmc.Universe(
    cells=[rod1_graphite_cell, rod1_fuel_cell, rod1_inor_cell,
           rod1_outer_air_cell, rod1_inner_air_cell, rod1_ctrlrod_cell,
           rod1_air_cell])
rod1_bot_left_cell = openmc.Cell(fill=rod1_top_left_universe)
rod1_bot_left_cell.rotation = [0, 0, 90]
rod1_bot_left_universe = openmc.Universe(cells=[rod1_bot_left_cell])
rod1_bot_right_cell = openmc.Cell(fill=rod1_top_left_universe)
rod1_bot_right_cell.rotation = [0, 0, 180]
rod1_bot_right_universe = openmc.Universe(cells=[rod1_bot_right_cell])
rod1_top_right_cell = openmc.Cell(fill=rod1_top_left_universe)
rod1_top_right_cell.rotation = [0, 0, 270]
rod1_top_right_universe = openmc.Universe(cells=[rod1_top_right_cell])
rod2_top_left_universe = openmc.Universe(
    cells=[rod2_graphite_cell, rod2_fuel_cell, rod2_inor_cell,
           rod2_outer_air_cell, rod2_inner_air_cell, rod2_ctrlrod_cell,
           rod2_air_cell])
rod2_bot_left_cell = openmc.Cell(fill=rod2_top_left_universe)
rod2_bot_left_cell.rotation = [0, 0, 90]
rod2_bot_left_universe = openmc.Universe(cells=[rod2_bot_left_cell])
rod2_bot_right_cell = openmc.Cell(fill=rod2_top_left_universe)
rod2_bot_right_cell.rotation = [0, 0, 180]
rod2_bot_right_universe = openmc.Universe(cells=[rod2_bot_right_cell])
rod2_top_right_cell = openmc.Cell(fill=rod2_top_left_universe)
rod2_top_right_cell.rotation = [0, 0, 270]
rod2_top_right_universe = openmc.Universe(cells=[rod2_top_right_cell])
rod3_top_left_universe = openmc.Universe(
    cells=[rod3_graphite_cell, rod3_fuel_cell, rod3_inor_cell,
           rod3_outer_air_cell, rod3_inner_air_cell, rod3_ctrlrod_cell,
           rod3_air_cell])
rod3_bot_left_cell = openmc.Cell(fill=rod3_top_left_universe)
rod3_bot_left_cell.rotation = [0, 0, 90]
rod3_bot_left_universe = openmc.Universe(cells=[rod3_bot_left_cell])
rod3_bot_right_cell = openmc.Cell(fill=rod3_top_left_universe)
rod3_bot_right_cell.rotation = [0, 0, 180]
rod3_bot_right_universe = openmc.Universe(cells=[rod3_bot_right_cell])
rod3_top_right_cell = openmc.Cell(fill=rod3_top_left_universe)
rod3_top_right_cell.rotation = [0, 0, 270]
rod3_top_right_universe = openmc.Universe(cells=[rod3_top_right_cell])

# Reactor lattice
latt = openmc.RectLattice()
channel_rows = [0, 10, 16, 18, 22, 26, 28, 30, 30, 32, 32, 34, 36, 36, 36, 38,
                38, 38, 38, 38]
channel_rows = channel_rows + channel_rows[::-1]
row_length = len(channel_rows)
latt.pitch = (pitch, pitch)
latt.lower_left = [-pitch*row_length/2, -pitch*row_length/2]
cell_list = [[channel_universe_v, channel_universe_h] * (row_length//2),
             [channel_universe_h, channel_universe_v] * (row_length//2)]
latt_list = []
for i in range(row_length):
    n_graphite = int((row_length - channel_rows[i]) / 2)
    channel_universes = cell_list[i % 2][n_graphite:row_length-n_graphite]
    latt_list.append([graphite_universe,] * n_graphite +
                     channel_universes +
                     [graphite_universe,] * n_graphite)

# Insert sample basket in lattice list
latt_list[row_length//2-1][row_length//2+1] = basket_top_left_universe
latt_list[row_length//2][row_length//2+1] = basket_bot_left_universe
latt_list[row_length//2][row_length//2+2] = basket_bot_right_universe
latt_list[row_length//2-1][row_length//2+2] = basket_top_right_universe

# Insert control rod thimbles in lattice list
latt_list[row_length//2+1][row_length//2-1] = rod1_top_left_universe
latt_list[row_length//2+2][row_length//2-1] = rod1_bot_left_universe
latt_list[row_length//2+2][row_length//2] = rod1_bot_right_universe
latt_list[row_length//2+1][row_length//2] = rod1_top_right_universe
latt_list[row_length//2-1][row_length//2-3] = rod2_top_left_universe
latt_list[row_length//2][row_length//2-3] = rod2_bot_left_universe
latt_list[row_length//2][row_length//2-2] = rod2_bot_right_universe
latt_list[row_length//2-1][row_length//2-2] = rod2_top_right_universe
latt_list[row_length//2-3][row_length//2-1] = rod3_top_left_universe
latt_list[row_length//2-2][row_length//2-1] = rod3_bot_left_universe
latt_list[row_length//2-2][row_length//2] = rod3_bot_right_universe
latt_list[row_length//2-3][row_length//2] = rod3_top_right_universe

latt.universes = latt_list

bot_plane = openmc.ZPlane(z0=0, boundary_type='vacuum')
vessel_bot_plane = openmc.ZPlane(z0=inch)
latt_bot_plane = openmc.ZPlane(z0=33.9725)
latt_top_plane = openmc.ZPlane(z0=200.3425)
vessel_top_plane = openmc.ZPlane(z0=233.83875-inch)
top_plane = openmc.ZPlane(z0=233.83875, boundary_type='vacuum')
vessel_inner_zcyl = openmc.ZCylinder(r=73.660)
vessel_outer_zcyl = openmc.ZCylinder(r=76.200, boundary_type='vacuum')
offset = inch * 2
thimble_zcyl1 = openmc.ZCylinder(x0=offset, y0=offset, r=inch)
thimble_zcyl2 = openmc.ZCylinder(x0=-offset, y0=offset, r=inch)
thimble_zcyl3 = openmc.ZCylinder(x0=-offset, y0=-offset, r=inch)

# Lattice cell
latt_cell = openmc.Cell(fill=latt)
latt_cell.rotation = [0, 0, -45]
latt_cell.region = \
    -openmc.ZCylinder(r=70.168) & +latt_bot_plane & -latt_top_plane

# Outer fuel cell
outer_fuel_cell = openmc.Cell(fill=fuel)
outer_fuel_cell.region = \
    +openmc.ZCylinder(r=70.168) & -openmc.ZCylinder(r=70.485) \
    & +latt_bot_plane & -latt_top_plane

# Core can cell
core_can_cell = openmc.Cell(fill=inor)
core_can_cell.region = \
    +openmc.ZCylinder(r=70.485) & -openmc.ZCylinder(r=71.120) \
    & +latt_bot_plane & -latt_top_plane

# Downcomer cell
downcomer_cell = openmc.Cell(fill=fuel)
downcomer_cell.region = \
    +openmc.ZCylinder(r=71.120) & -openmc.ZCylinder(r=73.660) \
    & +latt_bot_plane & -latt_top_plane

# Reactor vessel cell
vessel_radial_cell = openmc.Cell(fill=inor)
vessel_radial_cell.region = +vessel_inner_zcyl & -vessel_outer_zcyl \
    & +vessel_bot_plane & -vessel_top_plane

# Lower head cell
lower_head_cell = openmc.Cell(fill=lower_head)
lower_head_cell.region = \
    +vessel_bot_plane & -latt_bot_plane & -vessel_inner_zcyl

# Upper head cell
upper_head_cell = openmc.Cell(fill=fuel)
upper_head_cell.region = \
    +latt_top_plane & -vessel_top_plane & -vessel_inner_zcyl & +thimble_zcyl1 \
    & +thimble_zcyl2 & +thimble_zcyl3

# Upper head thimbles
top_right_thimble_cell = openmc.Cell(fill=latt)
top_right_thimble_cell.rotation = [0, 0, -45]
top_right_thimble_cell.region = \
    -thimble_zcyl1 & +latt_top_plane & -vessel_top_plane
top_left_thimble_cell = openmc.Cell(fill=latt)
top_left_thimble_cell.rotation = [0, 0, -45]
top_left_thimble_cell.region = \
    -thimble_zcyl2 & +latt_top_plane & -vessel_top_plane
bot_left_thimble_cell = openmc.Cell(fill=latt)
bot_left_thimble_cell.rotation = [0, 0, -45]
bot_left_thimble_cell.region = \
    -thimble_zcyl3 & +latt_top_plane & -vessel_top_plane

# Bottom vessel cell
vessel_bot_cell = openmc.Cell(fill=inor)
vessel_bot_cell.region = +bot_plane & -vessel_bot_plane & -vessel_outer_zcyl

# Top vessel cell
vessel_top_cell = openmc.Cell(fill=inor)
vessel_top_cell.region = +vessel_top_plane & -top_plane & -vessel_outer_zcyl

# Reflector
# reflector_cell = openmc.Cell(fill=reflector)
# reflector_cell.region =\
#     +openmc.ZCylinder(r=76.200) & -openmc.ZCylinder(r=76.200+16*inch,
#                                                     boundary_type='vacuum')

# Combine into universe
universe = openmc.Universe(
        cells=[latt_cell, outer_fuel_cell, core_can_cell, downcomer_cell,
               vessel_radial_cell, lower_head_cell, upper_head_cell,
               top_right_thimble_cell, top_left_thimble_cell,
               bot_left_thimble_cell, vessel_bot_cell, vessel_top_cell])

# %% Plot
colors = {ctrlrod: "black",
          air: "gold",
          fuel: "red",
          graphite: "grey",
          inor: "steelblue",
#          reflector: "lightgrey",
          basket: "orange",
          lower_head: "chocolate"}

# Lower head
universe.plot(origin=(0, 0, 15),
              width=(inch*60, inch*60),
              basis='xy',
              pixels=(800, 800),
              color_by="material",
              colors=colors)

# Lattice
universe.plot(origin=(0, 0, 100),
              width=(inch*60, inch*60),
              basis='xy',
              pixels=(800, 800),
              color_by="material",
              colors=colors)
plt.savefig('lattice.png')

# Center
universe.plot(origin=(0, 0, 100),
              width=(inch*8, inch*8),
              basis='xy',
              pixels=(800, 800),
              color_by="material",
              colors=colors)

# Upper head
universe.plot(origin=(0, 0, 220),
              width=(inch*60, inch*60),
              basis='xy',
              pixels=(800, 800),
              color_by='material',
              colors=colors)

# XZ
universe.plot(origin=(0, 0, 117),
              width=(inch*60, 234),
              basis='xz',
              pixels=(800, 800),
              color_by='material',
              colors=colors)

# XZ + offset
universe.plot(origin=(0, inch*2, 117),
              width=(inch*60, 234),
              basis='xz',
              pixels=(800, 800),
              color_by='material',
              colors=colors)

# XZ - offset
universe.plot(origin=(0, -inch*2, 117),
              width=(inch*60, 234),
              basis='xz',
              pixels=(800, 800),
              color_by='material',
              colors=colors)
plt.savefig('lattice-xz.png')

# %% settings
batches = 150
inactive = 25
particles = 200000

settings = openmc.Settings()
box = openmc.stats.Box((-76.2, -76.2, 0),
                       (76.2, 76.2, 234),
                       only_fissionable=True)
src = openmc.Source(space=box)
settings.source = src
settings.batches = batches
settings.inactive = inactive
settings.particles = particles
settings.output = {'tallies': False}
settings.temperature = {'multipole': True,
                        'method': 'interpolation'}

# %% Moltres group constants
tallies_file = openmc.Tallies()
mats_id = []
for mat in mats:
    mats_id.append(mat.id)
domain_dict = openmc_xs.generate_openmc_tallies_xml(
    [1e-5, 0.625, 2e7],
    list(range(1, 7)),
    mats,
    mats_id,
    tallies_file,
)

# %% flux tally
# mesh = openmc.RegularMesh()
# mesh.dimension = [1524, 1]
# mesh.lower_left = [-76.2, -3.04]
# mesh.upper_right = [76.2, -2.04]
# 
# mesh_filter = openmc.MeshFilter(mesh)
# energy_boundaries = [1e-5, 8e-2, 6.25e-1, 4e0, 1.487e2,
#                      9.118e3, 6.734e4, 1.353e6, 2e7]
# energy_filter = openmc.EnergyFilter(energy_boundaries)
# 
# tally = openmc.Tally(name='flux')
# tally.filters = [energy_filter, mesh_filter]
# tally.scores = ['flux']
# tallies_file.append(tally)

# generate XML
mats.export_to_xml()

geom = openmc.Geometry(universe)
geom.export_to_xml()

settings.export_to_xml()
tallies_file.export_to_xml()

# # %% Setup MGXS tally
# 
# # groups = openmc.mgxs.EnergyGroups(energy_boundaries)
# # mgxs_lib = openmc.mgxs.Library(geom)
# # mgxs_lib.energy_groups = groups
# # mgxs_lib.mgxs_types = ['total', 'absorption', 'nu-fission', 'fission',
# #                        'nu-scatter matrix', 'multiplicity matrix', 'chi']
# # mgxs_lib.domain_type = "material"
# # mgxs_lib.domains = geom.get_all_materials().values()
# # mgxs_lib.by_nuclide = False
# # mgxs_lib.legendre_order = 2
# # mgxs_lib.check_library_for_openmc_mgxs()
# # mgxs_lib.build_library()
# # 
# # # tallies_file = openmc.Tallies()
# # mgxs_lib.add_to_tallies_file(tallies_file, merge=False)
# # tallies_file.export_to_xml()
# 
# # %% Run OpenMC
# 
# # openmc.run(threads=8)
