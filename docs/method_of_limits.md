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

Each Up/Down estimate for a stimulus channel consists of increasing the 

[Back to index](index.html)

## Required instruments

## Test definition

```xml
<multiple-perception-thresholds ID="T1" 
                                name="Multiple Perception Test"    response-algorithm="click-and-release">
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

## Test result

## Data export

### Matlab

[mol]: img/MethodOfLimits.png "Method Of Limits"
