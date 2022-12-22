## Altitude control of a drone
This repository's goal is to control the altitude of a quadrotor using different controllers. 

The model for altitude used considers that the trust of the actuator is applied only in the vertical, the drone only moves in the vertical, and force drag will be neglected. The thrust force is given by ft(t) = Ktω2(t) and the actuator dynamic by dω(t)/dt = −300ω(t) + 300u(t).

 To achieve the goal of controlling the altitude different topics will be addressed such as: 
-Linearization
-Stability
-Poles of a transfer function
-Zeros of a transfer function
-Proportional controller
-Derivative controller
-Integral controller
-Tracking Error 
-Disturbance Rejection
-This task is divided into phases and each phase corresponds to a file

# Phase 1 - Linearization
	Model the system and compare the linearized with the non-linear to check the viability of the approximation. 

# Phase 2 - Root-locus and PD controller
 	Use of the root-locus to study the stability of the system and the implications of the zeros and the feedback gain in the system.

All the Phases have a published script with some analysis of the results.

	
