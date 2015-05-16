SGPLVM software
Version 0.05		Monday 13 Oct 2008 at 13:29

Version 0.05
------------

First public version of the shared GP-LVM toolbox with limited documentation.


MATLAB Files
------------

Matlab files associated with the toolbox are:

sgplvmOptions.m: Return default options for FGPLVM model.
sgplvmInitialiseLatentSequence.m: Initialise latent location given observation(s)
sgplvmOptimiseDimVar.m: Optimise subspace of latent location
sgplvmDynamicIndicesOptions.m: 
sgplvmAddInverseMapping.m:
sgplvmDisplayPrivate.m: Display orthogonal subspace of sgplvm model
sgplvmVisualise.m: Display sgplvm model
sgplvmOut.m: 
sgplvmAddLatentMapping.m:
varDimSequenceObjective.m: Objective of output variance over
sgplvmPointOut.m: Output latent location for observation
sgplvmAddBackMapping.m:
sgplvmLogLikeGradients.m: Compute the gradients for the SGPLVM.
sgplvmExtractParam.m: Extract a parameter vector from a GP-LVM model.
sgplvmGradient.m: sGP-LVM gradient wrapper.
varDimSequenceGradient.m: Output variance gradient for latent sequence
sgplvmSequenceOut.m: Output latent location for observation
sgplvmExpandParam.m: Expand a parameter vector into a sGP-LVM model.
sgplvmCreate.m: Creates a shared FGPLVM model from a set of FGPLVM models
varDimGradient.m: Output variance gradient
sgplvmSetLatentDimension.m: Specify latent dimension type
sgplvmObjective.m: Wrapper function for GP-LVM objective.
sgplvmInitialiseLatentPoint.m: Initialise latent location given observation(s)
sgplvmModelOptions.m: Return default options for SGPLVM model.
sgplvmDisplayLatent.m:
sgplvmAddDynamics.m: Add dynamic model over latent space
varDimObjective.m: Objective of output variance over subspace
sgplvmOptimiseDimVarSequence.m: Optimise subspace of latent sequence
sgplvmLogLikelihood.m: Log-likelihood for a sGP-LVM.
sgplvmObjectiveGradient.m: Wrapper function for SGPLVM objective and gradient.
sgplvmOptimise.m: Optimise the SGPLVM.
sgplvmToolboxes.m: Load in the relevant toolboxes for sgplvm.
ncca2sgplvm.m: Convert a NCCA model into a SGPLVM model
demSgplvm.m: Demonstrate teh SGPLVM.
