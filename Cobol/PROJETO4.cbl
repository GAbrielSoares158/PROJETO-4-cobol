      *===============================================*
      * PROGRAMA: PROJETO4                            *
      * ALUNO: GABRIEL SOARES                         *
      * DESCRICAO: RELATORIO DE CONTAS BANCARIAS      *
      *===============================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJETO4.
       AUTHOR. GABRIEL SOARES.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-CONTAS ASSIGN TO UT-S-CONTAS
               ORGANIZATION IS SEQUENTIAL
               FILE STATUS IS WS-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD ARQ-CONTAS
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 54 CHARACTERS.

       01 REG-ENTRADA.
           05 NUM-CONTA      PIC 9(08).
           05 NOME-CLIENTE   PIC X(30).
           05 AGENCIA        PIC 9(04).
           05 TIPO-CONTA     PIC X(01).
           05 SALDO          PIC S9(09)V99.

       WORKING-STORAGE SECTION.

       01 WS-STATUS          PIC XX VALUE SPACES.
       01 WS-FIM             PIC X  VALUE 'N'.
       01 WS-TOTAL-CONTAS    PIC 9(05) VALUE ZEROS.
       01 WS-SALDO-TOTAL     PIC S9(12)V99 VALUE ZEROS.
       01 WS-SALDO-EDIT      PIC ZZZ.ZZ9,99.
       01 WS-TOTAL-EDIT      PIC ZZ9.
       01 WS-TIPO-DESC       PIC X(10) VALUE SPACES.

       PROCEDURE DIVISION.

       INICIO.
           OPEN INPUT ARQ-CONTAS.

           IF WS-STATUS NOT = '00'
               DISPLAY 'ERRO AO ABRIR ARQUIVO'
               STOP RUN
           END-IF.

           DISPLAY '============================================'.
           DISPLAY '===== RELATORIO DE CONTAS BANCARIAS ====='.
           DISPLAY '============================================'.
           DISPLAY '--------------------------------------------'.
           DISPLAY 'CONTA    NOME CLIENTE          AGENCIA TIPO'
               '       SALDO'.
           DISPLAY '--------------------------------------------'.

           READ ARQ-CONTAS
               AT END MOVE 'S' TO WS-FIM
           END-READ.

       PROCESSAR.
           IF WS-FIM = 'S'
               GO TO FINALIZAR
           END-IF.

           IF TIPO-CONTA = 'C'
               MOVE 'CORRENTE  ' TO WS-TIPO-DESC
           END-IF.
           IF TIPO-CONTA = 'P'
               MOVE 'POUPANCA  ' TO WS-TIPO-DESC
           END-IF.
           IF TIPO-CONTA NOT = 'C' AND TIPO-CONTA NOT = 'P'
               MOVE 'INVALIDO  ' TO WS-TIPO-DESC
           END-IF.

           MOVE SALDO TO WS-SALDO-EDIT.

           DISPLAY NUM-CONTA ' ' NOME-CLIENTE ' '
               AGENCIA ' ' WS-TIPO-DESC ' ' WS-SALDO-EDIT.

           ADD 1 TO WS-TOTAL-CONTAS.
           ADD SALDO TO WS-SALDO-TOTAL.

           READ ARQ-CONTAS
               AT END MOVE 'S' TO WS-FIM
           END-READ.

           GO TO PROCESSAR.

       FINALIZAR.
           CLOSE ARQ-CONTAS.

           MOVE WS-TOTAL-CONTAS TO WS-TOTAL-EDIT.
           MOVE WS-SALDO-TOTAL  TO WS-SALDO-EDIT.

           DISPLAY '--------------------------------------------'.
           DISPLAY 'TOTAL DE CONTAS : ' WS-TOTAL-EDIT.
           DISPLAY 'SALDO TOTAL     : ' WS-SALDO-EDIT.
           DISPLAY '============================================'.

           STOP RUN.
