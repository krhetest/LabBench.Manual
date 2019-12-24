# Multiple Perception Thresholds

## Description

The multiple perception thresholds test is intended to find thresholds for multiple stimuli simultaneously, where the
shape one or more of the stimuli may depend on thresholds
for other stimuli being estimated by the test or on the
results of previously executed tests. Depending on the
instructions given to the subjects, the test may be used to
estimate any threshold that can be adequately described to a
subject. Examples of thresholds can be perception thresholds
, pain thresholds, or pain tolerance thresholds.

Each threshold is estimated with the method of limits,
where the intensity of stimulus is increased until the
subject can feel the stimulus, and then decreased until
the subject can no longer feel the stimulus. Each of these
sequences of first increasing the intensity and then decreasing
the intensity is performed for each stimulus in a round-robin
fassion, between each stimulus that are ready to be tested.
Whether a stimulus is ready to be tested depends on whether it
depends on stimuli for which a threshold estimate is not yet
available.

The process of estimating the threshold is illustrated in the figure below (the figure is annotated with descriptive elements
in blue that is not shown when running the test in LabBench Runner):

![Method of Limits][mol]

Each stimulus is denoted as a stimulus channel, which has a
seperate set of parameters. In the illustration above two stimulus
channels are defined; the first stimulus channel (C01) estimates
the threshold to a retangular stimulus, and the second stimulus
channel (C02) estimates the threshold to a rectangular stimulus that is conditioned by a long sub-threshold rectangular stimulus
set to 10% of the threshold of the first stimulus channel (C01).
As stimulus channel (C02) depends on stimulus channel (C01) it
cannot run before there is a valid estimate for the threshold for
the stimulus in stimulus channel (C01).

[Back to index](index.html)

## Required instruments

## Test definition

## Test result

## Data export

### Matlab

[mol]: img/MethodOfLimits.png "Method Of Limits"
