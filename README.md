The program outlined below was developed with the following objectives and content to rigorously assess the statistical similarity between real longitudinal data and synthetic longitudinal data.

The core elements and goals of this program are as follows:

To establish a technique for evaluating the statistical similarity between real longitudinal data and synthetic longitudinal data, utilizing a Linear Mixed-Effects Model (LMEM) and Cohen's d as the key metrics.Estimation of Longitudinal Trajectories 
To consistently estimate the changes over time (longitudinal trajectories) within both the real and synthetic longitudinal datasets using the LMEM framework.
The LMEM allows for the simultaneous modeling of population-level trends (fixed effects) and subject-specific variations (random effects).
Validation of Model Parameters via Effect Size: To evaluate the difference between the fixed effects and random effects (specifically for the slope and intercept parameters) of the estimated LMEMs. 
This comparison is quantified using Cohen's d, a widely accepted measure of effect size.
The calculated Cohen's d values serve as the basis for rigorously assessing the statistical congruence between the real data and the synthetic data, thereby validating the synthetic data generation process.

The implementation procedure for the aforementioned program is described below.

Data Preparation and Formatting:
The real and synthetic longitudinal datasets must be compiled into a single data file, typically formatted as an Excel spreadsheet (e.g., .xlsx).
This input file must contain, at minimum, three distinct and properly labeled variables: Data ID (a subject or participant identifier), Time Point (the measurement occasion or time variable), and Measurement Values (the dependent variable being analyzed).

Acknowledgement:
This work was supported by Institute for Information & communications Technology Promotion(IITP) grant funded by the Korea government(MSIT) (No.00223446, Development of object-oriented synthetic data generation and evaluation methods) and the Technology Innovation Program (20011875, Development of AI-Based Diagnostic Technology for Medical Imaging Devices) funded by the Ministry of Trade, Industry & Energy (MOTIE, Korea).

Execution in MATLAB Environment:
The filename corresponding to the prepared data file must be precisely entered into the designated user-defined variable (e.g., a file path string or variable assignment) within the provided MATLAB script (the executable program file).
The filename corresponding to the prepared data file must be precisely entered into the designated user-defined variable (e.g., a file path string or variable assignment) within the provided MATLAB script (the executable program file).Subsequent to updating the file path variable, the MATLAB script is executed to initiate the LMEM analysis and the subsequent calculation of Cohen's d metrics.
