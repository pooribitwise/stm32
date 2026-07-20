MEMORY {
	/* flash memory based on refrence manual for stm32f103c6 */
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 32K

	/* ram based on refrence manual for stm32f103c6 */
	RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 10K
}

SECTIONS {
	/* write program to flash */
	.text :
	{
		*(.isr_vector)	/* interrupt vector defined in startup.c */
		*(.text)
		*(.rodata)	/* const vars */
	} > FLASH

	/* allocate vars in ram, but store inital values in flash */
	.data :
	{
		_sdata = .;	/* temp var declared in startup.c for vars allocation start */
		*(.data)	/* all vars */
		_edata = .;	/* temp var in startup.c for data end */
	} > RAM AT > FLASH

	_sidata = LOADADDR(.data);

	/* just allocate no valued vars in ram */
	.bss :
	{
		_sbss = .;	/* bss start in startup.c */
		*(.bss)
		_ebss = .;
	} > RAM
}
