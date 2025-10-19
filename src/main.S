.intel_syntax noprefix

.extern Fl_set_scheme
.extern Fl_Double_Window_new
.extern Fl_Double_Window_end
.extern Fl_Window_show_with_args
.extern Fl_Flex_new
.extern Fl_Flex_begin
.extern Fl_Flex_end
.extern Fl_Flex_remove
.extern Fl_Flex_set_size
.extern Fl_Flex_set_type
.extern Fl_Input_new
.extern Fl_Input_value
.extern Fl_Button_new
.extern Fl_Button_set_callback
.extern Fl_Button_set_label_color
.extern Fl_Check_Button_new
.extern Fl_Check_Button_set_label
.extern Fl_redraw
.extern Fl_run

.section .rodata
    scheme:        .asciz "gtk+"
    title:         .asciz "Tada"
    add_task:      .asciz "Task:"
    button_label:  .asciz "@+"

.section .bss
    .align 8
    container_ptr:    .zero 8

.section .text
.global main

check_btn_callback:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp - 16], rdi  # store the check button pointer
    mov rdi, container_ptr[rip]
    mov rsi, [rbp - 16]
    call Fl_Flex_remove
    call Fl_redraw
    leave
    ret

add_btn_callback:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 32], rsi  # store input widget pointer
.input_value:
    mov rdi, [rbp - 32]
    call Fl_Input_value
.check_input_value:
    cmp byte ptr [rax], 0
    je .end_add_callback
    mov [rbp - 16], rax
.container_begin:
    mov rdi, container_ptr[rip]
    call Fl_Flex_begin
.create_check_button:
    xor edi, edi
    xor esi, esi
    xor edx, edx
    xor ecx, ecx
    xor r8, r8
    call Fl_Check_Button_new
    mov [rbp - 24], rax
.copy_label:
    mov rdi, [rbp - 24]
    mov rsi, [rbp - 16]
    call Fl_Check_Button_set_label
.set_check_button_callback:
    mov rdi, [rbp - 24]
    lea rsi, check_btn_callback[rip]
    xor rdx, rdx
    call Fl_Check_Button_set_callback
.check_button_fixed:
    mov rdi, container_ptr[rip]
    mov rsi, [rbp - 24]
    mov edx, 30
    call Fl_Flex_set_size
.container_end:
    mov rdi, container_ptr[rip]
    call Fl_Flex_end
    call Fl_redraw
.end_add_callback:
    leave
    ret

main:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    # store argc and argv
    push rdi
    push rsi
    # window [rbp - 64]
    # column [rbp - 48]
    # row1   [rbp - 40]
    # input  [rbp - 32]
    # button [rbp - 24]
.set_scheme:
    lea rdi, scheme[rip]
    call Fl_set_scheme
.create_window:
    xor edi, edi
    xor esi, esi
    mov edx, 400
    mov ecx, 300
    lea r8, title[rip]
    call Fl_Double_Window_new
    mov [rbp - 64], rax
.create_col:
    mov edi, 2
    mov esi, 5
    mov edx, 396
    mov ecx, 290
    xor r8, r8
    call Fl_Flex_new
    mov [rbp - 48], rax
.create_row1:
    xor edi, edi
    xor esi, esi
    xor edx, edx
    xor ecx, ecx
    xor r8, r8
    call Fl_Flex_new
    mov [rbp - 40], rax
.make_row1_row:
    mov rdi, [rbp - 40]
    mov esi, 1
    call Fl_Flex_set_type
.row1_fixed:
    mov rdi, [rbp - 48]
    mov rsi, [rbp - 40]
    mov edx, 30
    call Fl_Flex_set_size
.create_label:
    xor edi, edi
    xor esi, esi
    xor edx, edx
    xor ecx, ecx
    lea r8, add_task[rip]
    call Fl_Box_new
    mov rdi, [rbp - 40]
    mov rsi, rax
    mov edx, 40
    call Fl_Flex_set_size
.create_inp:
    xor edi, edi
    xor esi, esi
    xor edx, edx
    xor ecx, ecx
    xor r8, r8
    call Fl_Input_new
    mov [rbp - 32], rax
.create_button:
    xor edi, edi
    xor esi, esi
    xor edx, edx
    xor ecx, ecx
    lea r8, button_label[rip]
    call Fl_Button_new
    mov [rbp - 24], rax
.set_button_color:
    mov rdi, [rbp - 24]
    mov esi, 0x00FF0000      # Green color in 0xRRGGBBII format
    call Fl_Button_set_label_color
.set_button_callback:
    mov rdi, [rbp - 24]
    lea rsi, add_btn_callback[rip]
    mov rdx, [rbp - 32]
    call Fl_Button_set_callback
.make_button_fixed:
    mov rdi, [rbp - 40]
    mov rsi, [rbp - 24]
    mov edx, 30
    call Fl_Flex_set_size
.end_row1:
    mov rdi, [rbp - 40]
    call Fl_Flex_end
.make_col_flexible:
    xor edi, edi
    xor esi, esi
    xor edx, edx
    xor ecx, ecx
    xor r8, r8
    call Fl_Flex_new
    mov container_ptr[rip], rax
    mov rdi, rax
    call Fl_Flex_end
.end_col:
    mov rdi, [rbp - 48]
    call Fl_Flex_end
.window_end:
    mov rdi, [rbp - 64]
    call Fl_Double_Window_end
    mov rdi, [rbp - 64]
.window_show_with_args:
    pop rdx
    pop rsi
    call Fl_Window_show_with_args
    call Fl_run
    leave
    ret
