run:
	iverilog controller.v controller_tb.v -o controller.vvp
do: run
	vvp controller.vvp
all: do
	gtkwave controller_tb.vcd

