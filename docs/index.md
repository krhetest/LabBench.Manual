
# Table of contents

1. [Overview](#overview)
   1. [Protocols](#protocols)
   2. [Experiments](#experiments)
   3. [Devices and instruments](#devices-and-instruments)
   4. [Logging](#logging)
   5. [Data collection](#data-collection)
2. [Installing and updating](#installing-and-updating)
   1. [Installing LabBench](#installing-labbench)
   2. [Tools for writing Protocols and Experiments](#tools-for-writing-protocols-and-experiments)
   3. [Updating LabBench](#updating-labbench)
3. [Setting up LabBench](#setting-up-labBench)
   1. [Setting the log level](#setting-the-log-level)
   2. [Backing up the system](#backing-up-the-system)
   3. [Restoring the system](#restoring-the-system)
   4. [Resetting the system](#resetting-the-system)
4. [Setting up devices](#setting-up-devices)
5. [Setting up an experiment](#setting-up-an-experiment)
6. [Running experiments](#running-experiments)
   1. [Starting an experimental session](#starting-an-experimental-session)
7. [Exporting data](#exporting-data)
8. [Data analysis](#data-analysis)
   1. [Matlab](#matlab)
   2. [Excel](#excel)
9. [Writing protocols](#writing-protocols)
   1. [Code completion and error checking](#code-completion-and-error-checking)
   2. [Name and version](#name-and-version)
   3. [Values](#values)
   4. [Defines](#defines)
   5. [Stimuli](#stimuli)
   6. [Tests](#tests)
   7. [Test documentation](#test-documentation)
10. [Writing experiments](#writing-experiments)
11. [Terms and abbreviations](#terms-and-abbreviations)
12. [A short primer on xml files](#a-short-primer-on-xml-files)

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

[Go to table of contents](#table-of-contents)

## Protocols

To run an experiment with LabBench you will need to write a protocol in the form of a text file termed a protocol definition file (*.prtx). This file contains a list of all the experimental procedures in the experiment, which in LabBench is referred to as tests.

When executed in an experiment each test will produce a result that is automatically saved by LabBench when the test has been completed and accepted by the experimentor. A test can also use one or more results from previously executed tests in order to automatically setup the parameters from the test. For example, in an experiment where evoked EEG potentials are recorded you may wish to set the intensity of the stimuli that evokes the EEG potentials to a percentage of the pain thresholds. In LabBench this may be accomplished with a protocol containing two tests:

1. A [Multiple perception thresholds](method_of_limits.html) test that estimates the pain threshold.
2. A [Evoked responses](evoked_responses.html) test that uses the threshold determined by the first test to set the intensity of the stimuli used to evoke a response to a predefined percentage of the pain threshold.

However, this dependency is not hardcoded in the Evoked responses test. The intensity could come from any test from which an intensity can be calculated. The intensity may also be set from a [Stimulus-response](stimulus_response.html) test as the intensity that evokes a predefined psychophysical response on a visual analog scale (VAS). In the above example this VAS scale may for example be defined with the anchor points of 0cm) no sensation, 4cm) pain threshold, 10cm) pain tolerance threshold.

[Go to table of contents](#table-of-contents)

## Devices and instruments

To actually run a neuroscience/psychophysical experiment you will need instruments to stimulate the subjects and to record their responses. In the example above, three instruments are required for the [Multiple perception thresholds](method_of_limits.html) test; a button used by the subject to indicate whether the stimuli are painful or not, and 2) an electrical stimulator to create the stimuli.

To provide access to these instruments, LabBench can communicate with and control Devices. A device is equipment that can implement a number of instrument interfaces. For the example, we will use the LabBenchIO device, which provides the following instrument interface:

* **IButton**: Makes it possible for a subject to indicate a threshold by pressing the button. When the subject presses the button the reaction time to the last applied stimulus is also recorded. In the example this interface is used to indicate whether the stimuli are painfull or not.
* **IElectricalStimulator**: Makes it possible to apply electrical stimuli to a subject.
* **IScale**: Makes it possible for a subject to rate his or her sensation on a psychophysical scale, such as a visual analog scale, numerical rating scale, or Wong-Baker faces scale. This instrument is not used in the example, but it would have been used instead of the **IButton** interface if a [Stimulus-response](stimulus_response.html) test had been used to establish the stimulus intensity in the [Evoked responses](evoked_responses.html) test.

Consequently, **Devices** are actual physical devices that you have in your experimental setup, whereas **Instruments** are the logical grouping of these devices that enables you to for example collect a response or to apply a stimulus to your subjects. In the example two Devices are used for the **IElectricalStimulator** interface; the LabBenchIO device and a Digitimer DS5 stimulator. The LabBenchIO is the one implementing the **IElectricalStimulator** interface, where it generates an analog signal to the DS5 Stimulator. To actually generate correct electrical stimuli it needs to know about the DS5 stimulator and its transconductance, which is why the DS5 stimulator in the LabBench setup is attached to the LabBenchIO device.

[Go to table of contents](#table-of-contents)

## Experiments

The protocols provices a specification of what is done in an experiment, but in a general way that makes it possible to reuse it in multiple experiments and to share it with the scientific community. Consequently, the protocol can specify which instruments it needs in order to be executed, but it does not specify the experimental setup that provides these instruments. That is instead the purpose of the experiment definition file (*.expx), which defines a single specific experiment that uses this protocol.

The experiment definition file provide to specifications; 1) a specification of the experimental setup, meaning which devices are used and how are they connected to each other, and 2) a device mapping that maps each of these devices to the instruments that are required by the protocol.

[Go to table of contents](#table-of-contents)

## Logging

Central to the execution of an experiment are well maintained loggs, not only with regard to how the data is saved, but also that notes are taken throughout the experiment on all events that may influence the validity of the data and how it should be interpreted in the later data analysis and publication of the results.

LabBench provides a logging system with three levels; system, experiment, and session. LabBench will record in these logs all it can automatically, such as the execution of tests, change of device settings, etc. It also allow the experimenter to record extra information to the logs in the form of free text notes, which can be used for all the things that LabBench cannot automatically log.

[Go to table of contents](#table-of-contents)

## Data collection

With LabBench there is no save button, instead all data is saved automatically to a database in a format that is structured from the protocol used in the experiment. When the experiment is completed all the data can be exported to a format that enables the scientist to analyse the data, such as Matlab or Excel.

[Go to table of contents](#table-of-contents)

# Installing and updating

## Installing LabBench

To install LabBench download the [installer](https://labbench.io) and run the installer. This will install LabBench on your computer. LabBench consists of a series of programs that combined makes it possible to setup and run experiments and to export the results from these experiments. These programs are:

1. **LabBench Runner**: A program that provides a graphical user interface for running experiments and their associated protocols.
2. **labconf**: A console program for configuring LabBench.
3. **labdev**: A console program for installing and managing the Devices that for experiments.
4. **labprot**: A console program for installing and managing protocols.
5. **labexp**: A console program for installing and managing protocols, as well as exporting data from an experiment.
6. **lablog**: A console program for exporting the logs from an experiment.

LabBench Runner is the only one of these programs that provides a graphical user interface, as it is used during an experimental session where the program needs to be inflexible and easy to use. The rests of the programs are console programs or as they are also sometimes referred to command line programs. This means they do not have a graphical user interface but instead they are run by opening a command prompt, typing their name (with parameters), and hitting enter.

If you come from a non-technical faculty this may be new to you, and you may never have used a command prompt before. While a complete tutorial is too extensive for this manual, there are many tutorials on the command line that can be found on the net. One example is [Introduction to the command-line interface](https://tutorial.djangogirls.org/en/intro_to_command_line/), which is relatively short but covers almost everything you will need in order to use LabBench. The only thing it does not cover is how to open a command line easily in a specific directory. You will need this when you have written experimental and protocol definition files and need to install them in LabBench, or when you need to export the results or logs from an experiment.

To open a command line console in a specific directory, open Windows Explorer and go to the directory, then type `cmd` in the directory path box (marked with a red box below) and hit enter. This will open a command line console in the directory that you have navigated to with Windows Explorer.

![Opening Command Line from Windows Explorer][wndexp]

[Go to table of contents](#table-of-contents)

## Tools for writing Protocols and Experiments

To setup experiments you will need to write experiment and protocol definition files, which are text files in a very specific format. LabBench is very strict with this format, any errors in one of these files will cause LabBench to reject the file and give an error.

While you can use any text editor to write these files, it will be easier to write these files if you use a text editor that understands the format of these files, so it can assist you in writing them and provide you with feedback immediately if you make an error.

One such editor is the [Atom editor](https://atom.io/ "A hackable text editor for the 21st Century"), which with the [Autocomplete XML Atom Package](https://atom.io/packages/autocomplete-xml "XML tag autocompletion for Atom text editor!") package can provide what is known as code completion for the experiment and protocol definition files.

To enable this, install the Atom editor by downloading the [installer](https://atom.io/download/windows_x64 "Direct download link for Windows") and running it. Once the Atom editor is installed, start the editor and go to File=>Settings. In the Settings panel goto Packages and search for the `autocomplete-xml` package and install it.

After this, when you open an experiment or protocol definition file that are based on the [template](https://github.com/Inventors-Way/LabBench.Manual/tree/master/templates "Templates for experiment and protocol definition files") with the Atom editor, you will get code completion and waving lines under errors in the files.

An alternative but far superior tool for editing these files would be to install [Visual Studio](https://visualstudio.microsoft.com/vs/ "Code faster. Work smarter. Create the future with the best-in-class IDE."), which is far more robust in its code completion and error detection than the Atom editor. It is however also rather large and is a download and install of several gigabytes. With visual studio you will get code completion and error detection out of the box.

[Go to table of contents](#table-of-contents)

## Updating LabBench

LabBench may be updated by downloading a new installer and installing the new version over the old version of LabBench. This will not touch the installed devices, experiments, or protocols or the data contained within LabBench. However, care must be taken before a new version of LabBench is installed, as the new LabBench may not be compatible with the old version. If it is incompatable it will not be able to read the data from the old version of LabBench, and when you list installed devices, experiments, and protocols it will appear that none are installed and LabBench will display a warning with incompatable data present.

In that case you can recover from the error in two ways:

1. Purge all the old data with with the `labconf reset` command. Warning this will delete everything in the system, only perform this action if you are abselutely sure that you have exported all data from LabBench and you have no need of the old LabBench setup anymore.
2. Manually uninstall LabBench, and install an old version of LabBench that is compatable with the data in system. After this you can use the old LabBench installation to export your data, before you reinstall the new version of LabBench, and purge the data with the `labconf reset` command.

From the LabBench version number you can determine whether a new LabBench version will be compatable with the version of LabBench you have currently installed. LabBench uses [semantic versioning](https://semver.org/ "Semantic Versioning 2.0.0") where a version number consists of three numbers seperated by digits: `MajorVersion.MinorVersion.PatchVersion` that has the following definition:

* `MajorVersion`: LabBench will be incompatable when the `MajorVersion` number differs between two versions of LabBench.
* `MinorVersion`: Functionality has been added to LabBench in a backward compatible manner. Data created by a version of LabBench with the same `MajorVersion` but a lower `MinorVersion` will be compatible. However, LabBench is not garanteed to be downgradable, and consequently, data created by a higher `MinorVersion` is not garanteed to be readable by a lower `MinorVersion`.
* `PatchVersion`: Signifies a backward compatible patch with bugfixes to existing functionality, however, no new functionality has been added to LabBench.

Consequently, when you install a new version of LabBench check if the `MajorVersion` of the currently installed and new version of LabBench are the same. If they are the same you can install the new version without problems. If they are not the same you will most likely need to wait until you have finished the experiments that are currently running using the computer, then export the data, install the new version of LabBench, and then perform a `labconf reset` on the system.

[Go to table of contents](#table-of-contents)

# Setting up LabBench

## Setting the log level

LabBench has three log levels:

1. DEBUG: Extremely detailed information that is mostly relevant to debug and develop the LabBench system. Setting the log level to DEBUG will cause the LabBench database to consume a significant space on the harddisk of the computer.
2. STATUS: Information that is required in order to analyse and interpret the data from an experimental session correctly.
3. ERROR: Errors that affect the validity of the results collected in an experimental session.

the log level can be controlled with the `labconf` command, with the following syntax:

```labbench
labconf log
```

will display the current log level for the system, whereas:

```labbench
labconf log [LOG LEVEL]
```

will set the lowest log level of the system, where [LOG LEVEL] is substituted with either DEBUG, STATUS, ERROR, or DISABLED. The log level of the system means that log messages with a lower level is not logged. If the log level is set to DISABLED all logging is disabled for the LabBench system.

While it is highly recommended to set the log level to STATUS, it is not recommended to set it to ERROR or DISABLED as this will cause the system to discard information that may be critical for the analysis of your experimental data.

[Go to table of contents](#table-of-contents)

## Backing up the system

LabBench can backup its internal database to a single external file, which can later be used to restore the system or to clone the setup and data of LabBench to a new computer.

A backup of LabBench is performed with the following command:

```labbench
labconf backup [NAME OF BACKUP FILE]
```

which will create a file with the name of [NAME OF BACKUP FILE] in the current directory. We highly recommend that you backup your LabBench installation frequently to safeguard you in the case that your computer malfunctions or is stolen.

[Go to table of contents](#table-of-contents)

## Restoring the system

LabBench can be restored from a previous backup, provided that this backup was created with the same version of LabBench.

Restoring LabBench can be done with the following command:

```labbench
labconf restore [NAME OF BACKUP FILE]
```

where [NAME OF BACKUP FILE] is the name of the backup file that has previously been created with the `labconf backup` command.

[Go to table of contents](#table-of-contents)

## Resetting the system

If you need to install a new major version of LabBench, or you want to reset the system to its initial state when LabBench is installed on a computer, then this can be performed with the following command:

```labbench
labconf reset -p "I AM VERY SURE I WANT TO DO THIS"
```

which will delete all devices, all experiments, all protocols, and all data from LabBench. The `-p` option is not required, if you do not specify this option on the command line the program will prompt you to type in the sentence `I AM VERY SURE I WANT TO DO THIS` before it will reset the system.

Please consider very carefully if you need to reset the system before executing this command, as this will irrevocally delete all data without any possibility to restore it. You might want to consider backing up LabBench with the `labconf backup` command before you perform a `labconf reset` of the system.

[Go to table of contents](#table-of-contents)

# Setting up devices

## Listing all installed devices

[Go to table of contents](#table-of-contents)

## Installing a device

[Go to table of contents](#table-of-contents)

## Removing a device

[Go to table of contents](#table-of-contents)

## Check installed devices

[Go to table of contents](#table-of-contents)

# Setting up an experiment

[Go to table of contents](#table-of-contents)

# Running experiments

Running experiments are performed with the LabBench Runner program according to predefined protocols and experimental setups, with a simple user interface that contains only the functionality and information that is required to run a specific protocol.

Running an experimental session with LabBench Runner consists of the following steps:

* Going through the start-up wizard dialog, where you will:
  * Select the experiment you want to perform
  * Check that all the required instuments are present and correctly configured.
  * Create a new subject, or choose an existing subject.
* When the start-up wizard has completed; LabBench Runner will start:
  * Executing each test in the protocol, where:
    * Starting the test.
    * Using the Test Area to execute and monitor the test
    * When the test completes, accept or reject the recorded data

The list above provides a high level overview of how experimental sessions are performed with the LabBench Runner program, the remaining of this guide will explain in detail how each of these steps are performed.

[Go to table of contents](#table-of-contents)

## Starting an experimental session

The startup wizard goes through the setup of an experimental session. The first choice is which experiment you wish to run, where it will present you the screen below for selecting an experiment that is currently installed in the LabBench system.

![Selecting an experiment][step01]

The next step is to check that all the instruments required by the experiment is connected to the computer and is working. This is done in the second step of the startup wizard, which is shown below:

![Checking the experimental setup][step02]

The third and final step of the start-up wizard is to either create a new subject or to select an allrady existing subject, which is done in the screen shown below:

![Creating or selecting an existing subject][step03]

A new subject is created by writing a previously unused subject ID in the Subject input box. To use a previously created subject, then select an subject from the list below the Subject input box.

If you enter an allready existing subject ID in the Subject input box, then this subject will be selected in the list of existing subjects and a new subject will not be created. Consequently, there can be one and only one subject with a given Subject ID in the system. 

The Subject input box has autocomplete, so an existing subject can be selected by starting to type his or hers subject ID and then selecting the subject from the ensuing list of matches.

[step01]: img/wizard-step01.png "Start-Up: Selecting an experiment"
[step02]: img/wizard-step02.png "Start-Up: Checking the experimental setup"
[step03]: img/wizard-step03.png "Start-Up: Selecting a subject"

[Go to table of contents](#table-of-contents)

# Exporting data

[Go to table of contents](#table-of-contents)

# Data analysis

## Matlab

[Go to table of contents](#table-of-contents)

## Excel

[Go to table of contents](#table-of-contents)

# Writing protocols

Writing a protocol consists of writing a protocol definition file (*.prtx) which is a text file in an e**x**tensible **m**arkup **l**anguage (xml) format. If you are unfamiliar with xml files, you are recommended to read the sectoin [A short primer on xml files](#a-short-primer-on-xml-files) before reading the rest of this section.

An example of a protocol definition file is given below:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<protocol xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://labbench.io protocol.xsd"
          name="MOL"
          version="1.0.0">
  <defines>
    <!-- Stimuli -->
    <define name="Ts" value="1"/>    
    <!-- Method of Limits -->
    <define name="Istart" value="0.2"/>
    <define name="Naverage" value="3"/>
    <define name="Ndiscard" value="1"/>
    <define name="Ntest" value="2"/>
    <define name="Pdecrease" value="0.2"/>
    <define name="Pmin" value="0.05"/>
    <define name="Pstep" value="0.2"/>
  </defines>
  <tests> 
    <multiple-perception-thresholds ID="T1" name="MPT" response-algorithm="click-and-release"> ... </multiple-perception-thresholds>
    <multiple-perception-thresholds ID="T2" name="Fast MPT" response-algorithm="click-and-release"> ... </multiple-perception-thresholds>
  </tests>
</protocol>
```

Please note that the full content of the `<multiple-perception-thresholds>` is not shown in the example. The following sections will go through each part of this protocol definition file to explain how to write them and how they are used to define an experimental protocol.

[Go to table of contents](#table-of-contents)

## Code completion and error checking

If the text editor supports it, it may provide code completion and error checking if the xml file/protocol definition file specifies what is a valid syntax for the file. This is what is specified with the `xsi:schemaLocation` and `xmlns:xsi`attribute on the `<protocol>` element:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<protocol xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://labbench.io protocol.xsd"
          name="MOL"
          version="1.0.0">
```

The `xsi:schemaLocation` specifies the location of the xml schema which contains the grammar for the protocol definition files. In this example it requires the xml schema to be names `protocol.xsd` and to be located in the same directory as the protocol definition file.

If you have installed the Atom editor with the `autocomplete-xml` pacakge or even better Visual Studio, you will then be able to benefit from code completion and error checking.

[Go to table of contents](#table-of-contents)

## Name and version

Each protocol has a name and a version, which is used to form the ID it will be identified with in LabBench and used to be referenced with from experiment definition files (see [Writing experiments](#writing-experiments)). The name and version of the protocol is specified with the `name` and `version` attributes on the `<protocol>` element:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<protocol xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://labbench.io protocol.xsd"
          name="MOL"
          version="1.0.0">
```

In LabBench, the ID of a protocol will be formed from its `name` and `version` as `name`-`version`. LabBench can have multiple versions of the same protocol installed, so experiments may use different versions of the same protocol.

[Go to table of contents](#table-of-contents)

## Values

For the protocol and its tests there are parameters that needs to be set in order to specify a protocol. Two parameters have allready been described; the `name` and `version` of the protocol. All parameters have a type which defines which values that are valid for the parameter and how it is determined. In the case of the `name` and `version` parameters they are both text parameters. LabBench has the following types of parameters:

| Type       |Description                                                              |
|:----------:|-------------------------------------------------------------------------|
| Text       |Can contain text                                                         |
| Number     |Any number, for some parameters it may be required to be an integer      |
| Enum       |A set of predefined values are allowed (e.g. color = {RED, GREEN, BLUE}) |
| Calculated |The value of the parameter is calculated from an arithmic expression     |

The Calculated type is what allow tests in LabBench to depend and be configured from the results of other tests, as depending on parameter the calculated parameter may have access to defines in the protocol, previous test results, and the current test result. For example a calculated parameter may be defined as:

```xml
Istart="0.9 * T1['C01']"
```

which will set the `Istart` parameter to 0.9 of the estimated threshold of the stimulus `C01` from the result of the test with `ID="T1"`. That the threshold for the `C01` was accessed with the `T1['C01']` notation was depending on the type of test result. Each type test result offers different results, and as a consequence different methods and notations for accessing their results. Please refer to  [Test documentation](#test-documentation "Documentation for each type of test available in LabBench") to discover the notations and methods for accessing the results of a test.

The result of the currently running test is accessed with `C`, for example in a threshold estimation with threshold electrotonus the electrical stimulus may be constructed as:

```xml
<combined>
  <pulse Is="0.1*C['C01']" Ts="20 + Ts" Tdelay="0"/>
  <pulse Is="Is" Ts="Ts" Tdelay="20"/>
</combined>
```

which will construct the stimuli as the summation of two rectangular stimuli:

1. The first stimulus is subthreshold and set to 0.1 of the threshold of the `C01` stimulus being estimated in the threshold estimation test, and
2. The second stimulus is the test stimulus for which the threshold intensity `Is` is being estimated.

The example above also uses defines, which are described in the next section [Defines](#defines "A mechanism for supplying the same value to multiple parameters") and a test dependent variable `Is` that is used to adjust the intensity of the stimulus so the test can adjust this variable and in this process estimate the threshold for the stimulus. Please refer to  [Test documentation](#test-documentation "Documentation for each type of test available in LabBench") to discover which test dependent variables that are available in each calculated parameter for a test.

Since `C` is used to access the result of the current test it is an error to use `C` as a test ID. It is also an error to use any defines or test dependent variables as a test ID. The easiest way to avoid these errors is to always use the notion `T[NUMBER]` where `[NUMBER]` is substituted with a consequetive number as test IDs (i.e. the first test in the protocol would have `ID="T01"`, second `ID="T02"`, etc.). This convention is garenteed to not conflict with a test dependent variable, and as a protocol writer you will need to ensure that you do not use a test ID as the name of a define.

[Go to table of contents](#table-of-contents)

## Defines

Tests are specified by setting up their parameters, where in many cases it is desirable to have a mechanism by which the same parameters in multiple tests can be set to the same value. One example is the stimulus duration (Ts) in the stimulus example in the [Values](#values "The type of parameters that LabBench support") section.

Defines are specified in `defines` element of the protocol definition file:

```xml
<defines>
  <!-- Stimuli -->
  <define name="Ts" value="1"/>
  <!-- Method of Limits -->
  <define name="Istart" value="0.2"/>
  <define name="Naverage" value="3"/>
  <define name="Ndiscard" value="1"/>
  <define name="Ntest" value="2"/>
  <define name="Pdecrease" value="0.2"/>
  <define name="Pmin" value="0.05"/>
  <define name="Pstep" value="0.2"/>
</defines>
```

Each define is a calculated parameter that can use previously specified defines in the list. In the rest of the procol when the `name` is used in a calculated parameter this name will be substituted with the value of the aritmic expression in the `value` attribute.

[Go to table of contents](#table-of-contents)

## Stimuli

Many tests in LabBench, involves evoking a response with stimuli. To facilitate this, LabBench provides a common way of specifying stimuli, where an example of such a stimuli is given below:

```xml
<combined>
  <pulse Is="0.1*C['C01']" Ts="20 + Ts" Tdelay="0"/>
  <pulse Is="Is" Ts="Ts" Tdelay="20"/>
</combined>
```

This was the stimulus that was used as an example in the [Values](#values "The type of parameters that LabBench support") section. This section will explain in more detail how stimuli can be constructed from the different stimulus elements that are provided by LabBench.

LabBench provides the following stimulus elements:

| Element  |Sub-elements  |Attributes      | Description                                            |
|:--------:|:------------:|:--------------:|:-------------------------------------------------------|
| [combined](#combined "A stimulus combined from other stimulus elements") | all elements | none | Is used to construct stimuli as a sum of other stimuli |
| [pulse](#pulse "A rectangular pulse") | none | Is, Ts, Tdelay | A rectangular stimulus |
| [ramp](#ramp "A linearly increasing stimulus") | none | Is, Ts, Tdelay | A linearly increasing stimulus |

Where a test requires a stimulus as a parameter, any of these elements can be used as the root element. Consequently, if a single rectangular pulse was required instead of the threshold electrotonus in the example above, this could be specified as:

```xml
<pulse Is="Is" Ts="Ts" Tdelay="0"/>
```

However, the following would achieve the same result, albeit in a more wastefull manner:

```xml
<combined>
  <pulse Is="Is" Ts="Ts" Tdelay="0"/>
</combined>
```

There is a set of stimulus parameters that always have the same meaning:

|Parameter|Type|Specification|
|---------|----|---------|
|Is       |calculated|The intensity of the stimulus|
|Ts       |calculated|The duration of the stimulus|
|Tdelay   |calculated|Delay from the onset of the stimulus with respect to time zero|

Stimulus elements may define additional parameters that are specific to them. Time in the stimulus specification is given in mileseconds (ms).

Please note, that even though LabBench will allow you to specify arbitrary complicated stimuli by using `<combined>` stimulus elements, each device will have limitations on how complex stimuli they can handle. Consequently, if this is exceeded the device used in a test may be incapable of executing a stimulus that has been specified in a protocol.

[Go to table of contents](#table-of-contents)

### Combined

The `<combined>` stimulus element is used to construct stimuli as the sum of other stimulus elements. The Combined stimulus element can be used within itself, and consequently, Combined stimulus elements can be nested arbitrarely deep. This is not recommended.

[Go to table of contents](#table-of-contents)

### Pulse

The `<pulse>` stimulus element is used to specify a retangular stimulus that has the intensity `Is` for `Ts` mileseconds.

[Go to table of contents](#table-of-contents)

### Ramp

The `<ramp>` stimulus element is used to specify a linearly increasing stimulus that increases from 0 to `Is`over `Ts` mileseconds.

[Go to table of contents](#table-of-contents)

## Tests

Tests are the cornerstone of LabBench and are the units from which protocols are constructed. Each test is defined by parameters that are common and which has to be specified for all tests regardless of their type, and parameters that are specific for each type of tests.

Tests are specified in the `<tests>` element of the protocol definition file, below there is an example of a `<tests>` element:

```xml
<tests>
  <multiple-perception-thresholds ID="T1" name="MPT" response-algorithm="click-and-release"> ... </multiple-perception-thresholds>
  <multiple-perception-thresholds ID="T2" 
                                  name="Fast Multiple Perception Test" 
                                  response-algorithm="click-and-release">
    <update-rate-deterministic value="2000" />
    <dependencies>
      <dependency ID="T01"/>
    </dependencies>
    <channel ID="C01"
             channel-type="contineous"
             name="Rect"
             Istart="0.9 * T1['C01']"
             Naverage="Naverage"
             Ndiscard="Ndiscard"
             Ntest="Ntest"
             Pdecrease="Pdecrease"
             Pmin="Pmin"
             Pstep="Pstep">
      <channel-dependencies />
      <pulse Is="Is" Ts="Ts" Tdelay="0"/>
    </channel>
    <channel ID="C02"
             channel-type="single-sample"
             name="TE"
             Istart="0.9 * T1['C01']"
             Naverage="Naverage"
             Ndiscard="Ndiscard"
             Ntest="Ntest"
             Pdecrease="Pdecrease"
             Pmin="Pmin"
             Pstep="Pstep">
      <channel-dependencies>
        <dependency ID="C01"/>
      </channel-dependencies>
      <combined>
        <pulse Is="0.1*C['C01']" Ts="20 + Ts" Tdelay="0"/>
        <pulse Is="Is" Ts="Ts" Tdelay="20"/>
      </combined>
    </channel>
  </multiple-perception-thresholds>  
</tests>
```

where the second test has been expanded to show its full content in the example above (please note that the content of the first test has been left out, indicated with `...` for brevity).

All tests has the following common parameters:

* `ID="[ID OF THE TEST]"`:
* `name="[Human readable name of the test]`:
* `<update-rate>`:
* `<dependencies>`:

In the example above, parameters such as the `response-algorithm` attribute and `<channel>` element are specific to the `<multiple-perception-thresholds>` test. An explation of their function is found in the documentation for the [Multiple perception thresholds](method_of_limits.html "A test that estimates multiple perception thresholds with method of limits") test.

[Go to table of contents](#table-of-contents)

### Test Identifier (`ID="T02"`)



[Go to table of contents](#table-of-contents)

### Test Name (`Name="Fast Multiple Perception Test"`)

[Go to table of contents](#table-of-contents)

### Update Rate (`<update-rate-deterministic>`)

[Go to table of contents](#table-of-contents)

### Dependencies (`<dependencies><dependency ID="T01" />`)

[Go to table of contents](#table-of-contents)

## Test documentation

* Metatests
  * [Subject information](subject_information.html)
* Psychophysics
  * [Multiple perception thresholds](method_of_limits.html "A test that estimates multiple perception thresholds with method of limits")
  * [Psi Threshold Estimation](psi_method.html )

[Go to table of contents](#table-of-contents)

# Writing experiments

[Go to table of contents](#table-of-contents)

# Terms and abbreviations

[Go to table of contents](#table-of-contents)

# A short primer on xml files

[Go to table of contents](#table-of-contents)

[wndexp]: img/WndExplorer.png "Opening Command Line from Windows Explorer"
