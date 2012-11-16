FibreOptics
===========

Industrial Monitoring System
----------------------------

This project provides students with experience working with fibre optic techniques, components and systems. It builds further on the students’ knowledge of digital data transmission, and introduces them to some advanced digital design techniques.

Through a series of project-related learning activities, each student will be able to:
- Design, configure, implement and optimize a fibre optic communication system
- Implement Manchester encoding and decoding circuits
- Implement a hardware time-division multiplexing scheme to transmit and receive digital data from multiple sources, over optical fibre.
- Investigate a wavelength-division multiplexing scheme to communicate two separate data streams over one optical fibre.
- Design and implement low frequency signal conditioning circuitry for interfacing sensors with a microcontroller.
- Design and implement a data framing protocol.

Project Description
-------------------

Application of the above mentioned concepts and skills is demonstrated through the specification, design, implementation and testing of a fibre optic system which carries live digital sensor data.

The system functions include:
- Two sensors, with A-to-D hardware to read the sensors and output their digital values (eventually) to the fibre interface hardware. For design purposes, the sensors are intended to represent the temperatures of some critical device.
- Time division multiplexing (TDM) of the sensor data with framing information onto a single optical fibre, using a VHDL embedded system development kit
- Framing of data, using basic methods suitable for simple data communication protocols
- Synchronous data communication of frames over plastic fibre optic cable
- Manchester encoding and decoding of frames, and transmission and recovery of an embedded clock signal
- Recovery of the sensor data from the frames, and display of the sensor values on an appropriate hardware device
- Characterization of a wave division multiplexing (WDM) system using a single optical fibre (as a lab)

This project requires development of several sub-systems. The first is the physical layer of the fibre communication, including TDM and clock. The second is the sensor conversion hardware. A third is the receiving station’s interface to the fibre network, recovery of the data, and the application display hardware.