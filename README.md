# Minesweeper

O trabalho final da disciplina de **TEC-V** é um conjunto de exercícios que, quando resolvidos, implementam o jogo Campo Minado.  
O jogo possui um tabuleiro quadrangular com várias posições. Quando o jogador abre uma posição, se essa posição contém uma mina escondida, o jogo acaba. Se a posição aberta é adjacente a uma mina, a posição aberta irá apresentar o número de minas adjacentes a essa posição.  
Se o jogador abre uma posição que não é adjacente à uma mina, então todas as posições adjacentes são abertas automaticamente até que se encontre posições adjacentes à minas. O objetivo do jogador é abrir as posições até que todas as posições ainda fechadas contenham somente minas. Essa versão do jogo não possui a opção de marcar as minas.

## PRIMEIRA PARTE - FUNÇÕES PARA MANIPULAR OS TABULEIROS DO JOGO (MATRIZES)

A ideia das próximas funções é permitir que a gente acesse uma lista usando um indice, como se fosse um vetor.  

**get_arr/2** (get array):  recebe uma lista (vetor) e uma posicao (p) e devolve o elemento na posição p do vetor. O vetor começa na posição 0 (zero). Não é necessário tratar erros.  
```
def get_arr([h|_t], 0), do: ...  
def get_arr([_h|t], n), do: ...
```

**update_arr/3** (update array): recebe uma lista(vetor), uma posição (p) e um novo valor (v)e devolve um novo vetor com o valor v na posição p. O vetor começa na posição 0 (zero).  
```
def update_arr([_h|t],0,v), do: ...  
def update_arr([h|t],n,v), do: ...
```

**get_pos/3** (get position): recebe um tabuleiro (matriz), uma linha (l) e uma coluna (c) (não precisa validar). Devolve o elemento na posicao tabuleiro[l,c]. Usar get_arr/2 na implementação.  
```
def get_pos(tab,l,c), do: ...
```

**update_pos/4** (update position): recebe um tabuleiro, uma linha, uma coluna e um novo valor. Devolve o tabuleiro modificado com o novo valor na posiçao linha x coluna. Usar update_arr/3 e get_arr/2 na implementação.  
```
def update_pos(tab,l,c,v), do: ...
```

## SEGUNDA PARTE - LÓGICA DO JOGO

**is_mine/3**: recebe um tabuleiro com o mapeamento das minas, uma linha, uma coluna. Devolve true caso a posição contenha uma mina e false caso contrário. Usar get_pos/3 na implementação.  
```
def is_mine(tab,l,c), do: ...
```

**is_valid_pos/3** Recebe o tamanho do tabuleiro (ex, em um tabuleiro 9x9, o tamanho é 9), uma linha e uma coluna, e diz se essa posição é válida no tabuleiro.  
```
def is_valid_pos(tamanho,l,c), do: ...
```

**gerar_adjascentes/2**: Recebe uma posição (linha, coluna) e retorna uma lista de tuplas com a posição de todos os elementos adjascentes.  
```
def gerar_adjascentes(l, c), do: ...
```

**valid_moves/3**: Dado o tamanho do tabuleiro e uma posição atual (linha e coluna), retorna uma lista com todas as posições válidas adjacentes à posição atual.  
```
def valid_moves(tam,l,c), do: ...
```

**pegaTam/1**: Recebe uma matriz quadrada e retorna o tamanho dessa matriz.  
```
def pegaTam([]), do: ...
def pegaTam([_h|t]), do: ...
```

**conta_minas_adj/3**: recebe um tabuleiro com o mapeamento das minas e uma  uma posicao  (linha e coluna), e conta quantas minas existem nas posições adjacentes.  
```
def conta_minas_adj(tab,l,c) do
    (...)
end
```

**abre_jogada/4** (Função principal do jogo): Recebe uma posição a ser aberta (linha e coluna), o mapa de minas e o tabuleiro do jogo. Devolve como resposta o tabuleiro do jogo modificado com essa jogada.  
Essa função é recursiva, pois no caso da entrada ser uma posição sem minas adjacentes, o algoritmo deve seguir abrindo todas as posições adjacentes até que se encontre posições adjacentes à minas. Vamos analisar os casos:  
- Se a posição a ser aberta é uma mina, o tabuleiro não é modificado e encerra.
- Se a posição a ser aberta já foi aberta, o tabuleiro não é modificado e encerra.
- Se a posição a ser aberta é adjacente a uma ou mais minas, devolver o tabuleiro modificado com o número de minas adjacentes na posição aberta.
- Se a posição a ser aberta não possui minas adjacentes, abrimos ela com zero (0) e recursivamente abrimos as outras posições adjacentes a ela.
```
def abre_jogada(l,c,minas,tab) do
    (...)
end
```

**abre_posicao/4**: Recebe um tabueiro de jogos, o mapa de minas, uma linha e uma coluna. Essa função verifica:  
- Se a posição {l,c} já está aberta (contém um número), então essa posição não deve ser modificada.
- Se a posição {l,c} contém uma mina no mapa de minas, então marcar  com "*" no tabuleiro.
- Se a posição {l,c} está fechada (contém "-"), escrever o número de minas adjascentes a esssa posição no tabuleiro (usar conta_minas).
```
def abre_posicao(tab,minas,l,c) do
    (...)
end
```

**lista_indices/1**: Recebe um índice final e retorna uma lista de índices de zero até o índice inclusive.  
Exemplo: *lista_indices(2) -> [0,1,2]*  
```
def lista_indices(1), do: ...
def lista_indices(tamanho), do: ...
```

**abre_tabuleiro/2**: Recebe o mapa de Minas e o tabuleiro do jogo, e abre todo o tabuleiro do jogo, mostrando onde estão as minas e os números nas posições adjecentes às minas.  
Essa função é usada para mostrar todo o tabuleiro no caso de vitória ou derrota. Para implementar esta função, usar a função abre_posicao/4.  
```
def abre_tabuleiro(minas,tab) do
    (...)
end
```

**string_cabecalho/1**: Recebe o índice final de um tabuleiro e retorna uma string com o cabeçalho do tabuleiro conatendo os calores de 0 até o índice.
```
def string_cabecalho(0), do: ...
def string_cabecalho(ultimo), do: ...
```

**string_linhas/2**: Recebe um tabuleiro e o indice final desse tabuleiro, retornando uma string com todas as linhas do tabuleiro.  
```
def string_linhas(tab, ultimo) do
    (...)
end
```

**board_to_string/1**: Recebe o tabuleiro do jogo e devolve uma string que é a representação visual desse tabuleiro. Essa função é aplicada no tabuleiro antes de fazer o print dele na tela.  
```
def board_to_string(tab) do
    (...)
end
```

**gera_lista/2**: Recebe um inteiro n, um valor v, e gera uma lista contendo n vezes o valor v.  
```
def gera_lista(0,v), do: ...
def gera_lista(n,v), do: ...
```

**gera_tabuleiro/1**: Recebe o tamanho do tabuleiro de jogo e gera um tabuleiro  novo, todo fechado (todas as posições contém "-"). Usar gera_lista/2.  
```
def gera_tabuleiro(n), do: ...
```

**gera_mapa_de_minas/1**: Recebe o tamanho do tabuleiro e gera um mapa de minas zero, onde todas as posições contém false.  
```
def gera_mapa_de_minas(n), do: ...
```

**conta_fechadas/1**: Recebe um tabueleiro de jogo e conta quantas posições fechadas existem no tabuleiro (posições com "-").  
```
def conta_fechadas(tab) do
(...)
end
```

**conta_minas/1**: Recebe o tabuleiro de Minas (minas) e conta quantas minas existem no jogo.  
```
def conta_minas(minas) do
(...)
end
```

**end_game?/2**: Recebe o tabuleiro de minas, o tauleiro do jogo, e diz se o jogo acabou. O jogo acabou quando o número de casas fechadas é igual ao numero de minas.  
```
def end_game(minas,tab), do:  ...
```

## EXTRA - FUNÇÕES DE APOIO

**map/2**: Recebe uma lista e uma função, aplica a função em todos os elementos da lista e retorna a lista resultante.  
```
def map([],_f), do: ...
def map([h|t], f), do: ...
```

**filter/2**: Recebe uma lista e uma função, aplica a função em todos os elementos da lista e retorna uma lista com os elementos filtrados pela função.  
```
def filter([],_f), do: ...
def filter([h|t], f) do
    (...)
end
```

**reduce/3**: Recebe uma lista, um acumulador e uma função. Aplica a função a todos os elementos da lista e ao acomulador, retornando o acumulador resultante.  
```
def reduce([], acc, _f), do: ...
def reduce([h|t], acc, f), do: ...
```

## MOTOR DO JOGO

O motor compila as funções desenvolvidas até o momento em um jogo, o campo minado. Assim, a partir de um tamanho, ele gera um tabuleiro fechado e um campo com minas em posições aleatórias. Então, começa o loop do jogo, onde o usuário insere posições até revelar todas as posições que não possuem minas e ganhar o jogo.