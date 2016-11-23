# NeTV2 FPGA Register Expander

Expands the AXI GPIO block to have a small bank of registers for storing
key values used to initialize the HDCP engine. It's too "expensive"
to use multiple AXI GPIO blocks for this, the register expander is a bit
ugly from the programming model, but saves on a ton FPGA resources.

It's tested to work with Vivado 2016.1.
