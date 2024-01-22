# Turning Angle Between Locations

MoveApps

Github repository: https://github.com/movestore/TurningAngles_BetweenLocations

## Description
Calculation of the turning angle between consecutive locations.

## Documentation
This App calculates the turning angle between consecutive locations. Three locations are necessary for the calculation of each turning angle. Therefore the turning angle of the first and the last location of the track will be set to NA. 

The turning angles are calculated as angles in radians (-pi to pi) or degrees (-180 to 180). Where negative values are left turns and positive right turns.

A column named _**turnAngle**_ will be appended to the dataset that is returned for further use in next Apps.

A histogram of the turning angle distribution of all individuals and per individual is automatically created and can be downloaded in the output as a pdf.

### Input data
move2_locs

### Output data
move2_locs

### Artefacts
`turnAngle_histogram.pdf`: PDF with histograms of the turning angles per individual

### Settings
**Units:** the units of the resulting values can be selected. Available are: `radians` (-pi to pi), `degrees` (-180 to 180). Default is `radians`

### Null or error handling
**Data**: The full input dataset with the addition of the column _**turnAngle**_ is returned for further use in a next App and cannot be empty.
