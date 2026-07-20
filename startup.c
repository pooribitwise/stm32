#include <stdint.h>

/* These are defined in linker.ld and these declarations are to retrieve the address */
extern uint32_t	_sidata;	// data in flash start
extern uint32_t	_sdata;		// data in ram start
extern uint32_t	_edata;		// data in ram end
extern uint32_t	_sbss;		// zero vars in ram start
extern uint32_t	_ebss;		// zero vars in ram end

/* main.c */
extern int main(void);

/* executes after reset (and first run) */
void Reset_Handler(void) {
	uint32_t *src;
	uint32_t *dest;

	// copy vars from flash data section to ram
	src = &_sidata;
	dest = &_sdata;
	while (dest < &_edata)
		*dest++ = *src++;

	// set bss to zero in ram
	while (dest < &_sbss)
		*dest++ = 0;

	// jmp to main
	main();

	// if main finished make it stall here (to prevent crashes
	while(1);
}


/*
 * vetor table definition:
 * gcc will be told to put these in isr_vector
 */
__attribute__((section(".isr_vector")))
void (* const vector_table[])(void) = {
	(void (*)(void))0x20002800,	// for 10KB ram we need 4 bytes to address the stack pointer
	Reset_Handler
};
