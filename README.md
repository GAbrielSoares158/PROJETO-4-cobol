# Projeto 4 - COBOL - Semana 6
## Processamento de Contas Bancárias

**Aluno:** Gabriel Soares  
**Ambiente:** TK4- / MVS 3.8j

---

## O que o projeto faz

1. Ordena o arquivo de contas por agência (usando SORT)
2. Lê o arquivo ordenado com o programa COBOL
3. Exibe os dados de cada conta com tipo (CORRENTE/POUPANCA/INVALIDO)
4. Mostra o total de contas e saldo total no final

---

## Arquivos do projeto

```
Cobol/
  PROJETO4.cbl       → programa principal em COBOL

Copia/
  REGCONTA.cpy       → layout do registro de conta

Jcl/
  Cobp4.jcl          → compila o programa
  Executarp4.jcl     → ordena o arquivo e executa o programa

CONTAS.txt           → arquivo com os dados das contas (12 registros)
CONTAS.NOVAS.txt     → contas extras (desafio opcional)
```

---

## Layout do registro (LRECL = 54)

| Campo        | Tamanho | Posição | Descrição                   |
|--------------|---------|---------|-----------------------------|
| NUM-CONTA    | 8       | 1-8     | Número da conta             |
| NOME-CLIENTE | 30      | 9-38    | Nome do cliente             |
| AGENCIA      | 4       | 39-42   | Número da agência           |
| TIPO-CONTA   | 1       | 43      | C = Corrente / P = Poupança |
| SALDO        | 11      | 44-54   | Saldo da conta              |

---

## Como executar no TK4-

### 1. Criar os datasets no RPF (opção 3 → 2)

| Dataset               | RECFM | LRECL | BLKSIZE | DIR |
|-----------------------|-------|-------|---------|-----|
| HERC01.COBOL.SOURCE   | FB    | 80    | 3200    | 5   |
| HERC01.COBOL.COPYLIB  | FB    | 80    | 3200    | 5   |
| HERC01.COBOL.LOADLIB  | U     | 0     | 6144    | 5   |
| HERC01.DADOS.CONTAS   | FB    | 54    | 5400    | 0   |
| HERC01.DADOS.CONTASRD | FB    | 54    | 5400    | 0   |

### 2. Inserir os membros no RPF (opção 2)

- `HERC01.COBOL.SOURCE(PROJETO4)` → PROJETO4.cbl
- `HERC01.COBOL.COPYLIB(REGCONTA)` → REGCONTA.cpy
- `HERC01.DADOS.CONTAS` → CONTAS.txt

### 3. Compilar — submeter Cobp4.jcl
```
SUB
```
Verificar CC 0000 no QUEUE (opção 4 no menu TSO).

### 4. Executar — submeter Executarp4.jcl
```
SUB
```
Verificar o relatório no QUEUE, passo EXECUTA.
