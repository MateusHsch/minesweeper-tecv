defmodule Minesweeper do
  # PRIMEIRA PARTE - FUNÇÕES PARA MANIPULAR OS TABULEIROS DO JOGO (MATRIZES)

  # A ideia das próximas funções é permitir que a gente acesse uma lista usando um indice,
  # como se fosse um vetor

  # get_arr/2 (get array):  recebe uma lista (vetor) e uma posicao (p) e devolve o elemento
  # na posição p do vetor. O vetor começa na posição 0 (zero). Não é necessário tratar erros.

  # def get_arr([h|_t], 0), do: ...
  # def get_arr([_h|t], n), do: ...

  def get_arr([h|_t], 0), do: h
  def get_arr([_h|t], n), do: get_arr(t, n-1)

  # update_arr/3 (update array): recebe uma lista(vetor), uma posição (p) e um novo valor (v)e devolve um
  # novo vetor com o valor v na posição p. O vetor começa na posição 0 (zero)

  #def update_arr([_h|t],0,v), do: ...
  #def update_arr([h|t],n,v), do: ...

  def update_arr([_h|t], 0, v), do: [v|t]
  def update_arr([h|t], n, v), do: [h|update_arr(t, n-1, v)]

  # O tabuleiro do jogo é representado como uma matriz. Uma matriz, nada mais é do que um vetor de vetores.
  # Dessa forma, usando as operações anteriores, podemos criar funções para acessar os tabuleiros, como
  # se  fossem matrizes:

  # get_pos/3 (get position): recebe um tabuleiro (matriz), uma linha (l) e uma coluna (c) (não precisa validar).
  # Devolve o elemento na posicao tabuleiro[l,c]. Usar get_arr/2 na implementação

  #def get_pos(tab,l,c), do: ...

  def get_pos(tab, l, c), do: get_arr(get_arr(tab, l), c)

  # update_pos/4 (update position): recebe um tabuleiro, uma linha, uma coluna e um novo valor. Devolve
  # o tabuleiro modificado com o novo valor na posiçao linha x coluna. Usar update_arr/3 e get_arr/2 na implementação

  #def update_pos(tab,l,c,v), do: ...

  def update_pos(tab, l, c, v), do: update_arr(tab, l, update_arr(get_arr(tab, l), c, v))

  # SEGUNDA PARTE: LÓGICA DO JOGO

  #-- is_mine/3: recebe um tabuleiro com o mapeamento das minas, uma linha, uma coluna. Devolve true caso a posição contenha
  # uma mina e false caso contrário. Usar get_pos/3 na implementação
  #
  # Exemplo de tabuleiro de minas:
  #
  # _mines_board = [[false, false, false, false, false, false, false, false, false],
  #                 [false, false, false, false, false, false, false, false, false],
  #                 [false, false, false, false, false, false, false, false, false],
  #                 [false, false, false, false, false, false, false, false, false],
  #                 [false, false, false, false, true , false, false, false, false],
  #                 [false, false, false, false, false, true, false, false, false],
  #                 [false, false, false, false, false, false, false, false, false],
  #                 [false, false, false, false, false, false, false, false, false],
  #                 [false, false, false, false, false, false, false, false, false]]
  #
  #mines_board = [[false, false, false, false, false, false, false, false, false],[false, false, false, false, false, false, false, false, false],[false, false, false, false, false, false, false, false, false],[false, false, false, false, false, false, false, false, false],[false, false, false, false, true , false, false, false, false],[false, false, false, false, false, true, false, false, false],[false, false, false, false, false, false, false, false, false],[false, false, false, false, false, false, false, false, false],[false, false, false, false, false, false, false, false, false]]
  #
  #board = [ ["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", 1 , 1 , 2 , "-", "-", "-", "-"],[1 , 1 , 1 , 0 , 1 , 1 , "-", "-", "-"],[0 , 0 , 0 , 0 , 0 , 1 , "-", "-", "-"],[0 , 0 , 0 , 0 , 0 , 1 , "-", "-", "-"]]
  #
  # esse tabuleiro possuí minas nas posições 4x4 e 5x5

  #def is_mine(tab,l,c), do: ...

  def is_mine(tab, l, c), do: get_pos(tab, l, c)

  # is_valid_pos/3 recebe o tamanho do tabuleiro (ex, em um tabuleiro 9x9, o tamanho é 9),
  # uma linha e uma coluna, e diz se essa posição é válida no tabuleiro. Por exemplo, em um tabuleiro
  # de tamanho 9, as posições 1x3,0x8 e 8x8 são exemplos de posições válidas. Exemplos de posições
  # inválidas seriam 9x0, 10x10 e -1x8

  #def is_valid_pos(tamanho,l,c), do: ...

  def is_valid_pos(tamanho, l, c), do: l>=0 && l<tamanho && c>=0 && c<tamanho

  # valid_moves/3: Dado o tamanho do tabuleiro e uma posição atual (linha e coluna), retorna uma lista
  # com todas as posições adjacentes à posição atual
  # Exemplo: Dada a posição linha 3, coluna 3, as posições adjacentes são: [{2,2},{2,3},{2,4},{3,2},{3,4},{4,2},{4,3},{4,4}]
  #   ...   ...      ...    ...   ...
  #   ...  (2,2)    (2,3)  (2,4)  ...
  #   ...  (3,2)    (3,3)  (3,4)  ...
  #   ...  (4,2)    (4,3)  (4,4)  ...
  #   ...   ...      ...    ...   ...

  #  Dada a posição (0,0) que é um canto, as posições adjacentes são: [(0,1),(1,0),(1,1)]

  #  (0,0)  (0,1) ...
  #  (1,0)  (1,1) ...
  #   ...    ...  ..
  # Uma maneira de resolver seria gerar todas as 8 posições adjacentes e depois filtrar as válidas usando is_valid_pos

  #def valid_moves(tam,l,c), do: ...
  
  def map([],_f), do: []
  def map([h|t], f), do: [f.(h)|map(t,f)]

  def filter([],_f), do: []
  def filter([h|t], f) do
    cond do
      f.(h) -> [h|filter(t,f)]
      true -> filter(t,f)
    end
  end

  def gerar_adjascentes(l, c), do: [{l-1,c-1}, {l-1,c}, {l-1,c+1}, {l,c-1}, {l,c+1}, {l+1,c-1}, {l+1,c}, {l+1,c+1}]

  def valid_moves(tam, l, c), do: filter(gerar_adjascentes(l, c), fn({i,j}) -> is_valid_pos(tam,i,j) end)

  # conta_minas_adj/3: recebe um tabuleiro com o mapeamento das minas e uma  uma posicao  (linha e coluna), e conta quantas minas
  # existem nas posições adjacentes

  # def conta_minas_adj(tab,l,c) do
  #   (...)
  # end

  def reduce([], acc, _f), do: acc
  def reduce([h|t], acc, f), do: f.(h, reduce(t, acc, f))

  def pegaTam([]), do: 0
  def pegaTam([_h|t]), do: pegaTam(t) +1

  def conta_minas_adj(tab, l, c) do
    reduce(map(valid_moves(pegaTam(tab), l, c), fn({i,j}) ->
      cond do
        is_mine(tab,i,j) -> 1
        true -> 0
      end
    end), 0, fn(x,y) -> x+y end)
  end


  # abre_jogada/4: é a função principal do jogo!!
  # recebe uma posição a ser aberta (linha e coluna), o mapa de minas e o tabuleiro do jogo. Devolve como
  # resposta o tabuleiro do jogo modificado com essa jogada.
  # Essa função é recursiva, pois no caso da entrada ser uma posição sem minas adjacentes, o algoritmo deve
  # seguir abrindo todas as posições adjacentes até que se encontre posições adjacentes à minas.
  # Vamos analisar os casos:
  # - Se a posição a ser aberta é uma mina, o tabuleiro não é modificado e encerra
  # - Se a posição a ser aberta já foi aberta, o tabuleiro não é modificado e encerra
  # - Se a posição a ser aberta é adjacente a uma ou mais minas, devolver o tabuleiro modificado com o número de
  # minas adjacentes na posição aberta
  # - Se a posição a ser aberta não possui minas adjacentes, abrimos ela com zero (0) e recursivamente abrimos
  # as outras posições adjacentes a ela

  #def abre_jogada(l,c,minas,tab) do
  #   (...)
  #end

  #fechado = [["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"],["-", "-", "-", "-", "-", "-", "-", "-", "-"]]

  #minas = [[false, true,  false, false, true,  false, false, true,  false],[true,  false, false, true,  true,  false, false, false, true],[false, false, false, true,  false, false, true,  false, false],[true,  false, false, false, false, false, false, false, true],[true,  false, true,  false, false, true,  true,  true,  false],[false, true,  true,  false, true,  false, false, true,  true],[true,  false, true,  false, true,  true,  false, false, true],[false, false, false, true,  false, false, true,  true,  true],[true,  false, true,  true,  true,  false, false, false, false]]

  def abre_jogada(l, c, minas, tab) do
    cond do
      is_mine(minas, l, c) -> tab
      get_pos(tab,l , c) != "-" -> tab
      conta_minas_adj(minas, l, c) > 0 -> update_pos(tab, l, c, conta_minas_adj(minas, l, c))
      true ->
        novo_tab = update_pos(tab, l, c, "0")
        reduce(valid_moves(pegaTam(tab), l, c), novo_tab, fn({i,j}, acc_tab) -> abre_jogada(i, j, minas, acc_tab) end)
    end
  end


# abre_posicao/4, que recebe um tabueiro de jogos, o mapa de minas, uma linha e uma coluna
# Essa função verifica:
# - Se a posição {l,c} já está aberta (contém um número), então essa posição não deve ser modificada
# - Se a posição {l,c} contém uma mina no mapa de minas, então marcar  com "*" no tabuleiro
# - Se a posição {l,c} está fechada (contém "-"), escrever o número de minas adjascentes a esssa posição no tabuleiro (usar conta_minas)

#def abre_posicao(tab,minas,l,c) do
# (...)
#end

  def abre_posicao(tab, minas, l, c) do
    cond do
      is_mine(minas, l, c) -> update_pos(tab, l, c, "*")
      get_pos(tab, l, c) == "-" -> update_pos(tab, l, c, conta_minas_adj(minas, l, c))
      true -> update_pos(tab, l, c, get_pos(tab, l, c))
    end
  end



# abre_tabuleiro/2: recebe o mapa de Minas e o tabuleiro do jogo, e abre todo o tabuleiro do jogo, mostrando
# onde estão as minas e os números nas posições adjecentes às minas.Essa função é usada para mostrar
# todo o tabuleiro no caso de vitória ou derrota. Para implementar esta função, usar a função abre_posicao/4


  #def abre_tabuleiro(minas,tab) do
  #   (...)
  #end

  def lista_indices(0), do: [0]
  def lista_indices(ultimo), do: lista_indices(ultimo-1) ++ [ultimo]

  def abre_tabuleiro(minas, tab) do
    tamanho = pegaTam(tab)
  
    reduce(lista_indices(tamanho-1), tab, fn (l, acc_tab) ->
      reduce(lista_indices(tamanho-1), acc_tab, fn (c, acc_tab2) ->
        abre_posicao(acc_tab2, minas, l, c)
      end)
    end)
  end


# board_to_string/1: -- Recebe o tabuleiro do jogo e devolve uma string que é a representação visual desse tabuleiro.
# Essa função é aplicada no tabuleiro antes de fazer o print dele na tela. Usar a sua imaginação para fazer um
# tabuleiro legal. Olhar os exemplos no .pdf com a especificação do trabalho. Não esquecer de usar \n para quebra de linhas.
# Você pode quebrar essa função em mais de uma: print_header, print_linhas, etc...

  #def board_to_string(tab) do
  # (...)
  #end

  def string_cabecalho(0), do: "   0 "
  def string_cabecalho(ultimo), do: string_cabecalho(ultimo-1) <> "#{ultimo} "

  def string_linhas(tab, ultimo) do
    reduce(lista_indices(ultimo), "", fn(l, acc_string) ->
      " #{l} " <>
      reduce(lista_indices(ultimo), acc_string, fn(c, acc_string2) ->
        cond do
          c == ultimo -> "#{get_pos(tab, l, c)}\n" <> acc_string2
          true -> "#{get_pos(tab, l, c)} " <> acc_string2
        end
      end)
    end)
  end

  def board_to_string(tab) do
    tamanho = pegaTam(tab)
    
    string_cabecalho(tamanho-1) <> "\n" <> string_linhas(tab, tamanho-1)
  end

# gera_lista/2: recebe um inteiro n, um valor v, e gera uma lista contendo n vezes o valor v

  #def gera_lista(0,v), do: ...
  #def gera_lista(n,v), do: ...

  def gera_lista(0, _v), do: []
  def gera_lista(n, v), do: [v | gera_lista(n-1, v)]

# -- gera_tabuleiro/1: recebe o tamanho do tabuleiro de jogo e gera um tabuleiro  novo, todo fechado (todas as posições
# contém "-"). Usar gera_lista

  #def gera_tabuleiro(n), do: ...

  def gera_linhas(_tam, 0, _v), do: []
  def gera_linhas(tam, l, v), do: [gera_lista(tam, v) | gera_linhas(tam, l-1, v)]

  def gera_tabuleiro(n), do: gera_linhas(n, n, "-")

# -- gera_mapa_de_minas/1: recebe o tamanho do tabuleiro e gera um mapa de minas zero, onde todas as posições contém false

  #def gera_mapa_de_minas(n), do: ...

  def gera_mapa_de_minas(n), do: gera_linhas(n, n, false)

# conta_fechadas/1: recebe um tabueleiro de jogo e conta quantas posições fechadas existem no tabuleiro (posições com "-")

  #def conta_fechadas(tab) do
  # (...)
  #end

  def conta_fechadas(tab) do
    reduce(tab, 0, fn(linha, acc) ->
      reduce(linha, acc, fn(pos, acc2) ->
        cond do
          pos == "-" -> acc2 + 1
          true -> acc2
        end
      end)
    end)
  end

# -- conta_minas/1: Recebe o tabuleiro de Minas (MBoard) e conta quantas minas existem no jogo

  #def conta_minas(minas) do
  # (...)
  #end

  def conta_minas(minas) do
    reduce(minas, 0, fn(linha, acc) ->
      reduce(linha, acc, fn(pos, acc2) ->
        cond do
          pos == true -> acc2 + 1
          true -> acc2
        end
      end)
    end)
  end

# end_game?/2: recebe o tabuleiro de minas, o tauleiro do jogo, e diz se o jogo acabou.
# O jogo acabou quando o número de casas fechadas é igual ao numero de minas
  #def end_game(minas,tab), do:  ...

  def end_game(minas, tab), do: conta_fechadas(tab) == conta_minas(minas)

#### fim do módulo
end

###################################################################
###################################################################

# A seguir está o motor do jogo!
# Somente descomentar essas linhas quando as funções do módulo anterior estiverem
# todas implementadas

defmodule Motor do
 def main() do
  v = IO.gets("Digite o tamanho do tabuleiro: \n")
  {size,_} = Integer.parse(v)
  minas = gen_mines_board(size)
  IO.inspect minas
  tabuleiro = Minesweeper.gera_tabuleiro(size)
  game_loop(minas,tabuleiro)
 end
 def game_loop(minas,tabuleiro) do
   IO.puts Minesweeper.board_to_string(tabuleiro)
   v = IO.gets("Digite uma linha: \n")
   {linha,_} = Integer.parse(v)
   v = IO.gets("Digite uma coluna: \n")
   {coluna,_} = Integer.parse(v)
   if (Minesweeper.is_mine(minas,linha,coluna)) do
     IO.puts "VOCÊ PERDEU!!!!!!!!!!!!!!!!"
     IO.puts Minesweeper.board_to_string(Minesweeper.abre_tabuleiro(minas,tabuleiro))
     IO.puts "TENTE NOVAMENTE!!!!!!!!!!!!"
   else
     novo_tabuleiro = Minesweeper.abre_jogada(linha,coluna,minas,tabuleiro)
     if (Minesweeper.end_game(minas,novo_tabuleiro)) do
         IO.puts "VOCÊ VENCEU!!!!!!!!!!!!!!"
         IO.puts Minesweeper.board_to_string(Minesweeper.abre_tabuleiro(minas,novo_tabuleiro))
         IO.puts "PARABÉNS!!!!!!!!!!!!!!!!!"
     else
         game_loop(minas,novo_tabuleiro)
     end
   end
 end
 def gen_mines_board(size) do
   add_mines(ceil(size*size*0.15), size, Minesweeper.gera_mapa_de_minas(size))
 end
 def add_mines(0,_size,mines), do: mines
 def add_mines(n,size,mines) do
   linha = :rand.uniform(size-1)
   coluna = :rand.uniform(size-1)
   if Minesweeper.is_mine(mines,linha,coluna) do
     add_mines(n,size,mines)
   else
     add_mines(n-1,size,Minesweeper.update_pos(mines,linha,coluna,true))
   end
 end
end

#Motor.main()
