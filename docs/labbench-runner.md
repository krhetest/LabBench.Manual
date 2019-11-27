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
