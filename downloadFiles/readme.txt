SGPLVM software
Version 0.1		Friday 11 Jun 2010 at 11:34

This software implements the shared GP-LVM model.

Version 0.1
-----------

Updated relese with FOLS model from AISTATS 2010 added.


Version 0.05
------------

First public version of the shared GP-LVM toolbox with limited documentation.


MATLAB Files
------------

Matlab files associated with the toolbox are:

sgplvmAddBackMapping.m:
sgplvmExpandParam.m: Expand a parameter vector into a sGP-LVM model.
sgplvmDynamicIndicesOptions.m: 
sgplvmSetLatentDimension.m: Specify latent dimension type
sgplvmOptimiseDimVar.m: Optimise subspace of latent location
sgplvmVisualise.m: Display sgplvm model
ncca2sgplvm.m: Convert a NCCA model into a SGPLVM model
sgplvmOptimisePoint.m: Optimise the latent location.
sgplvmFOLSOptions.m: Returns options struct for fols model
sgplvmExtractParam.m: Extract a parameter vector from a GP-LVM model.
sgplvmObjective.m: Wrapper function for GP-LVM objective.
sgplvmLogLikeGradients.m: Compute the gradients for the SGPLVM.
sgplvmPointObjective.m: Gradient of latent location given observed points
computeSigmoidWeight.m: Compute weight decay function for fols model
sgplvmConstraintsGradient.m: SGPLVM constraints and gradient function for fmincon usage.
sgplvmPlotDecayFunction.m: Plot fols decay functions
sgplvmInitialiseLatentPoint.m: Initialise latent location given observation(s)
sgplvmPointGradient.m: Gradient of latent location given observed points
sgplvmLogLikelihood.m: Log-likelihood for a SGP-LVM.
sgplvmCroppDimensionDynamicsGetValidDimension.m: Returns valid
sgplvmObjectiveGradient.m: Wrapper function for SGPLVM objective and gradient.
sgplvmCroppDimension.m: Removes latent dimensions representing
sgplvmModelOptions.m: Return default options for SGPLVM model.
orthoLogLikeGradients.m: Compute the FOLS orthogonality constraint gradients for the SGPLVM.
sgplvmSequenceOut.m: Output latent location for observation
sgplvmToolboxes.m: Load in the relevant toolboxes for sgplvm.
sgplvmOptimiseDimVarSequence.m: Optimise subspace of latent sequence
varDimSequenceGradient.m: Output variance gradient for latent sequence
sgplvmInitialiseLatentPointFromShared.m: Initialise latent location given observation(s)
sgplvmAddConstraint.m: Add latent constraints to SGPLVM model
sgplvmInitialiseLatentSequence.m: Initialise latent location given observation(s)
sgplvmCroppDimensionConstraintsGetValidDimension.m: Returns valid
sgplvmAddLatentMapping.m:
sgplvmDisplayPrivate.m: Display orthogonal subspace of sgplvm model
varDimGradient.m: Output variance gradient
demSgplvm.m: Demonstrate the SGPLVM.
sgplvmOptimise.m: Optimise the SGPLVM.
sgplvmOptions.m: Return default options for FGPLVM model.
imagegreyVisualise.m: Callback function to visualise 2D image
sgplvmOut.m: 
sgplvmCreate.m: Creates a shared FGPLVM model from a set of FGPLVM models
nn_class.m:
varDimSequenceObjective.m: Objective of output variance over
imagegreyModify.m: Callback function to visualise 2D image
sgplvmAddDynamics.m: Add dynamic model over latent space
sgplvmAddInverseMapping.m:
sgplvmUpdateX.m: Optimise the SGPLVM.
sgplvmPointOut.m: Output latent location for observation
sgplvmWeightUpdate.m: Update iteration dependent objective weights
sgplvmDisplayLatent.m:
sgplvmCroppDimensionBackValidDimension.m: Returns valid
varDimObjective.m: Objective of output variance over subspace
sgplvmGradient.m: sGP-LVM gradient wrapper.
dem_sgplvm_fols.m: Runs Demo of FOLS SGPLVM model
sgplvmGetDimension.m: Returns dimensions by type from SGPLVM model
rankLogLikeGradients.m: Compute the FOLS rank constraint gradients for the SGPLVM.
