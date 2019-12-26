
# Table of contents

1. [Overview](#overview)
   1. [Protocols](#protocols)
   2. [Experiments](#experiments)
   3. [Instruments](#instruments)
   4. [Logging](#logging)
   5. [Data collection](#data-collection)
2. [Installing and updating](#installing-and-updating)
3. [Adding research instruments](#adding-research-instruments)
4. [Setting up an experiment](#setting-up-an-experiment)
5. [Running experiments](#running-experiments)
6. [Exporting data](#exporting-data)
7. [Data analysis](#data-analysis)
   1. [Matlab](#matlab)
   2. [Excel](#excel)
8. [Writing protocols](#writing-protocols)
   1. [Tests](#tests)
9. [Terms and abbreviations](#terms-and-abbreviations)

# Overview

LabBench is a software system for running neuroscience experiments on human subjects. It is based on best practices for running scientific studies, gained from more than 3000+ experiments in 25+ years at Center for Sensory-Motor Interaction (SMI), Aalborg University. Best practices that includes:

1. Do all planning and thinking before your experiment, during your experiment your focus should be on the subject, the experimental procedures, and nothing else.
2. Document everything about your experimental protocol before your experiments, making it easy and possible to reproduce your results.
3. Automate everything that can be automated, especially data storage in a way that ensures that data are stored in a consistent manner that makes it easy to analyse when the experiment is completed.
4. Make it possible to share your experimental protocols with other scientists, thereby making your discoveries more applicable and useful to the scientific community at large.

Consequently, LabBench is an attempt to solve a paradox that riddles scientific studies. Software for scientific studies needs to be adaptable and flexible as scientists always want to do something novel, and at the same time experiments needs to be conducted in a very inflexible and displined way to ensure that all results are comparable and that the experiment can be reproduced.

The classical approach to this is to cram as many functions and the possibility perhaps to write scripts into the user interface. This certaintly maximizes the adaptability and flexibility of the software, however, it also maximizes the complexity of the user interface and maximizes the possibility of mistakes during an experiment. With the classical approach, the experience and displine of the scientist running the experiment is the only thing that ensures that the experiment is run in a consistent and reproducible manner.

LabBench takes a diffirent approach, and instead it only provide adaptability and flexibility when it is needed. This is accomplised by automating experiments as much as possible, which is accomplies with protocol files that defines all procedures and their parameters in an experiment. When this protocol is executed by LabBench it guides the scientist through the experiment, presents only the user interface that is relevant to the experiment, automates setting up experimental procedures, and the storage of data.

Consequently, running an experiment with LabBench consists of the following steps:

1. Defining a protocol and experiment, by planning all intended experimental procedures and documenting them in a protocol.
2. Using LabBench to execute this protocol in a series of sessions in the experiment.
3. Exporting, analysing and publishing the data obtained in the experiment.

This overview if intended to introduce you to the philosophy of how LabBench works and its central concepts. The following sections will introduce you to these central concepts, but will explain how they are implemented in LabBench. For a detailed explanation of how to use these concepts, please refer to later sections in this manual.

## Protocols

To run an experiment with LabBench you will need to write a protocol in the form of a text file termed a protocol definition file (*.prtx). This file contains a list of all the experimental procedures in the experiment, which in LabBench is referred to as tests.

When executed in an experiment each test will produce a result that is automatically saved by LabBench when the test has been completed and accepted by the experimentor. A test can also use one or more results from previously executed tests in order to automatically setup the parameters from the test. For example, in an experiment where evoked EEG potentials are recorded you may wish to set the intensity of the stimuli that evokes the EEG potentials to a percentage of the pain thresholds. In LabBench this may be accomplished with a protocol containing two tests:

1. A [Multiple perception thresholds](method_of_limits.html) test that estimates the pain threshold.
2. A [Evoked responses](evoked_responses.html) test that uses the threshold determined by the first test to set the intensity of the stimuli used to evoke a response to a predefined percentage of the pain threshold.

However, this dependency is not hardcoded in the Evoked responses test. The intensity could come from any test from which an intensity can be calculated. The intensity may also be set from a [Stimulus-response](stimulus_response.html) test, as the intensity that evokes a predefined psychophysical response on a visual analog scale (VAS). In the above example this VAS scale may for example be defined with the anchor points of 0cm) no sensation, 4cm) pain threshold, 10cm) pain tolerance threshold.

## Instruments

## Experiments

## Logging

## Data collection

# Installing and updating

# Adding research instruments

# Setting up an experiment

# Running experiments

# Exporting data

# Data analysis

## Matlab

## Excel

# Writing protocols

## Tests

### Test definition

### Test documentation

* Metatests
  * [Subject information](subject_information.html)
  * [Subject factors](factors.html)
* Psychophysics
  * [Multiple perception thresholds](method_of_limits.html)
  * [Psi Threshold Estimation](psi_method.html)
  
# Terms and abbreviations
