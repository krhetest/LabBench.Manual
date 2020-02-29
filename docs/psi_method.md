# Threshold Estimation

## Description
The threshold estimation tests makes it possible to estimate psychometric functions with adaptive methods. The purpose and motivation for adaptive methods is to increase the effectiveness by which pasychometric functions are estimated, so this process becomes faster and ultimately results in better estimates as the effort required by the subjects becomes less. They achieve that by attempting to maximize the information gained from each presentation of a stimulus to the subject.

[Back to index](index.html)

## Required instruments

The Thrshold Estimation test needs the following instruments to be defined in the expriment definition file (*.expx) for the experiment:

| Name      |  Interface        | Usage |
|-----------|-------------------|-------|
|Button     | IButton           |Is used for the subject to indicate whether he or she can feel the stimulation|
|Stimulator | IAnalogStimulator |Is used for delivering the stimuli to subject|

In the xml snippet below it is illustrated how these instruments can be defined in experiment definition file (*.expx) for all Threshold Estimation tests in a protocol:

[Back to index](index.html)

## Estimation Algorithms

### Up/Down Estimation Algortihm

```xml
<up-down-method down-rule="3"
                up-rule="3"
                max-intensity="1"
                min-intensity="0"
                skip-rule="0"
                start-intensity="0.0025"
                step-size-up="0.25"
                step-size-down="0.25"
                step-size-type="relative"
                terminate-on-limit-reached="true"
                max-step-size-reduction="0.1"
                step-size-reduction="0.5"
                stop-criterion="reversals"
                stop-rule="2">
    <quick alpha="0.5" beta="1" lambda="0.02" gamma="0.0" />
</up-down-method>
```

|Parameter|Type|Description|
|----------------|----|-----------|
| down-rule      | integer | How many stimulations that fallen below the threshold before the intensity will  increasing |
| up-rule        | integer | How many stimulations that has to be above the threshold before the intensity will be decreasing |
| max-intensity  | double   | Normalized maximal stimulation intensity |
| min-intensity  | double | Normalized minimal stimulation intensity |
| skip-rule      | integer | Number of initial reversals that are skipped and not included in the calculation of the threshold |
| start-intensity | double | Normalized starting intensity |
| step-size-up    | double | Initial upwards step size, without factoring in step size reduction |
| step-size-down  | double | Initial downwards step size, without factoring in step size reduction |
| step-size-type | Enum (absolute, relative) | If absolute the step-size-up/step-size-down is in amperes, otherwise it is relative to current stimulation intensity |
| terminate-on-limit-reached | true/false | Will the test terminate if the max-intensity is reached |
| max-step-size-reduction | double | maximal step size reduction, before the reduction in step size saturates and will not be come any smaller (i.e. if set to 0.2 the step size will maximally be reduced to 20% of its initial value) |
| stop-criterion | Enum (trials, reversals) | If set to trials the test will stop after a set number of stimulations, regardless of whether a threshold estimate has been achieved or not. If set to reversals it will terminate after a set number of reversals that the threshold has been reached and not reached. |
| stop-rule | integer | Number of stimulations (stop-criterion = trials) or reversals (stop-criterion = reversals) when the test will terminate |

[Back to index](index.html)

### Psi Estimation Algorithm

[Back to index](index.html)
