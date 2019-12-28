# Multiple Perception Thresholds

## Description

The multiple perception thresholds test is intended to find thresholds for multiple stimuli simultaneously, where the shape one or more of the stimuli may depend on thresholds for other stimuli being estimated by the test or on the results of previously executed tests. Depending on the instructions given to the subjects, the test may be used to estimate any threshold that can be adequately described to a subject. Examples of thresholds can be perception thresholds , pain thresholds, or pain tolerance thresholds.

Each threshold is estimated with the method of limits, where the intensity of stimulus is increased until the subject can feel the stimulus, and then decreased until the subject can no longer feel the stimulus (this sequence
of increasing until felt and then decreasing until no longer felt is in the following referred to as an Up/Down Estimate of the threshold). Each Up/Down estimates for each stimulus is performed in a round-robin fassion between each stimulus that are ready to be tested. Whether a stimulus is ready to be tested depends on whether it depends on stimuli for which a threshold estimate is not yet available.

The process of estimating the threshold is illustrated in Figure 1 (the  figure is annotated with descriptive elements in blue that is not shown when running the test in LabBench Runner):

![Method of Limits][mol]
*Figure 1: Illustration of the multiple perception test with two stimulus channels. Up/Down estimates are delineated by dashed blue lines, and their corresponding channel is written in blue above the estimate.*

Each estimation of the threshold for a stimulus is denoted as a stimulus channel, which has a seperate set of configuration parameters. In the illustration above two stimulus channels are defined; the first stimulus channel (C01) estimates the threshold to a retangular stimulus, and the second stimulus channel (C02) estimates the threshold to a rectangular stimulus that is conditioned by a long sub-threshold rectangular stimulus set to 10% of the threshold of the first stimulus channel (C01). As stimulus channel (C02) depends on stimulus channel (C01) it cannot run before there is a valid estimate for the threshold for
the stimulus in stimulus channel (C01). In Figure 1, this is the reason that stimulus channel (C01) is run for four times before the test starts to alternate between stimulus channels (C01) and (C02), as the test in Figure 1 is configured to discard the first up/down estimate and to first provide a valid estimate when there are three up/down estimates available.

Each Up/Down estimate for the stimulus channels in Figure 1 consists of increasing the intensity with a step size proportional to the current intensity until the subject has been able to feel the stimulation for three consequtive stimuli. When the subject has been able to feel the stimuli for three consequetive stimuli then the intensity is decreased with a step size proportional to the current intensity until the subject can no longer feel the stimuli for three consequtive stimuli.

After each Up/Down estimate the intensity step size is decreased with a percentage until a minimum step size is reached. When the threshold is estimated it is determined as a weighted average of the Up/Down estimates, where the wieght is inverse proportional to the step size used in the Up/Down estimates.

Please note that all the values given in the example description above are not fixed but is defined in the test configuration for the multiple perception test in the protocol definition file (*.prtx). The parameters and their valid values are described in section [Test definition](#Test-definition)

[Back to index](index.html)

## Required instruments

The Multiple Perception test needs the following instruments to be defined in the expriment definition file (*.expx) for the experiment:

| Name |  Interface | Usage |
|----|------------|-------|
|Button|IButton|Is used for the subject to indicate whether he or she can feel the stimulation|
|Stimulator|IAnalogStimulator|Is used for delivering the stimuli to subject|

In the xml snippet below it is illustrated how these instruments can be defined in experiment definition file (*.expx) for all Multiple Perception Thresholds tests in a protocol:

```xml
<experimental-setup>
    <description>
    The multiple perception test requires a device that implements the IAnalogStimulator and IButton interfaces.
    </description>
    <devices>
        <device id="dev" type="labench-io" serial-number="2">
            <attached-equipment>
                <ds5 name="Stimulator" transconductance="1mA_1V" />
            </attached-equipment>
        </device>
    </devices>
    <device-mapping>
      <device-assignment test-type="psychophysics-multiple-perception-thresholds"
                         instrument-name="Button"
                         device-id="dev" />
      <device-assignment test-type="psychophysics-multiple-perception-thresholds"
                         instrument-name="Stimulator"
                         device-id="dev" />
    </device-mapping>
</experimental-setup>
```

The example above uses a LabBenchIO device to provide the two instruments Button (interface: IButton) and Stimulator (interface: IAnalogStimulator) for all the multiple perception thresholds tests in the protocol used by the experiment. In this example it can be seen from the devices element that the actual stimulator used in the experiment is a Digitimer DS5 that is set up to a default transconductance of 1mA/1V (i.e. 10mA maximal stimulation intensity).

[Back to index](index.html)

## Test definition

The test definition for the test used to illustrate the test method is provided in the xml code snippet below:

```xml
<multiple-perception-thresholds ID="T1" 
                                name="Multiple Perception Test"
                                response-algorithm="click-and-release">
    <update-rate-deterministic value="2000" />
    <dependencies />
    <channel ID="C01"
             channel-type="contineous"
             name="Rect"
             Istart="Istart"
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
             Istart="Istart"
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
```

This test definition uses defines, which is intended as a means for being able to set multiple parameters in a protocol to the same value. The test definition above uses the following defines:

```xml
<defines>
    <!-- Stimuli -->
    <define name="Ts" value="1"/>    
    <!-- Multiple Perception Test -->
    <define name="Istart" value="0.2"/>
    <define name="Naverage" value="3"/>
    <define name="Ndiscard" value="1"/>
    <define name="Ntest" value="2"/>
    <define name="Pdecrease" value="0.2"/>
    <define name="Pmin" value="0.05"/>
    <define name="Pstep" value="0.2"/>
</defines>
```

The test definition consists of the following elements:

* multiple-perception-thresholds: *The root element for the Multiple Perception Test
  * [Defining the update rate]: *Defines the update rate for the test, is either a ```<update-rate-random>``` or ```<update-rate-deterministic>``` element*
  * [Definition of dependencies]: *which other tests in the protocol that the test depends on*
  * channels: the stimulus channels that are defined for the test

In the following each element of the test definition will be explained together with their parameters.

### Element ```<multiple-perception-thresholds>```

The ```<multiple-perception-thresholds>``` element identifies and defines a Multiple Perception Thresholds test in a protocol definition file.

| Parameter        | Type     | Usage     |
|------------------|----------|-----------|
|response-algorithm|Enum      |Determines how the subject indicates that he or she can feel the stimulus. It can take to values "click-and-hold" or "click-and-release". If it is set to "click-and-release" the subject should press and then release the button each time a stimulus is felt. If it is set to "click-and-hold" the subject should press and hold the button as long as he or she can feel the stimuli.|

### Element: Defining the update rate

Definition of an update rate with either:

* ```<update-rate-random>``` or
* ```<update-rate-deterministic>```

element is common to all LabBench tests, and is always the first element in a test definition.

Please refer to [Tests](index.html#tests) for a description of how to define the update rate for a test.

### Element: Definition of dependencies

Definition of test dependencies with ```<dependency>``` is common to all LabBench tests, and is always the second element in a test definition.

Please refer to [Tests](index.html#tests) for a description of how to define test dependencies.

### Element: ```<channels>```

The third element of the test definition contains the stimulus channels that are defined for the test. This element has no parameters and contains a sequency of channel definitions.

Each channel is defined with a ```<channel>``` element.

### Element: ```<channel>```

Each channel is defined with a ```<channel>``` element, which contains the following sub-elements:

* ```<channel-dependencies>```: *which channels the channel depends on*
* [Stimulus definition]: *the stimulus for which to estimate the threshold*

The channel has the following parameters:

| Parameter        | Type     | Usage     |
|------------------|----------|-----------|
|ID                |Text      |The ID of the channel that are used to identify it from other channels, either as a dependency or to extract its threshold for a calculated parameter in another channel's Stimulus definition.|
|channel-type      |Enum      |The type of channel which can be either "contineous" or "single-sample". If it is a "single-sample" channel then it will stop being run when there is a valid estimate for its stimulus. If the channel is "contineous" the channel will contienue to be run until all "single-sample" channels has completed. Please note that if all channels are "contineous" then this will be an error as the test will never be completed. |
|name              |Text      |A human readable name for the stimulus channel|
|Istart            |Calculated|The initial intensity for the stimulus in the first Up/Down estimate.|
|Naverage          |Calculated|How many Up/Down estimates to be available before there is valid estimate for the threshold.|
|Ndiscard          |Calculated|How many Up/Down estimates to initially discard.|
|Ntest             |Calculated|How many responses to test before the subject is considered to be able either feel or not feel the stimuli in the Up/Down estimation|
|Pdecrease         |Calculated|The decrease in step size for each Up/Down estimate. Consequently, the next step size Pstep,n+1 is calculated as Pstep,n+1 = (1-Pdecreae)*Pstep,n. |
|Pmin              |Calculated|The minimum step size. If the Pdecrease results in a step size below Pmin then Pmin will be used instead.|
|Pstep             |Calculated|The intial percentwise step size for the intensity.  |

### Element: ```<channel-dependencies>```

Dependencies to other stimulus channels are defined with ```<depency>``` elements with in the ```<channel-dependencies>``` element. Each ```<dpency>``` element has the following paraneters:

| Parameter        | Type     | Usage     |
|------------------|----------|-----------|
|ID                |Text      |The ID of the channel that the current channel depends on. Consequently, the current channel cannot run before there is a valid threshold estimate the channel identified by this ID parameter. |

### Element: Stimulus definition

Definition of stimuli is common for all tests that use the IAnalogStimulator interface.

Please refer to [Stimuli](index.html#stimuli) for a description of how to define stimuli.

## Test result

The threshold estimates from a Multiple Perception Thresholds test can be used in the stimuli in the stimulus channels of the test, or in calculated parameters and stimuli of other tests.

When used in its own stimuli for its stimulus channels, a threshold estimate is obtained with the following syntax:

```python
C['ID of Stimulus Channel']
```

When used in calculated parameters of other tests or their stimuli, a threshold estimate is obtained with the following syntax:

```python
TEST_ID['ID of Stimulus Channel']
```

where TEST_ID is substituted with the actual test id for tests, which in the example above would be T1.

## Data export

### Matlab

TODO: *To Be Written*

[mol]: img/MethodOfLimits.png "Method Of Limits"
