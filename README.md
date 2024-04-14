
<p align="left"> <img src="https://komarev.com/ghpvc/?username=ahmedsamirscience&label=Profile%20views&color=0e75b6&style=flat" alt="ahmedsamirscience" /> </p>
# Membrane Proteins Simulation.

***
## Introduction:
Simulations of membrane proteins have been rising in popularity in the past decade. Advancements in technology and force fields made it possible to simulate behavior of membrane proteins. Membrane protein simulations can now be used as supporting evidence for experimental findings, for elucidating protein mechanisms, and validating protein crystal structures. Unrelated to experimental data, these simulations can also serve to investigate larger scale processes like protein sorting, protein–membrane interactions, and more. In this review, the history as well as the state-of-the-art methodologies in membrane protein simulations will be summarized. An emphasis will be put on how to set up the system and on the current models for the different components of the simulation system. An overview of the available tools for membrane protein simulation will be given, and current limitations and prospects will also be discussed. This tutorial is designed to guide users of VMD and NAMD through all the steps required to set up a membrane protein system for molecular dynamics simulations. The tutorial assumes that you already have a working knowledge of VMD and NAMD. For the accompanying VMD and NAMD tutorials go to: [here](http://www.ks.uiuc.edu/Training/Tutorials/) This tutorial has been designed specifically for VMD 1.8.6 and NAMD 2.6 but will also work with VMD 1.8.7 and NAMD 2.7. It should take about 5 hours to complete in its entirety. This time can be reduced by skipping the optional section 1.5 and by using the example scripts where provided. The tutorial is subdivided into three separate units. The first unit covers steps required to set up a structural model of a membrane protein starting from a raw PDB file. The second unit describes the steps needed to place the protein in a native-like membrane environment. Finally, the third unit describes the steps required to minimize and equilibrate the resulting system with NAMD. The examples in the tutorial will focus on the study of the KcsA membrane protein – an archetypal potassium channel with very interesting properties. Throughout the text, some material will be presented in separate “boxes”. These boxes include complementary information to the tutorial, such as information about the biological role of KcsA, and tips or technical details that can be further explored by the advanced user.

***
## 1 - Building a Structural Model of KcsA:
In this unit you will build the KcsA tetramer solvated in water, learning how to take a raw protein structure and build a simulation-ready system out of it. Our first step is to download the raw protein structure from the Protein Data Bank, an online repository for protein structures experimentally resolved, and
view it using VMD. The PDB file 1K4C.pdb contains the atom coordinates of a monomer of KcsA. We see that the PDB file also contains water molecules, ions, large antibody complexes (used to crystallize the KcsA) as well as some lipid fragments. These different structural elements are divided into “chains” in the PDB file, which we will see in detail in the next section. For now, the point is simply that the PDB files you download will contain structures that you want and structures that you don’t, but that these are easily separated from one another. PDB files are simply text files, and contain more information than just atomic coordinates. Here we will look at the file you downloaded in a text editor and examine its contents. As you discover yourself, the PDB file 1K4C.pdb contains only one subunit of
the KcsA tetramer. However, for most proteins, there is only one subunit, or all subunits are present in the original PDB file. Here you will build the whole
KcsA tetramer, noting that for many other membrane proteins, this step will not be necessary.

<p  href="url" align="center"  >
  <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic1.png"             height="300" width="400"  />
 <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic2.png"              height="300" width="400" /> 
</p>

<p  href="url" align="center"  >
  <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic3.png"             height="300" width="400"  />
 <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic4.png"              height="300" width="400" /> 
</p>


<p  href="url" align="center"  >
 <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic5.png"              height="300" width="400" /> 
</p>

***
## 2 - Placing KcsA in a Membrane:
In this second unit, you will learn how to take your solvated KcsA channel and place it in a membrane. Then you will solvate and ionize the entire system. The first step is to prepare a complete membrane. This is usually done by replicating a pre-equilibrated patch of membrane and water, then trimming it if necessary. The VMD Membrane Builder plugin automates this process. The steps in this section and the following one (Alignment of Membrane and Protein) are also covered in the script memprot-align.tcl. NOTE: If you skipped the previous section, you should either use the files kcsa solv.psf and kcsa solv.pdb from the example output, or replace every instance of these files with kcsav.psf and kcsav.pdb in the following instructions. Now that we have a suitable membrane patch and a partially solvated protein, the next step is to align them with one another properly. Now we need to make room for the KcsA in the membrane layer, so that the protein doesn’t overlap any lipid molecules. As in the section above on using Grubm¨uller’s Solvate program, we want to find good selection criteria in VMD,
and then mark the molecules we want to delete. All commands in this section are also included in the script remove lipwat.tcl. We will again use the beta field of the atoms to mark the “bad lipids”. This time, though, the selection will be slightly more complicated. We will now solvate and ionize the system. VMD’s Solvate plugin is quite simple: it places your solute in a box of water of a specified size, then removes water which is within a certain cut-off distance. We will remove any water which adds inside the lipid bilayer as well. Steps 2-6 are also included in the script solv remove.tcl.


<p  href="url" align="center"  >
  <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic6.png"             height="300" width="400"  />
 <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic7.png"              height="300" width="400" /> 
</p>

<p  href="url" align="center"  >
  <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic9.png"             height="300" width="400"  />
 <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic10.png"              height="300" width="400" /> 
</p>


***
## 3 - Running a Simulation of KcsA:
In unit 3, you will use the model containing KcsA embedded in a membrane to perform molecular dynamics simulations and obtain an equilibrated system.
When using a membrane patch that has not been equilibrated, like those provided by the membrane plugin of VMD, we strongly recommend to perform first a simulation in which everything (water, ions, protein, lipid headgroups) except lipid tails, is fixed. In this way we will induce the appropriate disorder of a fluid-like bilayer. Here we will prepare and run such simulation. The position of the center of the cell should roughly match the position found in the NAMD configuration file. However, the measure minmax command willreturn values equivalent to cell dimensions that are larger than what we actually have in the configuration file ({84, 81, 90} instead of {77, 77, 90}). This apparent inconsistency is caused by fragments of lipid molecules, which usually stick out from the boundary of the simulation cell, but are not wrapped unless the center of mass of the whole lipid crosses the periodic boundary. One can avoid this problem by using a selection that does not contain lipids. We are not quite ready for running the system with full dynamics. Because we have put our system together by hand, it has many unnatural atomic positions. If we tried to do a dynamics run now, it would immediately fail, with many atoms moving at very high velocity. Thus, our second run with NAMD will be a “minimization” run, which simply guides the system to the nearest local energy minimum in configuration space. Minimization will be then followed by an equilibration with the protein constrained, so as to permit the environment to relax first. The first set of additional parameters impose harmonic constraints on the protein. Harmonics constraints are applied using a PDB file that tags the atoms to be restrained. This file will be generated below. The use of such harmonic constraints permits lipids, water, and ions to adapt to the protein in its crystal form. In addition, we use the margin 3 command to allow large volume fluctuations
that are typical during the first dynamics of a new system in an NpT ensemble. Otherwise, the simulation will likely finish with the message: FATAL ERROR: Periodic cell has become too small for original patch grid! (in which case you should just restart your simulation from the last saved restart files).
The second set of additional parameters calls a Tcl script, named keep water out.tcl, which prevents hydration of the membrane-protein interface during equilibration. Now that the protein has been equilibrated, we are ready to perform production runs. There will be one main difference with the previous simulations you have already performed. Production runs may feature additional parameters or employ different computational techniques that suit the purpose of the investigation being carried out. The outcome of the simple production run presented here can already be analyzed in a number of different ways. For instance, you may want to try different VMD tools that allow you to compute density of water molecules, ions,or lipids, as well as electrostatic potentials, RMSD, motion of center of mass and diffusion of molecules. This ends the Membrane Proteins tutorial. We hope that you learned a lot with it, and that you will make a great use of all the capabilities VMD and NAMD have to offer for simulations of membrane protein systems.

<p  href="url" align="center"  >
  <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic11.png"             height="300" width="400"  />
 <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic12.png"              height="300" width="400" /> 
</p>

<p  href="url" align="center"  >
  <img src="https://github.com/AhmedSamirScience/Membrane_Proteins_Simulation./blob/main/pic13.png"             height="300" width="400"  />
</p>

***
## ➠ Start Contributing ☺
I will be more than happy if you decide to contribute and/or fork my repo and make something awesome out of it. I will love seeing some feedback or stars from you guys.

***
#### ➠ To get more information about our repository, just send us a message from [here](https://www.linkedin.com/in/ahmedsamir13/) and we will send you the documents related to this study for a better understanding!
 
***

