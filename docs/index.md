
# Table of contents

1. [Overview](#overview)
   1. [Protocols](#protocols)
   2. [Experiments](#experiments)
   3. [Devices and instruments](#devices-and-instruments)
   4. [Logging](#logging)
   5. [Data collection](#data-collection)
2. [Installing and updating](#installing-and-updating)
3. [Setting up devices](#setting-up-devices)
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

The classical approach to this is to cram as many functions as possible and the possibility perhaps to write scripts into the user interface. This certaintly maximizes the adaptability and flexibility of the software, however, it also maximizes the complexity of the user interface and maximizes the possibility of mistakes during an experiment. With the classical approach, the experience and displine of the scientist running the experiment is the only thing that ensures that the experiment is run in a consistent and reproducible manner.

LabBench takes a diffirent approach, and instead it only provide adaptability and flexibility when it is needed. This is accomplised by automating experiments as much as possible, which is accomplies with protocol files that defines all procedures and their parameters in an experiment. When this protocol is executed by LabBench it guides the scientist through the experiment, presents only the user interface that is relevant to the experiment, automates setting up experimental procedures, and the storage of data.

Consequently, running an experiment with LabBench consists of the following steps:

1. Defining a protocol and experiment, by planning all intended experimental procedures and documenting them in a protocol.
2. Using LabBench to execute this protocol in a series of sessions in the experiment.
3. Exporting, analysing and publishing the data obtained in the experiment.

This overview is intended to introduce you to the philosophy of how LabBench works and its central concepts. The following sections will introduce you to these central concepts, but will not explain how they are implemented in LabBench. For a detailed explanation of how to use these concepts, please refer to later sections in this manual.

## Protocols

To run an experiment with LabBench you will need to write a protocol in the form of a text file termed a protocol definition file (*.prtx). This file contains a list of all the experimental procedures in the experiment, which in LabBench is referred to as tests.

When executed in an experiment each test will produce a result that is automatically saved by LabBench when the test has been completed and accepted by the experimentor. A test can also use one or more results from previously executed tests in order to automatically setup the parameters from the test. For example, in an experiment where evoked EEG potentials are recorded you may wish to set the intensity of the stimuli that evokes the EEG potentials to a percentage of the pain thresholds. In LabBench this may be accomplished with a protocol containing two tests:

1. A [Multiple perception thresholds](method_of_limits.html) test that estimates the pain threshold.
2. A [Evoked responses](evoked_responses.html) test that uses the threshold determined by the first test to set the intensity of the stimuli used to evoke a response to a predefined percentage of the pain threshold.

However, this dependency is not hardcoded in the Evoked responses test. The intensity could come from any test from which an intensity can be calculated. The intensity may also be set from a [Stimulus-response](stimulus_response.html) test as the intensity that evokes a predefined psychophysical response on a visual analog scale (VAS). In the above example this VAS scale may for example be defined with the anchor points of 0cm) no sensation, 4cm) pain threshold, 10cm) pain tolerance threshold.

## Devices and instruments

To actually run a neuroscience/psychophysical experiment you will need instruments to stimulate the subjects and to record their responses. In the example above, three instruments are required for the [Multiple perception thresholds](method_of_limits.html) test; a button used by the subject to indicate whether the stimuli are painful or not, and 2) an electrical stimulator to create the stimuli.

To provide access to these instruments, LabBench can communicate with and control Devices. A device is equipment that can implement a number of instrument interfaces. For the example, we will use the LabBenchIO device, which provides the following instrument interface:

* **IButton**: Makes it possible for a subject to indicate a threshold by pressing the button. When the subject presses the button the reaction time to the last applied stimulus is also recorded. In the example this interface is used to indicate whether the stimuli are painfull or not.
* **IElectricalStimulator**: Makes it possible to apply electrical stimuli to a subject.
* **IScale**: Makes it possible for a subject to rate his or her sensation on a psychophysical scale, such as a visual analog scale, numerical rating scale, or Wong-Baker faces scale. This instrument is not used in the example, but it would have been used instead of the **IButton** interface if a [Stimulus-response](stimulus_response.html) test had been used to establish the stimulus intensity in the [Evoked responses](evoked_responses.html) test.

Consequently, **Devices** are actual physical devices that you have in your experimental setup, whereas **Instruments** are the logical grouping of these devices that enables you to for example collect a response or to apply a stimulus to your subjects. In the example two Devices are used for the **IElectricalStimulator** interface; the LabBenchIO device and a Digitimer DS5 stimulator. The LabBenchIO is the one implementing the **IElectricalStimulator** interface, where it generates an analog signal to the DS5 Stimulator. To actually generate correct electrical stimulator it needs to know about the DS5 stimulator and its transconductance, which is why the DS5 stimulator in the LabBench setup is attached to the LabBenchIO device.

## Experiments

The protocols provices a specification of what is done in an experiment, but in a general way that makes it possible to reuse it in multiple experiments and to share it with the scientific community. Consequently, the protocol can specify which instruments it needs in order to be executed, but it does not specify the experimental setup that provides these instruments. That is instead the purpose of the experiment definition file (*.expx), which defines a single specific experiment that uses this protocol.

The experiment definition file provide to specifications; 1) a specification of the experimental setup, meaning which devices are used and how are they connected to each other, and 2) a device mapping that maps each of these devices to the instruments that are required by the protocol.

## Logging

Central to the execution of an experiment are good logging, not only good practices with regard to how the data is saved, but also that notes are taken throughout the experiment on all events that may influence the validity of the data and how it should be interpreted in the later data analysis and publication of the results.

LabBench provides a logging system with three levels; system, experiment, and session. LabBench will record in these logs all it can automatically, such as the execution of tests, change of device settings, etc. It also allow the experimenter to record extra information to the logs in the form of free text notes, which can be used for all the things that LabBench cannot automatically log.

## Data collection

# Installing and updating

# Setting up devices

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
