;********************************************************************************************************
;                                              uC/OS-II
;                                        The Real-Time Kernel
;
;                    Copyright 1992-2020 Silicon Laboratories Inc. www.silabs.com
;
;                                 SPDX-License-Identifier: APACHE-2.0
;
;               This software is subject to an open source license and is distributed by
;                Silicon Laboratories Inc. pursuant to the terms of the Apache License,
;                    Version 2.0 available at www.apache.org/licenses/LICENSE-2.0.
;
;********************************************************************************************************

;********************************************************************************************************
;
;                                           PIC24 MPLab Port
;                                    For the Hi-Tech dsPICC Compiler
;
; Filename : os_cpu_util_a.as
; Version  : V2.93.00
;********************************************************************************************************

;
;********************************************************************************************************
;                                                 GLOBALS
;********************************************************************************************************
;

    GLOBAL    _OSIntNesting
    GLOBAL    _OSTCBCur
    GLOBAL    _OSIntExit

;
;********************************************************************************************************
;                                            MACRO OS_REGS_SAVE
;
; Description : This macro saves the current state of the CPU onto the current tasks stack
;
; Notes       : W15 is the CPU stack pointer. It should never be pushed from the stack during
;               a context save.
;********************************************************************************************************
;

OS_REGS_SAVE MACRO                                                      ; Start of Macro
    push.d   w0                                                         ; Push W0 and W1 onto the stack
    push.d   w2                                                         ; Push W2 and W3 onto the stack
    push.d   w4                                                         ; Push W4 and W5 onto the stack
    push.d   w6                                                         ; Push W6 and W7 onto the stack
    push.d   w8                                                         ; Push W8 and W9 onto the stack
    push.d   w10                                                        ; Push W10 and W11 onto the stack
    push.d   w12                                                        ; Push W12 and W13 onto the stack
    push     w14                                                        ; Push W14 **ONLY** onto the stack

    push     TBLPAG                                                     ; Push the Table Page Register onto the stack
    push     PSVPAG                                                     ; Push the Program Space Visibility Register onto the stack
    push     RCOUNT                                                     ; Push the Repeat Loop Counter Register onto the stack

    push     SR                                                         ; Push the CPU Status Register onto the stack
    push     CORCON                                                     ; Push the Core Control Register onto the stack
ENDM                                                                    ; End of Macro

;
;********************************************************************************************************
;                                            MACRO OS_REGS_RESTORE
;
; Description : This macro restores the current state of the CPU from the current tasks stack
;
; Notes       : 1) W15 is the CPU stack pointer. It should never be popped from the stack during
;                  a context restore.
;               2) Registers are always popped in the reverse order from which they were pushed
;********************************************************************************************************
;

OS_REGS_RESTORE MACRO                                                   ; Start of Macro
    pop      CORCON                                                     ; Pull the Core Control Register from the stack
    pop      SR                                                         ; Pull the CPU Status Register from the stack

    pop      RCOUNT                                                     ; Pull the Repeat Loop Counter Register from the stack
    pop      PSVPAG                                                     ; Pull the Program Space Visibility Register from the stack
    pop      TBLPAG                                                     ; Pull the Table Page Register from the stack

    pop      w14                                                        ; Pull W14 **ONLY** from the stack
    pop.d    w12                                                        ; Pull W12 and W13 from the stack
    pop.d    w10                                                        ; Pull W10 and W11 from the stack
    pop.d    w8                                                         ; Pull W8  and W9 from the stack
    pop.d    w6                                                         ; Pull W6  and W7 from the stack
    pop.d    w4                                                         ; Pull W4  and W5 from the stack
    pop.d    w2                                                         ; Pull W2  and W3 from the stack
    pop.d    w0                                                         ; Pull W0  and W1 from the stack
ENDM                                                                    ; End of Macro


