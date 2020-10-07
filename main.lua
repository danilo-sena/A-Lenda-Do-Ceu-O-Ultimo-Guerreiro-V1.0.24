--====================================================================================================
--Autor: Danilo Henrique Rodrigues De Sena
--Disciplina: TCC II
--Faculdade: Unicesumar
--====================================================================================================
local rich = require 'biblioteca/richtext/richtext'
local socket = require("socket")
require("videolib/videolib")
--====================================================================================================
--///////////////////////////////////////VARIAVEIS LOCAIS/////////////////////////////////////////////
--====================================================================================================
largura_Da_Tela = love.graphics.getWidth()
altura_Da_Tela = love.graphics.getHeight()
local tp = -1

--SISTEMA
local sistema = {
l1,
file,
ler,

--ITENS EQUIPADOS
espada_Curta_Habilitado = true,
espada_Longa_Habilitado = false,
cetro_Curto_Habilitado = true,
cetro_Longo_Habilitado = false,
Arco_De_Luz_Habilitado = true,

--LOJA
pocao_Cura_J = 2,
pocao_Mana_J = 1,

--ATRIBUTOS
dano_Basico_Espada = 2,
dano_Basico_Cetro = 1,
dano_Basico_Arco = 3,

--ATAQUE BASICO SOMA
atk_Guerreiro = 1,
atk_Mago = 1,
atk_Elfa = 1,

--ATAQUE MAGICO MULTIPLICA
atk_Guerreiro_Magia = 1,
atk_Mago_Magia = 1,
atk_Elfa_Magia = 1,

--DEFESA
def_Guerreiro = 0,
def_Mago = 0,
def_Elfa = 0,

--VIDA
vida_Guerreiro = 12,
vida_Mago = 5,
vida_Elfa = 6,

--MANA
mana_Guerreiro = 5,
mana_Mago = 15,
mana_Elfa = 5,

--MANA TOTAL
mana_Guerreiro_Total,
mana_Mago_Total,
mana_Elfa_Total,

--STATUS / SAVE
xp = 0,
dindin = 10,
lvl = 1,

--INIMIGOS
inimigo_Status_lvl = 1,
inimigo_Status_Ataque = 2,
inimigo_Status_Defesa =1,
inimigo_Status_Vida = 5,
inimigo_Status_Xp = 1,
inimigo_Status_Dindin = 1,
inimigo_Status_lvl1 = 1,
inimigo_Status_Ataque1 = 4,
inimigo_Status_Defesa1 = 2,
inimigo_Status_Vida1 = 7,
inimigo_Status_Xp1 = 3,
inimigo_Status_Dindin1 = 3,

-- ATAQUE TOTAL
ataque_Total_Guerreiro, 
ataque_Total_Mago, 
ataque_Total_Elfa,
ataque_Total_Guerreiro_E, 
ataque_Total_Mago_E, 
ataque_Total_Elfa_E, 

--ATAQUE TOTAL MAGIA
ataque_Total_Magia_Guerreiro, 
ataque_Total_Magia_Mago, 
ataque_Total_Magia_Elfa,
ataque_Total_Guerreiro_Print,
ataque_Total_Mago_Print,
ataque_Total_Elfa_Print,
ataque_Total_Magia_Guerreiro_Print,
ataque_Total_Magia_Mago_Print,
ataque_Total_Magia_Elfa_Print,

--DEF TOTAL
def_Guerreiro_Total,
def_Mago_Total,
def_Elfa_Tota,
m_Tp = 0
}

--TELETRANSPORTE
local para_Mapa01 = 0
local para_Mapa02 = 0
local para_Mapa03 = 0

--MODO DE BATALHA
local b_Sist= {
soma_Cont_Modo_Batalha = 0,
cont_Modo_Batalha_Cima = 0,
cont_Modo_Batalha_Baixo = 0,
cont_Modo_Batalha_Esq = 0,
cont_Modo_Batalha_Dir = 0
}

--PORTA
local porta_Obj
local porta_Obj_Recorte
local porta_Aberta = 0

--CRISTAL
local cristal_Obj
local cristal_Obj_Recorte
local quantidade_De_Quadros_Cristal = 5
local tempo_De_Animacao_Cristal = 1 / quantidade_De_Quadros_Cristal
local quadro_Cristal = 1
local num_Quadros_Cristal = 3
local xoffset_Cristal

--GALINHA
local galinha_Char
local galinha_Recorte
local galinha_Char1
local galinha_Recorte1
local galinha_Quantidade_De_Quadros = 5
local galinha_Tempo_De_Animacao = 1 / galinha_Quantidade_De_Quadros
local galinha_Quadro = 1
local galinha_Num_Quadros = 3
local Galinha_Xoffset

--TEXTO
local txt = {
		nome = "",
		a1 = "",
		a2 = "",
		a3 = "",
		a4 = "",
		a5 = "",
		db_Nome = ""
		}

--JOGADOR
local jogador1_Char
local jogador1_Recorte
local quantidade_De_Quadros = 5
local tempo_De_Animacao = 1 / quantidade_De_Quadros
local quadro = 1
local num_Quadros = 2
local xoffset

--GUERREIRO BATALHA
local guerreiro_Batalha
local guerreiro_Batalha_Recorte
local guerreiro_Batalha_Quantidade_De_Quadros = 3
local guerreiro_Batalha_Tempo_De_Animacao = 1 / guerreiro_Batalha_Quantidade_De_Quadros
local guerreiro_Batalha_Quadro = 1
local guerreiro_Batalha_Num_Quadros = 2
local guerreiro_Batalha_Xoffset

--MAGO BATALHA
local mago_Batalha
local mago_Batalha_Recorte
local mago_Batalha_Quantidade_De_Quadros = 3
local mago_Batalha_Tempo_De_Animacao = 1 / mago_Batalha_Quantidade_De_Quadros
local mago_Batalha_Quadro = 1
local mago_Batalha_Num_Quadros = 2
local mago_Batalha_Xoffset

--ELFA BATALHA
local elfa_Batalha
local elfa_Batalha_Recorte
local elfa_Batalha_Quantidade_De_Quadros = 3
local elfa_Batalha_Tempo_De_Animacao = 1 / elfa_Batalha_Quantidade_De_Quadros
local elfa_Batalha_Quadro = 1
local elfa_Batalha_Num_Quadros = 2
local elfa_Batalha_Xoffset

-- FX
local fx
local fx_Recorte
local fx_Quantidade_De_Quadros = 10
local fx_Tempo_De_Animacao = 1 / fx_Quantidade_De_Quadros
local fx_Quadro = 1
local fx_Num_Quadros = 9
local fx_Xoffset

--NPC_LOJA
local npc = {
npc_Loja,
npc_Loja_Recorte,
npc_Loja_Quantidade_De_Quadros = 5,
npc_Loja_Quadro = 1,
npc_Loja_Num_Quadros = 2,
npc_Loja_Xoffset
		}
	
local npc_Loja_Tempo_De_Animacao = 1 / npc.npc_Loja_Quantidade_De_Quadros
local sound
local turno = "nenhum"
--====================================================================================================
--/////////////////////////////////////////////FIM VARIAVEIS LOCAIS///////////////////////////////////
--====================================================================================================

	function love.load()
	
	--cwd=love.filesystem.getWorkingDirectory()
		--VIDEO
		videolib.frames.prefix = "frames/frame-"
		videolib.frames.postfix = ".jpeg"
		videolib.frames.total = 1340
		videolib.frames.fps = 23.98
		videolib.start()
		love.window.setMode(640, 480)
		love.graphics.setDefaultFilter('nearest', 'nearest')
		fundo = love.graphics.newImage("img/menu/menuinicial.png")
		fundoX = 0
		fundoY = 0
		
		--TELA INICIAL/SELECAO LOAD
		selecao = love.graphics.newImage("img/menu/selecaomenuinicial.png")
		selecaoX = 115
		selecaoY = 270
		
		--TEXTO/FONTE LOAD
		fontAlagard = love.graphics.newFont("font/alagard.ttf", 50)
		love.graphics.setFont(fontAlagard)
		txt.nome = ""
		rc = rich:new{"{preto}"..txt.nome,
			preto = {0, 0, 0}
		}
				
		--JOGADOR1 LOAD
		jogador1_Char = love.graphics.newImage("img/mundo/personagens/personagem01.png")
		jogador1_Recorte = love.graphics.newQuad(14, 18, 14, 18, jogador1_Char:getDimensions())
		posicao_Do_Jogador1 = {
		posicaoX = -1000,
		posicaoY = -1000,
		velocidade = 1
		}

		--GALINHA LOAD
		galinha_Char = love.graphics.newImage("img/mundo/animais/galinha.png")
		galinha_Recorte = love.graphics.newQuad(16, 32, 16, 32, galinha_Char:getDimensions())
		posicao_Da_Galinha = {
		posicaoX = -1000,
		posicaoY = -1000,
		velocidade = 1
		}
		
		--GALINHA1 LOAD
		galinha1_Char = love.graphics.newImage("img/mundo/animais/galinha.png")
		galinha1_Recorte = love.graphics.newQuad(16, 64, 16, 32, galinha1_Char:getDimensions())
		posicao_Da_Galinha1 = {
		posicaoX = -1000,
		posicaoY = -1000,
		velocidade = 1
		}
		
		--CRISTAL LOAD
		cristal_Obj = love.graphics.newImage("img/mundo/objetos/cristal.png")
		cristal_Obj_Recorte = love.graphics.newQuad(32, 32, 32, 32, cristal_Obj:getDimensions())
		posicao_Do_Obj_Cristal = {
		posicaoX = -1000,
		posicaoY = -1000,
		velocidade = 1
		}
		
		--PORTA
		porta_Obj = love.graphics.newImage("img/mundo/objetos/porta.png")
		porta_Obj_Recorte = love.graphics.newQuad(0, 0, 28, 32, porta_Obj:getDimensions())
		posicao_Da_porta = {
		posicaoX = -1000,
		posicaoY = -1000,
		velocidade = 1
		}
				
		efeito_selecao = love.audio.newSource("audio/selecao.ogg","stream")
		efeito_selecao:setLooping(false)
				
		--inimigo1_BATALHA
		inimigo1 = love.graphics.newImage("img/batalha/inimigo/inimigo01.png")
		inimigo1X = 100
		inimigo1Y = 150
				
		--inimigo2_BATALHA
		inimigo2 = love.graphics.newImage("img/batalha/inimigo/inimigo02.png")
		inimigo2X = 60
		inimigo2Y = 250
		
		--SETA BATALHA
		seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
		seta_BatalhaX = 560
		seta_BatalhaY = 355
				
		--TELA INICIAL/NOVO JOGO
		novojogo = love.graphics.newImage("img/menu/novojogo.png")
		novojogoX = 1000
		novojogoY = 1000
		
		--TELA INICIAL/SELECAO LOAD
		novojogo_Selecao = love.graphics.newImage("img/menu/selecaomenuinicial.png")
		novojogo_SelecaoX = 1000
		novojogo_SelecaoY = 1000
		
		--MENU
		menu_Lctrl = love.graphics.newImage("img/menu/menu.png")
		menu_LctrlX = 1000
		menu_LcrlY = 1000
		
		--SETA_SELECAO
		seta = love.graphics.newImage("img/menu/seta.png")
		setaX = 1000
		setaY = 1000
				
		--GUERREIRO
		guerreiro_Batalha = love.graphics.newImage("img/batalha/guerreiro/personagem01.png")
		guerreiro_Batalha_Recorte = love.graphics.newQuad(0, 18, 14, 18, guerreiro_Batalha:getDimensions())
		posicao_Do_Guerreiro_Batalha = {
		posicaoX = 500,
		posicaoY = 120,
		velocidade = 1
		}
				
		--MAGO
		mago_Batalha = love.graphics.newImage("img/batalha/mago/personagem02.png")
		mago_Batalha_Recorte = love.graphics.newQuad(0, 18, 14, 18, mago_Batalha:getDimensions())
		posicao_Do_Mago_Batalha = {
		posicaoX = 450,
		posicaoY = 180,
		velocidade = 1
		}
				
		--ELFA
		elfa_Batalha = love.graphics.newImage("img/batalha/elfo/personagem05.png")
		elfa_Batalha_Recorte = love.graphics.newQuad(0, 18, 14, 18, elfa_Batalha:getDimensions())
		posicao_Do_Elfa_Batalha = {
		posicaoX = 400,
		posicaoY = 260,
		velocidade = 1
		}
				
		-- EFEITO ATAQUE
		fx = love.graphics.newImage("img/fx/ataque.png")
		fx_Recorte = love.graphics.newQuad(0, 64, 64, 64, fx:getDimensions())
		posicao_Do_Fx = {
		posicaoX = 100,
		posicaoY = 150,
		velocidade = 1
		}
		
		--NPC_LOJA
		seta_Loja = love.graphics.newImage("img/menu/setaloja.png")
		seta_LojaX = -1000
		seta_LojaY = -1000
		menu_Loja = love.graphics.newImage("img/menu/lojamenu.png")
		menu_LojaX = -1000
		menu_LojaY = -1000
		npc.npc_Loja = love.graphics.newImage("img/mundo/personagens/personagem13.png")
		npc.npc_Loja_Recorte = love.graphics.newQuad(0, 36, 14, 18, npc.npc_Loja:getDimensions())
		posicao_Do_Npc = {
		posicaoX = -1000,
		posicaoY = -1000,
		velocidade = 1
		}
		
		--EVENTO DE TEXTO		
		texto_Evt_01 = love.graphics.newImage("img/texto/texto01.png")
		texto_Evt_01X = -1000
		texto_Evt_01Y = -1000
		sound = love.audio.newSource("audio/titulo.ogg","stream")
		sound:setLooping(true)
		
		--GAME OVER
		fundo_Gameover = love.graphics.newImage("img/menu/gameover.png")
		fundo_GameoverX = -1000
		funco_GameoverY = -1000
		
		
		--VITORIA
		xpX = -1000
		xpY = -1000
		lvlX = -1000
		lvlY = -1000
		dinX = -1000
		dinY = -1000
		--
		magiaTxtL = love.graphics.newImage("img/texto/texto06.png")
		magiaTxtLX = -1000
		magiaTxtLY = -1000
		
		pocao_Cura_JX = -1000
		pocao_Cura_JY = -1000
		pocao_Mana_JX = -1000
		pocao_Mana_JY = -1000
		
		--PULAR VIDEO
		pularvideo = love.graphics.newImage("img/menu/pularvideo.png")
		
		--ATAQUE TOTAL BASICO
		sistema.ataque_Total_Guerreiro_E = sistema.lvl + sistema.dano_Basico_Espada + sistema.atk_Guerreiro
		sistema.ataque_Total_Mago_E = sistema.lvl + sistema.dano_Basico_Cetro + sistema.atk_Mago
		sistema.ataque_Total_Elfa_E = sistema.lvl + sistema.dano_Basico_Arco + sistema.atk_Elfa
		sistema.ataque_Total_Guerreiro = sistema.lvl + sistema.atk_Guerreiro
		sistema.ataque_Total_Mago = sistema.lvl + sistema.atk_Mago
		sistema.ataque_Total_Elfa = sistema.lvl + sistema.atk_Elfa

		--ATAQUE TOTAL MAGIA
		sistema.ataque_Total_Magia_Guerreiro_E = sistema.lvl * (sistema.atk_Guerreiro_Magia + sistema.dano_Basico_Espada)
		sistema.ataque_Total_Magia_Mago_E = sistema.lvl * (sistema.atk_Mago_Magia + sistema.dano_Basico_Cetro)
		sistema.ataque_Total_Magia_Elfa_E = sistema.lvl * (sistema.atk_Elfa_Magia + sistema.dano_Basico_Arco)
		sistema.ataque_Total_Magia_Guerreiro = sistema.lvl * sistema.atk_Guerreiro_Magia
		sistema.ataque_Total_Magia_Mago = sistema.lvl * sistema.atk_Mago_Magia
		sistema.ataque_Total_Magia_Elfa = sistema.lvl * sistema.atk_Elfa_Magia

		-- DEF TOTAL
		sistema.def_Guerreiro_Total = sistema.lvl + sistema.def_Guerreiro
		sistema.def_Mago_Total = sistema.lvl + sistema.def_Mago
		sistema.def_Elfa_Total = sistema.lvl + sistema.def_Elfa

		--PRINT STATUS
		sistema.def_Guerreiro_Total_Print = sistema.def_Guerreiro_Total * sistema.lvl
		sistema.ataque_Total_Magia_Guerreiro_Print = sistema.ataque_Total_Magia_Guerreiro_E
		sistema.ataque_Total_Guerreiro_Print = sistema.ataque_Total_Guerreiro
		sistema.def_Mago_Total_Print = sistema.def_Mago_Total * sistema.lvl
		sistema.ataque_Total_Magia_Mago_Print = sistema.ataque_Total_Magia_Mago_E
		sistema.ataque_Total_Mago_Print = sistema.ataque_Total_Mago
		sistema.def_Elfa_Total_Print = sistema.def_Elfa_Total * sistema.lvl
		sistema.ataque_Total_Magia_Elfa_Print = sistema.ataque_Total_Magia_Elfa_E
		sistema.ataque_Total_Elfa_Print = sistema.ataque_Total_Elfa
		eeeG = "E"
		eeeM = "E"
		eeeE = "E"
		sistema.ataque_Total_Guerreiro_Print = sistema.ataque_Total_Guerreiro_E
		sistema.ataque_Total_Magia_Guerreiro_Print = sistema.ataque_Total_Magia_Guerreiro_E
		sistema.ataque_Total_Mago_Print = sistema.ataque_Total_Mago_E
		sistema.ataque_Total_Magia_Mago_Print = sistema.ataque_Total_Magia_Mago_E
		sistema.ataque_Total_Elfa_Print = sistema.ataque_Total_Elfa_E
		sistema.ataque_Total_Magia_Elfa_Print = sistema.ataque_Total_Magia_Elfa_E
		fundo_Itens = love.graphics.newImage("img/batalha/fundo/menuitem.png")
		fundo_ItensX = -1000
		fundo_ItensY = -1000

		--MANA CALCULO
		mana_Guerreiro_Total = sistema.mana_Guerreiro * sistema.lvl
		mana_Mago_Total = sistema.mana_Mago * sistema.lvl
		mana_Elfa_Total = sistema.mana_Elfa * sistema.lvl

		-- VIDA CALCULO
		vida_Total_Do_Gurreiro = sistema.vida_Guerreiro * sistema.lvl
		vida_Total_Do_Mago = sistema.vida_Mago * sistema.lvl
		vida_Total_Da_Elfa = sistema.vida_Elfa * sistema.lvl
		vida_Total_Do_Inimigo = sistema.inimigo_Status_Vida * sistema.lvl
		vida_Total_Do_Inimigo1 = sistema.inimigo_Status_Vida1 * sistema.lvl
		sound_Negado = love.audio.newSource("audio/menunegado.ogg","stream")
		sound_Negado:setLooping(false)
		sound_Cura = love.audio.newSource("audio/cura.ogg","stream")
		sound_Cura:setLooping(false)
		magiaTxt=love.graphics.newImage("img/texto/texto06.png")
		magiaTxtX = -1000
		magiaTxtY = -1000
		
		inimigoTxt1=love.graphics.newImage("img/texto/texto07.png")
		inimigoTxt1X = -1000
		inimigoTxt1Y = -1000
		
		inimigoTxt2=love.graphics.newImage("img/texto/texto07.png")
		inimigoTxt2X = -1000
		inimigoTxt2Y = -1000
		
		
	end

		function love.update(dt)
			function love.keypressed (tecla)
				if videolib.frame < 1340 then			
					if tecla == "escape" then
						videolib.frame = 1340
	sound:stop()
		end
		end
	end
	

	if videolib.frame == 1340 then
		tp = 0
		sound:stop()	
	end
	
videolib.update(dt)
--GALINHA ANIMACAO



	if dt > 0.035 then
		return
	end
	galinha_Tempo_De_Animacao= galinha_Tempo_De_Animacao - dt
	if galinha_Tempo_De_Animacao <= 0 then
		galinha_Tempo_De_Animacao = 1 / galinha_Quantidade_De_Quadros
		galinha_Quadro = galinha_Quadro + 1
		if galinha_Quadro > galinha_Num_Quadros then
			galinha_Quadro = 1
		end
		galinha_Xoffset = 16 * galinha_Quadro
		galinha_Recorte:setViewport(galinha_Xoffset, 32, 16, 32)
	end




--CRISTAL ANIMAÇÃO
	if dt > 0.035 then
		return
	end
	tempo_De_Animacao_Cristal = tempo_De_Animacao_Cristal - dt
	if tempo_De_Animacao_Cristal <= 0 then
		tempo_De_Animacao_Cristal = 1 / quantidade_De_Quadros_Cristal
		quadro_Cristal = quadro_Cristal + 1
		if quadro_Cristal > num_Quadros_Cristal then
			quadro_Cristal = 1
		end
		xoffset_Cristal = 32 * quadro_Cristal
		cristal_Obj_Recorte:setViewport(xoffset_Cristal, 0, 32, 32)
	end



if tp == 0 then
	function love.keypressed(tecla)
		
		if tecla == "right" then
			if selecaoX == 115 and selecaoY == 270 then
				selecaoX = selecaoX + 155
				efeito_selecao:play()
			elseif selecaoX == 270 and selecaoY == 270 then
				selecaoX = selecaoX + 155
				efeito_selecao:play()
			
			end
		end
		
		if tecla == "left" then
			if selecaoX == 425 and selecaoY == 270 then
				selecaoX = selecaoX - 155
				efeito_selecao:play()
			elseif selecaoX == 270 and selecaoY == 270 then
				selecaoX = selecaoX - 155
				efeito_selecao:play()
					
			end		
		end

		if tecla == "space" then
			if selecaoX == 115 and selecaoY == 270 then
			
			efeito_selecao:play()
			
			arquivo_Save = "save.txt"
			
				if not love.filesystem.exists(arquivo_Save) == false then
					novojogoX = 0
					novojogoY = 0
					novojogo_SelecaoX = 160
					novojogo_SelecaoY = 290
					tp = 98
					
				else
				
				
			fundo = love.graphics.newImage("img/menu/teladenome.png")
			selecaoX = -435
			selecaoY = -355
			tp = 1
			efeito_selecao:play()
			
			end
			
			
			elseif selecaoX == 270 and selecaoY == 270 then
			
			arquivo_Save = "save.txt"
				if not love.filesystem.exists(arquivo_Save) == false then
				
				--CONTINUE

				  local linha = {}
					for line in love.filesystem.lines(arquivo_Save) do
					table.insert(linha, line)
					end
 
				txt.nome = linha[1]
				sistema.xp = tonumber(linha[2])
				sistema.dindin = tonumber(linha[3])
				sistema.lvl = tonumber(linha[4])
				sistema.pocao_Cura_J = tonumber(linha[5])
				sistema.pocao_Mana_J = tonumber(linha[6])
				
						
					sound:stop()
		sound = love.audio.newSource("audio/aventura.ogg","stream")
		sound:setLooping(true)
		sound:play()

		fundo = love.graphics.newImage("img/mundo/mapa/mapa01.png")
		jogador1_Char = love.graphics.newImage("img/mundo/personagens/personagem01.png")
		jogador1_Recorte = love.graphics.newQuad(14, 18, 14, 18, jogador1_Char:getDimensions())

		posicao_Do_Jogador1 = {
		posicaoX = largura_Da_Tela / 2,
		posicaoY = altura_Da_Tela / 2,
		velocidade = 1
		}

		galinha_Char = love.graphics.newImage("img/mundo/animais/galinha.png")
		galinha_Recorte = love.graphics.newQuad(16, 32, 16, 32, galinha_Char:getDimensions())
		posicao_Da_Galinha = {
		posicaoX = 500,
		posicaoY = 350,
		velocidade = 1
		}
	
		cristal_Obj = love.graphics.newImage("img/mundo/objetos/cristal.png")
		cristal_Obj_Recorte = love.graphics.newQuad(16, 32, 16, 32, cristal_Obj:getDimensions())
		posicao_Do_Obj_Cristal = {
		posicaoX = 250,
		posicaoY = 140,
		velocidade = 1
		}

		porta_Obj = love.graphics.newImage("img/mundo/objetos/porta.png")
		porta_Obj_Recorte = love.graphics.newQuad(0, 0, 28, 32, porta_Obj:getDimensions())
		posicao_Da_porta = {
		posicaoX = 430,
		posicaoY = 197,
		velocidade = 1
		}


		txt.db_Nome = txt.nome
		txt.nome = ""
		fontAlagard = love.graphics.newFont("font/alagard.ttf", 20)
		love.graphics.setFont(fontAlagard)
		rc = rich:new{"{branco}"..txt.db_Nome,
			branco = {255, 255, 255}
		}


		tp = 2
		
		texto_Evt_01 = love.graphics.newImage("img/texto/texto05.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
					
				else
				
				sound_Negado:play()
				
				
				end
		
		 	
			elseif selecaoX == 425 and selecaoY == 270 then
			efeito_selecao:play()
			love.event.quit()
			end
		end	
	end	

end



if tp == 98 then

	function love.keypressed (tecla3)
	--if tecla3 == "escape" then
		--love.event.quit()
	--end

	if tecla3 == "right" then
		if novojogo_SelecaoX == 160 and novojogo_SelecaoY == 290 then
			novojogo_SelecaoX = novojogo_SelecaoX + 210	
			efeito_selecao:play()
		end
	end
	
	if tecla3 == "left" then
				
		if novojogo_SelecaoX == 370 and novojogo_SelecaoY == 290 then
			novojogo_SelecaoX = novojogo_SelecaoX - 210
			efeito_selecao:play()
		end
	end
	
	if tecla3 == "space" then
		if novojogo_SelecaoX == 160 and novojogo_SelecaoY == 290 then
			love.filesystem.remove("save.txt")
							
		novojogoX = -1000
		novojogoY = -1000
		novojogo_SelecaoX = -1000
		novojogo_SelecaoY = -1000
		tp = 1
		fundo = love.graphics.newImage("img/menu/teladenome.png")
		selecaoX = -435
		selecaoY = -355
		efeito_selecao:play()
				
		elseif novojogo_SelecaoX == 370 and novojogo_SelecaoY == 290 then
					novojogo_SelecaoX = 1000
					novojogo_SelecaoY = 1000
					novojogoX =  1000
					novojogoY = 1000
					
					
		fundo = love.graphics.newImage("img/menu/menuinicial.png")
		selecaoX = 115
		selecaoY = 270
		tp = 0
		efeito_selecao:play()
		end
		
	
		
	end	
		
		
		

			
			
		
		
		end
		

		
		
			
			
			
			
			
		
	
end





if tp == 1 then

	function love.keypressed( tecla )
		if tecla == "a" or tecla == "b" or tecla == "c" or tecla == "d"
		or tecla == "e" or tecla == "f" or tecla == "g" or tecla == "h"
		or tecla == "i" or tecla == "j" or tecla == "l" or tecla == "m"
		or tecla == "n" or tecla == "o" or tecla == "p" or tecla == "q"
		or tecla == "r" or tecla == "s" or tecla == "t" or tecla == "u"
		or tecla == "v" or tecla == "w" or tecla == "x" or tecla == "y"
		or tecla == "z" or tecla == "k" then


									if txt.a1 == "" then
										txt.a1 = tecla
									else
										if txt.a2 == "" then
											txt.a2 = tecla
										else
											if txt.a3 == "" then
												txt.a3 = tecla
											else
												if txt.a4 == "" then
													txt.a4 = tecla
												else
													if txt.a5 == "" then
														txt.a5 = tecla

												end
											end
										end
									end
						end
					end
	end
								if love.keyboard.isDown("backspace") then
									txt.a1 = ""
									txt.a2 = ""
									txt.a3 = ""
									txt.a4 = ""
									txt.a5 = ""
									txt.nome = ""
								end
									txt.nome = txt.a1..txt.a2..txt.a3..txt.a4..txt.a5
									rc = rich:new{"{preto}"..txt.nome,
									preto = {0, 0, 0}
									}



	if txt.nome ~= "" then
		if love.keyboard.isDown("space") then
		
	
		
		sound:stop()
		sound = love.audio.newSource("audio/aventura.ogg","stream")
		sound:setLooping(true)
		sound:play()

		fundo = love.graphics.newImage("img/mundo/mapa/mapa01.png")
		jogador1_Char = love.graphics.newImage("img/mundo/personagens/personagem01.png")
		jogador1_Recorte = love.graphics.newQuad(14, 18, 14, 18, jogador1_Char:getDimensions())

		posicao_Do_Jogador1 = {
		posicaoX = largura_Da_Tela / 2,
		posicaoY = altura_Da_Tela / 2,
		velocidade = 1
		}

		galinha_Char = love.graphics.newImage("img/mundo/animais/galinha.png")
		galinha_Recorte = love.graphics.newQuad(16, 32, 16, 32, galinha_Char:getDimensions())
		posicao_Da_Galinha = {
		posicaoX = 500,
		posicaoY = 350,
		velocidade = 1
		}
	
		cristal_Obj = love.graphics.newImage("img/mundo/objetos/cristal.png")
		cristal_Obj_Recorte = love.graphics.newQuad(16, 32, 16, 32, cristal_Obj:getDimensions())
		posicao_Do_Obj_Cristal = {
		posicaoX = 250,
		posicaoY = 140,
		velocidade = 1
		}

		porta_Obj = love.graphics.newImage("img/mundo/objetos/porta.png")
		porta_Obj_Recorte = love.graphics.newQuad(0, 0, 28, 32, porta_Obj:getDimensions())
		posicao_Da_porta = {
		posicaoX = 430,
		posicaoY = 197,
		velocidade = 1
		}


		txt.db_Nome = txt.nome
		txt.nome = ""
		fontAlagard = love.graphics.newFont("font/alagard.ttf", 20)
		love.graphics.setFont(fontAlagard)
		rc = rich:new{"{branco}"..txt.db_Nome,
			branco = {255, 255, 255}
		}


		tp = 2
		
		texto_Evt_01 = love.graphics.newImage("img/texto/texto05.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
		end

	end
end



	if tp == 2 then
	
	
	
	
	function love.keypressed(key)
		if key == "space" then	
			--GALINHA TXT
			if posicao_Do_Jogador1.posicaoY >= 350 and posicao_Do_Jogador1.posicaoX >= 469 and
				posicao_Do_Jogador1.posicaoY <= 380 and posicao_Do_Jogador1.posicaoX <= 471 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto03.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
			--GALINHA TXT
			elseif posicao_Do_Jogador1.posicaoY >= 386 and posicao_Do_Jogador1.posicaoX >= 470 and
				posicao_Do_Jogador1.posicaoY <= 388 and posicao_Do_Jogador1.posicaoX <= 519 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto03.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
			--GALINHA TXT
			elseif posicao_Do_Jogador1.posicaoY >= 339 and posicao_Do_Jogador1.posicaoX >= 470 and
				posicao_Do_Jogador1.posicaoY <= 341 and posicao_Do_Jogador1.posicaoX <= 510 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto03.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
				
							
			--CRISTAL TXT
			elseif posicao_Do_Jogador1.posicaoY >= 103 and posicao_Do_Jogador1.posicaoX >= 231 and
				posicao_Do_Jogador1.posicaoY <= 154 and posicao_Do_Jogador1.posicaoX <= 233 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto04.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
				
				--save
				f = love.filesystem.newFile("save.txt")
				f:open("w")
				f:write(txt.db_Nome.."\r\n")
				f:write(sistema.xp.."\r\n")
				f:write(sistema.dindin.."\r\n")
				f:write(sistema.lvl.."\r\n")
				f:write(sistema.pocao_Cura_J.."\r\n")
				f:write(sistema.pocao_Mana_J.."\r\n")
				f:close()
				
			--CRISTAL TXT
			elseif posicao_Do_Jogador1.posicaoY >= 105 and posicao_Do_Jogador1.posicaoX >= 264 and
				posicao_Do_Jogador1.posicaoY <= 155 and posicao_Do_Jogador1.posicaoX <= 265 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto04.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
				
				--save
				f = love.filesystem.newFile("save.txt")
				f:open("w")
				f:write(txt.db_Nome.."\r\n")
				f:write(sistema.xp.."\r\n")
				f:write(sistema.dindin.."\r\n")
				f:write(sistema.lvl.."\r\n")
				f:write(sistema.pocao_Cura_J.."\r\n")
				f:write(sistema.pocao_Mana_J.."\r\n")
				f:close()
				
				
			
				
			--CRISTAL TXT
			elseif posicao_Do_Jogador1.posicaoY >= 150 and posicao_Do_Jogador1.posicaoX >= 228 and
				posicao_Do_Jogador1.posicaoY <= 155 and posicao_Do_Jogador1.posicaoX <= 275 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto04.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
				
				--save
				f = love.filesystem.newFile("save.txt")
				f:open("w")
				f:write(txt.db_Nome.."\r\n")
				f:write(sistema.xp.."\r\n")
				f:write(sistema.dindin.."\r\n")
				f:write(sistema.lvl.."\r\n")
				f:write(sistema.pocao_Cura_J.."\r\n")
				f:write(sistema.pocao_Mana_J.."\r\n")
				f:close()
				
				

			--CRISTAL TXT
			elseif posicao_Do_Jogador1.posicaoY >= 103 and posicao_Do_Jogador1.posicaoX >= 228 and
				posicao_Do_Jogador1.posicaoY <= 107 and posicao_Do_Jogador1.posicaoX <= 275 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto04.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 8
				
				--save
				f = love.filesystem.newFile("save.txt")
				f:open("w")
				f:write(txt.db_Nome.."\r\n")
				f:write(sistema.xp.."\r\n")
				f:write(sistema.dindin.."\r\n")
				f:write(sistema.lvl.."\r\n")
				f:write(sistema.pocao_Cura_J.."\r\n")
				f:write(sistema.pocao_Mana_J.."\r\n")
				f:close()
				
				
			end
		end	
	end

	
	
	
	
	
	
		if love.keyboard.isDown("right") then
			--casa colisão
			if posicao_Do_Jogador1.posicaoY >= 80 and posicao_Do_Jogador1.posicaoX >= 330 and
				posicao_Do_Jogador1.posicaoY <= 216 and posicao_Do_Jogador1.posicaoX <= 331 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--ÁRVORE COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 236 and posicao_Do_Jogador1.posicaoX >= 490 and
				posicao_Do_Jogador1.posicaoY <= 312 and posicao_Do_Jogador1.posicaoX <= 495 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--GALINHA BAIXO COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 340 and posicao_Do_Jogador1.posicaoX >= 470 and
				posicao_Do_Jogador1.posicaoY <= 390 and posicao_Do_Jogador1.posicaoX <= 473 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--TRONCO BAIXO COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 320 and posicao_Do_Jogador1.posicaoX >= 234 and
				posicao_Do_Jogador1.posicaoY <= 352 and posicao_Do_Jogador1.posicaoX <= 235 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--PEDRA ESQUERDA COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 230 and posicao_Do_Jogador1.posicaoX >= 135 and
				posicao_Do_Jogador1.posicaoY <= 254 and posicao_Do_Jogador1.posicaoX <= 137 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--CRISTAL COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 103 and posicao_Do_Jogador1.posicaoX >= 231 and
				posicao_Do_Jogador1.posicaoY <= 154 and posicao_Do_Jogador1.posicaoX <= 233 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--LIMITADOR BAIXO MEIO COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 380 and posicao_Do_Jogador1.posicaoX >= 230 and
				posicao_Do_Jogador1.posicaoY <= 480 and posicao_Do_Jogador1.posicaoX <= 235 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--LIMITADOR BAIXO ESQUERDA COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 386 and posicao_Do_Jogador1.posicaoX >= 519 and
				posicao_Do_Jogador1.posicaoY <= 480 and posicao_Do_Jogador1.posicaoX <= 520 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--LIMITADOR BAIXO ESQUERDA COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= -50 and posicao_Do_Jogador1.posicaoX >= 579 and
				posicao_Do_Jogador1.posicaoY <= 500 and posicao_Do_Jogador1.posicaoX <= 580 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			elseif posicao_Do_Jogador1.posicaoY >= 216 and posicao_Do_Jogador1.posicaoX >= 410 and
				posicao_Do_Jogador1.posicaoY <= 218 and posicao_Do_Jogador1.posicaoX <= 440 then
				porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
				porta_sound:setLooping(false)
				porta_sound:play()
				fundo = love.graphics.newImage("img/mundo/mapa/mapa02.png")
				tp = 3
				posicao_Do_Jogador1.posicaoX = 430
				posicao_Do_Jogador1.posicaoY = 200
		else
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX +
			posicao_Do_Jogador1.velocidade + dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 18, 16, 18)
						end
		end
	else
		if love.keyboard.isDown("left") then
			--ÁRVORE LIMITADOR ESQUERDA CIMA
			if posicao_Do_Jogador1.posicaoY >= 97 and posicao_Do_Jogador1.posicaoX >= 3 and
				posicao_Do_Jogador1.posicaoY <= 155 and posicao_Do_Jogador1.posicaoX <= 8 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--ÁRVORE LIMITADOR ESQUERDA MEIO	
			elseif posicao_Do_Jogador1.posicaoY >= 135 and posicao_Do_Jogador1.posicaoX >= 21 and
				posicao_Do_Jogador1.posicaoY <= 280 and posicao_Do_Jogador1.posicaoX <= 25 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--ÁRVORE LIMITADOR ESQUERDA BAIXO	
			elseif posicao_Do_Jogador1.posicaoY >= 275 and posicao_Do_Jogador1.posicaoX >= 53 and
				posicao_Do_Jogador1.posicaoY <= 358 and posicao_Do_Jogador1.posicaoX <= 58 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--ÁRVORE LIMITADOR ESQUERDA BAIXO FINAL
			elseif posicao_Do_Jogador1.posicaoY >= 320 and posicao_Do_Jogador1.posicaoX >= 38 and
				posicao_Do_Jogador1.posicaoY <= 480 and posicao_Do_Jogador1.posicaoX <= 40 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--ÁRVORE DIREITA
			elseif posicao_Do_Jogador1.posicaoY >= 142 and posicao_Do_Jogador1.posicaoX >= 164 and
				posicao_Do_Jogador1.posicaoY <= 184 and posicao_Do_Jogador1.posicaoX <= 168 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--PEDRA COLISÃO
			elseif posicao_Do_Jogador1.posicaoY >= 230 and posicao_Do_Jogador1.posicaoX >= 174 and
				posicao_Do_Jogador1.posicaoY <= 254 and posicao_Do_Jogador1.posicaoX <= 175 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--ÁRVORE LIMITADOR BAIXO	
			elseif posicao_Do_Jogador1.posicaoY >= 410 and posicao_Do_Jogador1.posicaoX >= 149 and
				posicao_Do_Jogador1.posicaoY <= 480 and posicao_Do_Jogador1.posicaoX <= 150 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			-- TRONCO COLISÃO	
			elseif posicao_Do_Jogador1.posicaoY >= 320 and posicao_Do_Jogador1.posicaoX >= 275 and
				posicao_Do_Jogador1.posicaoY <= 352 and posicao_Do_Jogador1.posicaoX <= 276 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			-- CRISTAL COLISÃO	
			elseif posicao_Do_Jogador1.posicaoY >= 105 and posicao_Do_Jogador1.posicaoX >= 264 and
				posicao_Do_Jogador1.posicaoY <= 155 and posicao_Do_Jogador1.posicaoX <= 265 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--PARA CASA - PORTA INTERAÇÃO
			elseif posicao_Do_Jogador1.posicaoY >= 216 and posicao_Do_Jogador1.posicaoX >= 410 and
				posicao_Do_Jogador1.posicaoY <= 218 and posicao_Do_Jogador1.posicaoX <= 440 then
				porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
				porta_sound:setLooping(false)
				porta_sound:play()
				fundo = love.graphics.newImage("img/mundo/mapa/mapa02.png")
				tp = 3
				posicao_Do_Jogador1.posicaoX = 430
				posicao_Do_Jogador1.posicaoY = 200
		else
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX -
			posicao_Do_Jogador1.velocidade - dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 54, 16, 18)
						end
		end
	else
		if love.keyboard.isDown("up") then
			--PARA CASA - PORTA INTERAÇÃO
			if posicao_Do_Jogador1.posicaoY >= 216 and posicao_Do_Jogador1.posicaoX >= 410 and
				posicao_Do_Jogador1.posicaoY <= 218 and posicao_Do_Jogador1.posicaoX <= 440 then
				
				porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
				porta_sound:setLooping(false)
				porta_sound:play()
			
				fundo = love.graphics.newImage("img/mundo/mapa/mapa02.png")
				tp = 3
				posicao_Do_Jogador1.posicaoX = 430
				posicao_Do_Jogador1.posicaoY = 200
			end
				--ÁRVORE COLISÃO
				if posicao_Do_Jogador1.posicaoY >= 310 and posicao_Do_Jogador1.posicaoX >= 480 and
					posicao_Do_Jogador1.posicaoY <= 315 and posicao_Do_Jogador1.posicaoX <= 564 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--GALINHA BAIXO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 383 and posicao_Do_Jogador1.posicaoX >= 470 and
					posicao_Do_Jogador1.posicaoY <= 388 and posicao_Do_Jogador1.posicaoX <= 537 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--TRONCO BAIXO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 348 and posicao_Do_Jogador1.posicaoX >= 230 and
					posicao_Do_Jogador1.posicaoY <= 353 and posicao_Do_Jogador1.posicaoX <= 280 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--PEDRA ESQUERDA COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 250 and posicao_Do_Jogador1.posicaoX >= 133 and
					posicao_Do_Jogador1.posicaoY <= 255 and posicao_Do_Jogador1.posicaoX <= 177 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--CASA COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 212 and posicao_Do_Jogador1.posicaoX >= 330 and
					posicao_Do_Jogador1.posicaoY <= 217 and posicao_Do_Jogador1.posicaoX <= 640  then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--PAREDÃO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 93 and posicao_Do_Jogador1.posicaoX >= -50 and
					posicao_Do_Jogador1.posicaoY <= 98 and posicao_Do_Jogador1.posicaoX <= 640 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--CRISTAL COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 150 and posicao_Do_Jogador1.posicaoX >= 228 and
					posicao_Do_Jogador1.posicaoY <= 155 and posicao_Do_Jogador1.posicaoX <= 275 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 347 and posicao_Do_Jogador1.posicaoX >= 38 and
					posicao_Do_Jogador1.posicaoY <= 350 and posicao_Do_Jogador1.posicaoX <= 56 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				else
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY -
				posicao_Do_Jogador1.velocidade - dt
					if dt > 0.035 then
						return
					end
						tempo_De_Animacao = tempo_De_Animacao - dt
							if tempo_De_Animacao <= 0 then
								tempo_De_Animacao = 1 / quantidade_De_Quadros
								quadro = quadro + 1
									if quadro > num_Quadros then
										quadro = 1
									end
										xoffset = 16 * quadro
										jogador1_Recorte:setViewport(xoffset, 0, 16, 18)
				end
							end
							

		else
			if love.keyboard.isDown("down") then
			-- PARA MAPA 03 tp4	
				if para_Mapa03 == 0 then
					if posicao_Do_Jogador1.posicaoY >= 440 and posicao_Do_Jogador1.posicaoX >= 148 and
						posicao_Do_Jogador1.posicaoY <= 441 and posicao_Do_Jogador1.posicaoX <= 231 then
						fundo = love.graphics.newImage("img/mundo/mapa/mapa03.png")
						tp = 4
						posicao_Do_Jogador1.posicaoX = 190
						posicao_Do_Jogador1.posicaoY = 20
					end	
				end
					--ÁRVORE COLISÃO
					if posicao_Do_Jogador1.posicaoY >= 238 and posicao_Do_Jogador1.posicaoX >= 480 and
						posicao_Do_Jogador1.posicaoY <= 241 and posicao_Do_Jogador1.posicaoX <= 564 then
						posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
					--GALINHA BAIXO COLISÃO
					elseif posicao_Do_Jogador1.posicaoY >= 340 and posicao_Do_Jogador1.posicaoX >= 470 and
						posicao_Do_Jogador1.posicaoY <= 345 and posicao_Do_Jogador1.posicaoX <= 590 then
						posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
					--TRONCO BAIXO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 320 and posicao_Do_Jogador1.posicaoX >= 230 and
					posicao_Do_Jogador1.posicaoY <= 325 and posicao_Do_Jogador1.posicaoX <= 280 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--PEDRA ESQUERDA COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 230 and posicao_Do_Jogador1.posicaoX >= 133 and
					posicao_Do_Jogador1.posicaoY <= 235 and posicao_Do_Jogador1.posicaoX <= 177 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--CRISTAL COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 103 and posicao_Do_Jogador1.posicaoX >= 228 and
					posicao_Do_Jogador1.posicaoY <= 107 and posicao_Do_Jogador1.posicaoX <= 275 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--LIMITADOR BAIXO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 440 and posicao_Do_Jogador1.posicaoX >= -50 and
					posicao_Do_Jogador1.posicaoY <= 445 and posicao_Do_Jogador1.posicaoX <= 640 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--LIMITADOR ÁRVORES ESQUERDA BAIXO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 410 and posicao_Do_Jogador1.posicaoX >= 6 and
					posicao_Do_Jogador1.posicaoY <= 415 and posicao_Do_Jogador1.posicaoX <= 140 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--LIMITADOR ÁRVORES MEIO BAIXO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 380 and posicao_Do_Jogador1.posicaoX >= 224 and
					posicao_Do_Jogador1.posicaoY <= 485 and posicao_Do_Jogador1.posicaoX <= 373 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--LIMITADOR ÁRVORES DIREITA BAIXO COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 415 and posicao_Do_Jogador1.posicaoX >= 345 and
					posicao_Do_Jogador1.posicaoY <= 420 and posicao_Do_Jogador1.posicaoX <= 545 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--LIMITADOR ÁRVORES ESQUERDA UNICA
				elseif posicao_Do_Jogador1.posicaoY >= 137 and posicao_Do_Jogador1.posicaoX >= 7 and
					posicao_Do_Jogador1.posicaoY <= 140 and posicao_Do_Jogador1.posicaoX <= 20 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--LIMITADOR ÁRVORES ESQUERDA UNICA MEIO
				elseif posicao_Do_Jogador1.posicaoY >= 260 and posicao_Do_Jogador1.posicaoX >= 24 and
					posicao_Do_Jogador1.posicaoY <= 265 and posicao_Do_Jogador1.posicaoX <= 60 then
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				else
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY +
					posicao_Do_Jogador1.velocidade + dt
						if dt > 0.035 then
							return
						end
							tempo_De_Animacao = tempo_De_Animacao - dt
								if tempo_De_Animacao <= 0 then
									tempo_De_Animacao = 1 / quantidade_De_Quadros
									quadro = quadro + 1
										if quadro > num_Quadros then
										quadro = 1
										end
											xoffset = 16 * quadro
											jogador1_Recorte:setViewport(xoffset, 36, 16, 18)
								end
				end
			end
		end
	end
end




--MENU TP 2
if love.keyboard.isDown("lctrl") then

ataque_Total_Magia_Guerreiro_Print = sistema.ataque_Total_Magia_Guerreiro
menu_Lctrl = love.graphics.newImage("img/menu/menu.png")
		menu_LctrlX = 0
		menu_LcrlY = 0
		
		
seta_Loja = love.graphics.newImage("img/menu/setaloja.png")
	seta_LojaX = 30
	seta_LojaY = 70
tp = 100

end

end


--MENU SAIR TP 2
if tp == 100 then




function love.keypressed (tecla)
-- TECLA VOLTAR MENU
if tecla == "x" then
	
	if seta_LojaX == 30 and seta_LojaY == 70 or 
	seta_LojaX == 30 and seta_LojaY == 150 or 
	seta_LojaX == 30 and seta_LojaY == 230 then


menu_Lctrl = love.graphics.newImage("img/menu/menu.png")
		menu_LctrlX = 1000
		menu_LcrlY = 1000
		
		
seta_Loja = love.graphics.newImage("img/menu/setaloja.png")
	seta_LojaX = 1000
	seta_LojaY = 1000
tp = 2

	elseif seta_LojaX == 20 and seta_LojaY == 370 then
	seta_LojaX = 30
	seta_LojaY = 70
	elseif seta_LojaX == 240 and seta_LojaY == 370 then
	seta_LojaX = 30
	seta_LojaY = 150
	elseif seta_LojaX == 450 and seta_LojaY == 370 then
	seta_LojaX = 30
	seta_LojaY = 230
	
	end
end


-- TECLAS MENU
if tecla == "down" then
	if seta_LojaX == 30 and seta_LojaY == 70 then
	
	seta_LojaY = seta_LojaY + 80
	
	elseif seta_LojaX == 30 and seta_LojaY == 150 then
	
	seta_LojaY = seta_LojaY + 80
	
	end
	
	

elseif tecla == "up" then
		if seta_LojaX == 30 and seta_LojaY == 230 then
	
	seta_LojaY = seta_LojaY - 80
	
	elseif seta_LojaX == 30 and seta_LojaY == 150 then
	
	seta_LojaY = seta_LojaY - 80
	
	end
elseif tecla == "space" then
	if seta_LojaX == 30 and seta_LojaY == 70 then
	
	seta_LojaX = 20
	seta_LojaY = 370
	elseif seta_LojaX == 30 and seta_LojaY == 150 then
	seta_LojaX = 240
	seta_LojaY = 370
	
	
	elseif seta_LojaX == 30 and seta_LojaY == 230 then
	seta_LojaX = 450
	seta_LojaY = 370
	
	end
	--GURREIRO EQUIPO
	if seta_LojaX == 20 and seta_LojaY == 370 then
	if sistema.espada_Curta_Habilitado == true then
	sistema.ataque_Total_Guerreiro_Print = sistema.ataque_Total_Guerreiro
	sistema.ataque_Total_Magia_Guerreiro_Print = sistema.ataque_Total_Magia_Guerreiro
	eeeG = ""
	sistema.espada_Curta_Habilitado = false
	elseif sistema.espada_Curta_Habilitado == false then
	sistema.ataque_Total_Guerreiro_Print = sistema.ataque_Total_Guerreiro_E
	sistema.ataque_Total_Magia_Guerreiro_Print = sistema.ataque_Total_Magia_Guerreiro_E
	eeeG = "E"
	sistema.espada_Curta_Habilitado = true
	end
	

	
	
	
	--MAGO EQUIPO
	elseif seta_LojaX == 240 and seta_LojaY == 370 then
	if sistema.cetro_Curto_Habilitado == true then
	sistema.ataque_Total_Mago_Print = sistema.ataque_Total_Mago
	sistema.ataque_Total_Magia_Mago_Print = sistema.ataque_Total_Magia_Mago
	eeeM = ""
	sistema.cetro_Curto_Habilitado = false
	elseif sistema.cetro_Curto_Habilitado == false then
	sistema.ataque_Total_Mago_Print = sistema.ataque_Total_Mago_E
	sistema.ataque_Total_Magia_Mago_Print = sistema.ataque_Total_Magia_Mago_E
	eeeM = "E"
	sistema.cetro_Curto_Habilitado = true
	end
	
	
	
	--ELFA EQUIPO
	elseif seta_LojaX == 450 and seta_LojaY == 370 then
		if sistema.Arco_De_Luz_Habilitado == true then
	sistema.ataque_Total_Elfa_Print = sistema.ataque_Total_Elfa
	sistema.ataque_Total_Magia_Elfa_Print = sistema.ataque_Total_Magia_Elfa
	eeeE = ""
	sistema.Arco_De_Luz_Habilitado = false
	elseif sistema.Arco_De_Luz_Habilitado == false then
	sistema.ataque_Total_Elfa_Print = sistema.ataque_Total_Elfa_E
	sistema.ataque_Total_Magia_Elfa_Print = sistema.ataque_Total_Magia_Elfa_E
	eeeE = "E"
	sistema.Arco_De_Luz_Habilitado = true
	end

end

end

end









end







if tp == 3 then




	if love.keyboard.isDown("right") then
		--PAREDE DIREITA COLISÃO
		if posicao_Do_Jogador1.posicaoY >= -15 and posicao_Do_Jogador1.posicaoX >= 588 and
			posicao_Do_Jogador1.posicaoY <= 230 and posicao_Do_Jogador1.posicaoX <= 589 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--CAMA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= -20 and posicao_Do_Jogador1.posicaoX >= 551 and
			posicao_Do_Jogador1.posicaoY <= 45 and posicao_Do_Jogador1.posicaoX <= 554 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			
		else
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX +
			posicao_Do_Jogador1.velocidade + dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 18, 16, 18)
						end
		end

	else





	if love.keyboard.isDown("left") then
		--PAREDE ESQUERDA COLISÃO
		if posicao_Do_Jogador1.posicaoY >= -15 and posicao_Do_Jogador1.posicaoX >= 304 and
			posicao_Do_Jogador1.posicaoY <= 12 and posicao_Do_Jogador1.posicaoX <= 305 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--ARMADURA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= -3 and posicao_Do_Jogador1.posicaoX >= 259 and
				posicao_Do_Jogador1.posicaoY <= 230 and posicao_Do_Jogador1.posicaoX <= 260 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		else		
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX -
			posicao_Do_Jogador1.velocidade - dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 54, 16, 18)
						end
		end
	
	else
	
	
	
	
	if love.keyboard.isDown("up") then
		--PAREDE CIMA COLISÃO
		if posicao_Do_Jogador1.posicaoY >= -4 and posicao_Do_Jogador1.posicaoX >= 250 and
			posicao_Do_Jogador1.posicaoY <= -3 and posicao_Do_Jogador1.posicaoX <= 600 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--ARMADURA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 12 and posicao_Do_Jogador1.posicaoX >= 259 and
				posicao_Do_Jogador1.posicaoY <= 13 and posicao_Do_Jogador1.posicaoX <= 300 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--CAMA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 42 and posicao_Do_Jogador1.posicaoX >= 552 and
				posicao_Do_Jogador1.posicaoY <= 43 and posicao_Do_Jogador1.posicaoX <= 600 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		else
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY -
			posicao_Do_Jogador1.velocidade - dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 0, 16, 18)
						end
		end
	else

	
	if love.keyboard.isDown("down") then
		-- PORTA COLISÃO
		--if porta_Aberta == 1 then
			if posicao_Do_Jogador1.posicaoY >= 214 and posicao_Do_Jogador1.posicaoX >= 410 and
				posicao_Do_Jogador1.posicaoY <= 216 and posicao_Do_Jogador1.posicaoX <= 440 then
				porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
				porta_sound:setLooping(false)
				porta_sound:play()
				--porta_Aberta = 0
				fundo = love.graphics.newImage("img/mundo/mapa/mapa01.png")
				posicao_Do_Jogador1.posicaoX = 425
				posicao_Do_Jogador1.posicaoY = 255
				tp = 2
			--end
		end	
		
		--PAREDE BAIXO COLISÃO		
		if posicao_Do_Jogador1.posicaoY >= 215 and posicao_Do_Jogador1.posicaoX >= 250 and
			posicao_Do_Jogador1.posicaoY <= 216 and posicao_Do_Jogador1.posicaoX <= 600 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		else	
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY +
			posicao_Do_Jogador1.velocidade + dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 36, 16, 18)
						end
		end
	
	end



	
	end
end
end





end

if tp == 4 then

b_Sist.soma_Cont_Modo_Batalha = b_Sist.cont_Modo_Batalha_Baixo + b_Sist.cont_Modo_Batalha_Cima + b_Sist.cont_Modo_Batalha_Dir + b_Sist.cont_Modo_Batalha_Esq
	if b_Sist.soma_Cont_Modo_Batalha == 200 then
	
		
		
		sound: stop()
		sound = love.audio.newSource("audio/batalha01.ogg","stream")
		sound:setLooping(true)
		sound:play()
		sound:setVolume(0.5)
		fundo = love.graphics.newImage("img/batalha/fundo/batalha_floresta.png")	
		seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
		seta_BatalhaX = 560
		seta_BatalhaY = 355
		
		posicao_Do_Guerreiro_Batalha.posicaoX = 500
		posicao_Do_Guerreiro_Batalha.posicaoY = 120
		
		posicao_Do_Mago_Batalha.posicaoX = 450
		posicao_Do_Mago_Batalha.posicaoY = 180
		
		posicao_Do_Elfa_Batalha.posicaoX = 400
		posicao_Do_Elfa_Batalha.posicaoY = 260
		
		turno = "guerreiro"
		
		vida_Total_Do_Gurreiro = sistema.vida_Guerreiro
		
		vida_Total_Do_Inimigo = sistema.inimigo_Status_Vida
		
		vida_Total_Do_Inimigo1 = sistema.inimigo_Status_Vida1
		
	
	tp = 99
	
	
	end

	if love.keyboard.isDown("right") then

		--TRONCO LIMITADOR DIREITA
				if posicao_Do_Jogador1.posicaoY >= -80 and posicao_Do_Jogador1.posicaoX >= 484 and
				posicao_Do_Jogador1.posicaoY <= 480 and posicao_Do_Jogador1.posicaoX <= 485 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				
		--TRONCO LIMITADOR DIREITA CIMA	
				elseif posicao_Do_Jogador1.posicaoY >= -80 and posicao_Do_Jogador1.posicaoX >= 244 and
				posicao_Do_Jogador1.posicaoY <= 61 and posicao_Do_Jogador1.posicaoX <= 245 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				else
				posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX +
				posicao_Do_Jogador1.velocidade + dt
			
			b_Sist.cont_Modo_Batalha_Dir = b_Sist.cont_Modo_Batalha_Dir + 1
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 18, 16, 18)
						end
		end

	else






		if love.keyboard.isDown("left") then
		
			--CERCA LIMITADOR ESQUERDA
				if posicao_Do_Jogador1.posicaoY >= -80 and posicao_Do_Jogador1.posicaoX >= 0 and
				posicao_Do_Jogador1.posicaoY <= 480 and posicao_Do_Jogador1.posicaoX <= 1 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				
				
			--ÁRVORE TRONCO LIMITADOR ESQUERDA CIMA
				elseif posicao_Do_Jogador1.posicaoY >= -80 and posicao_Do_Jogador1.posicaoX >= 164 and
				posicao_Do_Jogador1.posicaoY <= 61 and posicao_Do_Jogador1.posicaoX <= 165 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				
				--PARA MAPA 4 TP 5
				elseif posicao_Do_Jogador1.posicaoY >= 180 and posicao_Do_Jogador1.posicaoX >= -1 and
				posicao_Do_Jogador1.posicaoY <= 230 and posicao_Do_Jogador1.posicaoX <= 2 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				fundo = love.graphics.newImage("img/mundo/mapa/mapa04.png")
				posicao_Do_Jogador1.posicaoX = 570
				posicao_Do_Jogador1.posicaoY = 200
				tp = 5

			
					
				
				else
			
			
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX -
			posicao_Do_Jogador1.velocidade - dt
			b_Sist.cont_Modo_Batalha_Esq = b_Sist.cont_Modo_Batalha_Esq + 1
			
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 54, 16, 18)
						end
		end
		else

			if love.keyboard.isDown("up") then
							
				if para_Mapa01 == 0 then
				if posicao_Do_Jogador1.posicaoY >= -20 and posicao_Do_Jogador1.posicaoX >= 160 and
				posicao_Do_Jogador1.posicaoY <= -19 and posicao_Do_Jogador1.posicaoX <= 245 then
				fundo = love.graphics.newImage("img/mundo/mapa/mapa01.png")
				posicao_Do_Jogador1.posicaoX = 190
				posicao_Do_Jogador1.posicaoY = 415
				tp = 2
			end
			end
			
			
				--ÁRVORE COLISÃO
				if posicao_Do_Jogador1.posicaoY >= -20 and posicao_Do_Jogador1.posicaoX >= -80 and
				posicao_Do_Jogador1.posicaoY <= -19 and posicao_Do_Jogador1.posicaoX <= 680  then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY

				--TRONCO CIMA DIREITA COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 61 and posicao_Do_Jogador1.posicaoX >= 250 and
				posicao_Do_Jogador1.posicaoY <= 62 and posicao_Do_Jogador1.posicaoX <= 680 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				
				--TRONCO CIMA ESQUERDA COLISÃO
				elseif posicao_Do_Jogador1.posicaoY >= 61 and posicao_Do_Jogador1.posicaoX >= -80 and
				posicao_Do_Jogador1.posicaoY <= 62 and posicao_Do_Jogador1.posicaoX <= 175 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--PARA MAPA 4 TP 5
				elseif posicao_Do_Jogador1.posicaoY >= 180 and posicao_Do_Jogador1.posicaoX >= -1 and
				posicao_Do_Jogador1.posicaoY <= 230 and posicao_Do_Jogador1.posicaoX <= 2 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				fundo = love.graphics.newImage("img/mundo/mapa/mapa04.png")
				posicao_Do_Jogador1.posicaoX = 570
				posicao_Do_Jogador1.posicaoY = 200
				tp = 5


		


				else
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY -
				posicao_Do_Jogador1.velocidade - dt
				b_Sist.cont_Modo_Batalha_Cima = b_Sist.cont_Modo_Batalha_Cima + 1
					if dt > 0.035 then
						return
					end
						tempo_De_Animacao = tempo_De_Animacao - dt
							if tempo_De_Animacao <= 0 then
								tempo_De_Animacao = 1 / quantidade_De_Quadros
								quadro = quadro + 1
									if quadro > num_Quadros then
										quadro = 1
									end
										xoffset = 16 * quadro
										jogador1_Recorte:setViewport(xoffset, 0, 16, 18)
				end
							end
							

			else

				if love.keyboard.isDown("down") then
				
				
				--ÁRVORE COLISÃO
				if posicao_Do_Jogador1.posicaoY >= 377 and posicao_Do_Jogador1.posicaoX >= -80 and
				posicao_Do_Jogador1.posicaoY <= 378 and posicao_Do_Jogador1.posicaoX <= 680 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				--PARA MAPA 4 TP 5
				elseif posicao_Do_Jogador1.posicaoY >= 180 and posicao_Do_Jogador1.posicaoX >= -1 and
				posicao_Do_Jogador1.posicaoY <= 230 and posicao_Do_Jogador1.posicaoX <= 2 then
				posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
				fundo = love.graphics.newImage("img/mundo/mapa/mapa04.png")
				posicao_Do_Jogador1.posicaoX = 570
				posicao_Do_Jogador1.posicaoY = 200
				tp = 5


				



				else
				
				
				
					posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY +
					posicao_Do_Jogador1.velocidade + dt
					b_Sist.cont_Modo_Batalha_Baixo = b_Sist.cont_Modo_Batalha_Baixo + 1
						if dt > 0.035 then
						return
						end
							tempo_De_Animacao = tempo_De_Animacao - dt
								if tempo_De_Animacao <= 0 then
									tempo_De_Animacao = 1 / quantidade_De_Quadros
									quadro = quadro + 1
										if quadro > num_Quadros then
										quadro = 1
										end
											xoffset = 16 * quadro
											jogador1_Recorte:setViewport(xoffset, 36, 16, 18)
								end
				end






		end
end


				end

				end



end

if tp == 5 then
--sound:stop()

	if love.keyboard.isDown("right") then
		--PAREDE DIREITA COLISÃO
		if posicao_Do_Jogador1.posicaoY >= -80 and posicao_Do_Jogador1.posicaoX >= 590 and
			posicao_Do_Jogador1.posicaoY <= 500 and posicao_Do_Jogador1.posicaoX <= 591 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--CASA BAIXO DIREITA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 219 and posicao_Do_Jogador1.posicaoX >= 350 and
			posicao_Do_Jogador1.posicaoY <= 220 and posicao_Do_Jogador1.posicaoX <= 351 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--CASA CIMA DIREITA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= -30 and posicao_Do_Jogador1.posicaoX >= 410 and
			posicao_Do_Jogador1.posicaoY <= 134 and posicao_Do_Jogador1.posicaoX <= 411 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--ARVORE + BANCO
 		elseif posicao_Do_Jogador1.posicaoY >= 228 and posicao_Do_Jogador1.posicaoX >= 160 and
			posicao_Do_Jogador1.posicaoY <= 316 and posicao_Do_Jogador1.posicaoX <= 161 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--CERCA CASA BAIXO
 		elseif posicao_Do_Jogador1.posicaoY >= 210 and posicao_Do_Jogador1.posicaoX >= 350 and
			posicao_Do_Jogador1.posicaoY <= 460 and posicao_Do_Jogador1.posicaoX <= 351 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--PARA MAPA 3 TP 4
 		elseif posicao_Do_Jogador1.posicaoY >= 130 and posicao_Do_Jogador1.posicaoX >= 589 and
			posicao_Do_Jogador1.posicaoY <= 220 and posicao_Do_Jogador1.posicaoX <= 590 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			fundo = love.graphics.newImage("img/mundo/mapa/mapa03.png")
			posicao_Do_Jogador1.posicaoX = 12
			posicao_Do_Jogador1.posicaoY = 200
			tp = 4
		elseif posicao_Do_Jogador1.posicaoY >= 133 and posicao_Do_Jogador1.posicaoX >= 125 and
			posicao_Do_Jogador1.posicaoY <= 137 and posicao_Do_Jogador1.posicaoX <= 145 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--PARA MAPA 5 TP 6
			sound:stop()
			porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
			porta_sound:setLooping(false)
			porta_sound:play()
			fundo = love.graphics.newImage("img/mundo/mapa/mapa05.png")
			posicao_Do_Jogador1.posicaoX = 170
			posicao_Do_Jogador1.posicaoY = 210
			sound = love.audio.newSource("audio/loja.ogg","stream")
			sound:setLooping(true)
			sound:play()
			
			tp = 6
		--tp == loja
		
	
		else
		posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX +
		posicao_Do_Jogador1.velocidade + dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 18, 16, 18)
						end
		end
	else





	if love.keyboard.isDown("left") then
		--PAREDE ESQUERDA COLISÃO
		if posicao_Do_Jogador1.posicaoY >= -15 and posicao_Do_Jogador1.posicaoX >= 9 and
			posicao_Do_Jogador1.posicaoY <= 480 and posicao_Do_Jogador1.posicaoX <= 10 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--ARVORE + BANCO
 		elseif posicao_Do_Jogador1.posicaoY >= 228 and posicao_Do_Jogador1.posicaoX >= 245 and
			posicao_Do_Jogador1.posicaoY <= 315 and posicao_Do_Jogador1.posicaoX <= 246 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--CASA CIMA ESQUERDA COLISÃO
 		elseif posicao_Do_Jogador1.posicaoY >= -30 and posicao_Do_Jogador1.posicaoX >= 209 and
			posicao_Do_Jogador1.posicaoY <= 134 and posicao_Do_Jogador1.posicaoX <= 210 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		elseif posicao_Do_Jogador1.posicaoY >= 133 and posicao_Do_Jogador1.posicaoX >= 125 and
			posicao_Do_Jogador1.posicaoY <= 137 and posicao_Do_Jogador1.posicaoX <= 145 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--PARA MAPA 5 TP 6
			sound:stop()
			porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
			porta_sound:setLooping(false)
			porta_sound:play()
			fundo = love.graphics.newImage("img/mundo/mapa/mapa05.png")
			posicao_Do_Jogador1.posicaoX = 170
			posicao_Do_Jogador1.posicaoY = 210
			sound = love.audio.newSource("audio/loja.ogg","stream")
			sound:setLooping(true)
			sound:play()
			
			tp = 6
		

		
		
		else		
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX -
			posicao_Do_Jogador1.velocidade - dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 54, 16, 18)
						end
		end
	
	else
	
	
	
	
	if love.keyboard.isDown("up") then
		--PAREDE CIMA COLISÃO
		if posicao_Do_Jogador1.posicaoY >= -4 and posicao_Do_Jogador1.posicaoX >= -80 and
			posicao_Do_Jogador1.posicaoY <= -3 and posicao_Do_Jogador1.posicaoX <= 700 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			
		--CASA CIMA DIREITA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 134 and posicao_Do_Jogador1.posicaoX >= 411 and
			posicao_Do_Jogador1.posicaoY <= 135 and posicao_Do_Jogador1.posicaoX <= 700 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--PORTA CASA CIMA DIREITA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 134 and posicao_Do_Jogador1.posicaoX >= 470 and
			posicao_Do_Jogador1.posicaoY <= 135 and posicao_Do_Jogador1.posicaoX <= 490 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
			--Texto porta fechada
		--CASA CIMA ESQUERDA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 134 and posicao_Do_Jogador1.posicaoX >= -80 and
			posicao_Do_Jogador1.posicaoY <= 135 and posicao_Do_Jogador1.posicaoX <= 210 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--ARVORE + BANCO
 		elseif posicao_Do_Jogador1.posicaoY >= 315 and posicao_Do_Jogador1.posicaoX >= 161 and
			posicao_Do_Jogador1.posicaoY <= 316 and posicao_Do_Jogador1.posicaoX <= 245 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--PORTA CASA CIMA ESQUERDA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 133 and posicao_Do_Jogador1.posicaoX >= 125 and
			posicao_Do_Jogador1.posicaoY <= 137 and posicao_Do_Jogador1.posicaoX <= 145 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--PARA MAPA 5 TP 6
			sound:stop()
			porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
			porta_sound:setLooping(false)
			porta_sound:play()
			fundo = love.graphics.newImage("img/mundo/mapa/mapa05.png")
			posicao_Do_Jogador1.posicaoX = 170
			posicao_Do_Jogador1.posicaoY = 210
			sound = love.audio.newSource("audio/loja.ogg","stream")
			sound:setLooping(true)
			sound:play()
			
			tp = 6
		--PORTA CASA CIMA DIREITA COLISÃO
		elseif posicao_Do_Jogador1.posicaoY >= 133 and posicao_Do_Jogador1.posicaoX >= 470 and
			posicao_Do_Jogador1.posicaoY <= 137 and posicao_Do_Jogador1.posicaoX <= 490 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--TXT PORTA FECHADA
			porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
			porta_sound:setLooping(false)
			porta_sound:play()
		
			tp = 7
			texto_Evt_01 = love.graphics.newImage("img/texto/texto01.png")
			texto_Evt_01X = 0
			texto_Evt_01Y = 300
			
			
			
		
		
		else
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY -
			posicao_Do_Jogador1.velocidade - dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 0, 16, 18)
						end
		end
	else

	
	if love.keyboard.isDown("down") then
	
		
		--PAREDE BAIXO COLISÃO		
		if posicao_Do_Jogador1.posicaoY >= 420 and posicao_Do_Jogador1.posicaoX >= -80 and
			posicao_Do_Jogador1.posicaoY <= 421 and posicao_Do_Jogador1.posicaoX <= 500 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--ARVORE + BANCO
 		elseif posicao_Do_Jogador1.posicaoY >= 227 and posicao_Do_Jogador1.posicaoX >= 161 and
			posicao_Do_Jogador1.posicaoY <= 228 and posicao_Do_Jogador1.posicaoX <= 245 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		--CERCA CASA BAIXO
 		elseif posicao_Do_Jogador1.posicaoY >= 209 and posicao_Do_Jogador1.posicaoX >= 350 and
			posicao_Do_Jogador1.posicaoY <= 210 and posicao_Do_Jogador1.posicaoX <= 640 then
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
		else	
			posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY +
			posicao_Do_Jogador1.velocidade + dt
				if dt > 0.035 then
					return
				end
					tempo_De_Animacao = tempo_De_Animacao - dt
						if tempo_De_Animacao <= 0 then
							tempo_De_Animacao = 1 / quantidade_De_Quadros
							quadro = quadro + 1
								if quadro > num_Quadros then
									quadro = 1
								end
									xoffset = 16 * quadro
									jogador1_Recorte:setViewport(xoffset, 36, 16, 18)
						end
		end
	
	
		

	
end
end
end
--Soldado	
	function love.keypressed(key)
		if key == "space" then	
		
			if posicao_Do_Jogador1.posicaoY >= -5 and posicao_Do_Jogador1.posicaoX >= 250 and
				posicao_Do_Jogador1.posicaoY <= 10 and posicao_Do_Jogador1.posicaoX <= 330 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto02.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 7
			elseif posicao_Do_Jogador1.posicaoY >= 160 and posicao_Do_Jogador1.posicaoX >= -8 and
				posicao_Do_Jogador1.posicaoY <= 230 and posicao_Do_Jogador1.posicaoX <= 10 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto02.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 7
			elseif posicao_Do_Jogador1.posicaoY >= 419 and posicao_Do_Jogador1.posicaoX >= 280 and
				posicao_Do_Jogador1.posicaoY <= 421 and posicao_Do_Jogador1.posicaoX <= 330 then
				texto_Evt_01 = love.graphics.newImage("img/texto/texto02.png")
				texto_Evt_01X = 0
				texto_Evt_01Y = 300
				tp = 7
			end
		end	
	end
end


end


if tp == 7 then
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX
			if love.keyboard.isDown("x") then
				tp = 5
				texto_Evt_01X = -1000
				texto_Evt_01Y = -1000
				
			end	
			end


if tp == 8 then
			posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX
			if love.keyboard.isDown("x") then
				tp = 2
				texto_Evt_01X = -1000
				texto_Evt_01Y = -1000
				
			end	
			end
			


			
		
if tp == 99 then





	
	
	
		--TURNO DO GURREIRO
		
		if turno == "guerreiro" then
		
		
		
		
		function love.keypressed (tecla2)
		
		
			if tecla2 == "down" then
					if seta_BatalhaX == 560 and seta_BatalhaY == 355 then
						seta_BatalhaY = seta_BatalhaY + 25
						efeito_selecao:play()
					elseif seta_BatalhaX == 560 and seta_BatalhaY == 380 then
						seta_BatalhaY = seta_BatalhaY + 25
						efeito_selecao:play()
					elseif seta_BatalhaX == 560 and seta_BatalhaY == 405 then
						seta_BatalhaY = seta_BatalhaY + 25
						efeito_selecao:play()
					elseif seta_BatalhaX == 130 and seta_BatalhaY == 100 then
						seta_BatalhaY = seta_BatalhaY + 100
						seta_BatalhaX = seta_BatalhaX - 50
						efeito_selecao:play()
						
					elseif seta_BatalhaX == 220 and seta_BatalhaY == 40 then
							
							seta_BatalhaY = seta_BatalhaY + 40			
							efeito_selecao:play()
							
					
					end
				end	
					if tecla2 == "up" then
						if seta_BatalhaX == 560 and seta_BatalhaY == 430 then
							seta_BatalhaY = seta_BatalhaY - 25
							efeito_selecao:play()
						elseif seta_BatalhaX == 560 and seta_BatalhaY == 405 then
							seta_BatalhaY = seta_BatalhaY - 25
							efeito_selecao:play()
						elseif seta_BatalhaX == 560 and seta_BatalhaY == 380 then
							seta_BatalhaY = seta_BatalhaY - 25
							efeito_selecao:play()
							elseif seta_BatalhaX == 80 and seta_BatalhaY == 200 then
						seta_BatalhaY = seta_BatalhaY - 100
						seta_BatalhaX = seta_BatalhaX + 50
						efeito_selecao:play()
						elseif seta_BatalhaX == 220 and seta_BatalhaY == 80 then
							
							seta_BatalhaY = seta_BatalhaY - 40			
							efeito_selecao:play()
							
						
						end
					end
			
					
						--MENU ESCOLHA
						if tecla2 == "space" then
							
							
							--SELECAO MAGIA
							if seta_BatalhaX == 560 and seta_BatalhaY == 380 then
							magiaTxtL = love.graphics.newImage("img/texto/texto06.png")
							magiaTxtLX = 0
							magiaTxtLY = 0
							seta_BatalhaX = -1000
							seta_BatalhaY = -1000

							
							--SELECAO ITEM
							elseif seta_BatalhaX == 560 and seta_BatalhaY == 405 then
							seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta02.png")
							seta_BatalhaX = 220
							seta_BatalhaY = 40
							fundo_Itens = love.graphics.newImage("img/batalha/fundo/menuitem.png")
							fundo_ItensX = 200
							fundo_ItensY = 0
							pocao_Cura_JX = 400
							pocao_Cura_JY = 40
							pocao_Mana_JX = 400
							pocao_Mana_JY = 80
							efeito_selecao:play()
							elseif seta_BatalhaX == 220 and seta_BatalhaY == 40 then
								if sistema.pocao_Cura_J <= 0 then
								sound_Negado:play()
								else
								
							sistema.pocao_Cura_J = sistema.pocao_Cura_J - 1
							
							vida_Total_Do_Gurreiro = vida_Total_Do_Gurreiro + 5
							
							sound_Cura:stop()
							sound_Cura:play()

							
																				
							fundo_ItensX = -1000
							fundo_ItensX = -1000
							seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta02.png")
							seta_BatalhaX = -1000
							seta_BatalhaY = -1000
											
							seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
							seta_BatalhaX = 560 
							seta_BatalhaY = 355							
							
							pocao_Cura_JX = -1000
							pocao_Cura_JY = -1000
							pocao_Mana_JX = -1000
							pocao_Mana_JY = -1000
						
							
							end
							
							
														
												
													
									
								
							
							---------------------------------------------------------	
							elseif seta_BatalhaX == 220 and seta_BatalhaY == 80 then
							
								if sistema.pocao_Mana_J <= 0 then
								
							
							sound_Negado:play()
								
								else
							
							
							
							sistema.pocao_Mana_J = sistema.pocao_Mana_J - 1
							
							mana_Guerreiro_Total = mana_Guerreiro_Total + 5
							
							sound_Cura:stop()
							sound_Cura:play()							
							
							
							fundo_ItensX = -1000
							fundo_ItensX = -1000
							seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta02.png")
							seta_BatalhaX = -1000
							seta_BatalhaY = -1000
											
							seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
							seta_BatalhaX = 560 
							seta_BatalhaY = 355
							
							pocao_Cura_JX = -1000
							pocao_Cura_JY = -1000
							pocao_Mana_JX = -1000
							pocao_Mana_JY = -1000
							
								end	
								
								
							
												
								
								
								
							
							
							--SELECAO SAIR
							elseif seta_BatalhaX == 560 and seta_BatalhaY == 430 then
								fundo = love.graphics.newImage("img/mundo/mapa/mapa03.png")
								sound:stop()
								sound = love.audio.newSource("audio/aventura.ogg","stream")
								sound:setLooping(true)
								sound:play()
								b_Sist.soma_Cont_Modo_Batalha = 0
								b_Sist.cont_Modo_Batalha_Baixo = 0
								b_Sist.cont_Modo_Batalha_Cima = 0
								b_Sist.cont_Modo_Batalha_Dir = 0
								b_Sist.cont_Modo_Batalha_Esq = 0
								tp = 4
								turno = "nenhum"
								vida_Total_Do_Gurreiro = sistema.vida_Guerreiro
								vida_Total_Do_Inimigo = sistema.inimigo_Status_Vida
								vida_Total_Do_Inimigo1 = sistema.inimigo_Status_Vida1
								inimigo1 = love.graphics.newImage("img/batalha/inimigo/inimigo01.png")
								inimigo2 = love.graphics.newImage("img/batalha/inimigo/inimigo02.png")
								vitoria_F = 1
								magiaTxtY = -1000
								magiaTxtX = -1000
								magiaTxtLX = -1000
								magiaTxtLY = -1000
								inimigoTxt1X = -1000
								inimigoTxt1Y = -1000
								inimigoTxt2X = -1000
								inimigoTxt2Y = -1000
								xpX = -1000
								xpY = -1000
								lvlX = -1000
								lvlY = -1000
								dinX = -1000
								dinY = -1000
							
							--SELECAO ATAQUE							
							elseif seta_BatalhaX == 560 and seta_BatalhaY == 355 then
									seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta01.png")
									seta_BatalhaX = 130
									seta_BatalhaY = 100
							elseif seta_BatalhaX == 130 and seta_BatalhaY == 100 then
									espada_Fx = love.audio.newSource("audio/espada.wav","stream")
									espada_Fx:setLooping(false)
									espada_Fx:play()
									posicao_Do_Guerreiro_Batalha.posicaoX = 180
									posicao_Do_Guerreiro_Batalha.posicaoY = 160
									
									
									if sistema.espada_Curta_Habilitado == true then
									vida_Total_Do_Inimigo = vida_Total_Do_Inimigo - sistema.ataque_Total_Guerreiro_E
									
									else
									vida_Total_Do_Inimigo = vida_Total_Do_Inimigo - sistema.ataque_Total_Guerreiro
									end
									
									
									-- ANIMACAO ATAQUE									
									
											magiaTxt=love.graphics.newImage("img/texto/texto07.png")
											magiaTxtX = 450
											magiaTxtY = 80
											fx = love.graphics.newImage("img/fx/ataque.png")
											fx_Recorte = love.graphics.newQuad(0, 64, 64, 64, fx:getDimensions())
															
												
													
									
														
														
														seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
													seta_BatalhaX = -1000
													seta_BatalhaY = -1000
														
															if vida_Total_Do_Inimigo <= 0 then
															
														inimigo1 = love.graphics.newImage("img/batalha/inimigo/die.png")
														
														
														seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
														seta_BatalhaX = -1000
														seta_BatalhaY = -1000
														
														magiaTxtX = 450
														magiaTxtY = 80
														
														
														
														
										
										
						
									end

							elseif seta_BatalhaX == 80 and seta_BatalhaY == 200 then
								if sistema.espada_Curta_Habilitado == true then
									vida_Total_Do_Inimigo1 = vida_Total_Do_Inimigo1 - sistema.ataque_Total_Guerreiro_E
									else
									vida_Total_Do_Inimigo1 = vida_Total_Do_Inimigo1 - sistema.ataque_Total_Guerreiro
									end
									if vida_Total_Do_Inimigo1 > 0 then
									magiaTxt=love.graphics.newImage("img/texto/texto07.png")
											magiaTxtX = 450
											magiaTxtY = 80
									espada_Fx = love.audio.newSource("audio/espada.wav","stream")
									espada_Fx:setLooping(false)
									espada_Fx:play()
									posicao_Do_Guerreiro_Batalha.posicaoX = 140
									posicao_Do_Guerreiro_Batalha.posicaoY = 255
										fx = love.graphics.newImage("img/fx/ataque01.png")
										fx_Recorte = love.graphics.newQuad(0, 64, 64, 64, fx:getDimensions())
										posicao_Do_Fx.posicaoX = 60
										posicao_Do_Fx.posicaoY = 250
										
									
									
										
														
														
														
														seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
														seta_BatalhaX = -1000 
														seta_BatalhaY = -1000
														
															
															
															
															
															
														
															
															elseif vida_Total_Do_Inimigo1 <= 0 then
														
																inimigo2 = love.graphics.newImage("img/batalha/inimigo/die.png")
																
																
																seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
														seta_BatalhaX = -1000
														seta_BatalhaY = -1000
														
														magiaTxtX = 450
														magiaTxtY = 80
																											
													end
													
												
									
									
									end
								end	
									
							
					
					
				
		
	
	if tecla2 == "x" then
		if vitoria_F == 0 then
			fundo = love.graphics.newImage("img/mundo/mapa/mapa03.png")
								sound:stop()
								sound = love.audio.newSource("audio/aventura.ogg","stream")
								sound:setLooping(true)
								sound:play()
								b_Sist.soma_Cont_Modo_Batalha = 0
								b_Sist.cont_Modo_Batalha_Baixo = 0
								b_Sist.cont_Modo_Batalha_Cima = 0
								b_Sist.cont_Modo_Batalha_Dir = 0
								b_Sist.cont_Modo_Batalha_Esq = 0
								tp = 4
								turno = "nenhum"
								vida_Total_Do_Inimigo = sistema.inimigo_Status_Vida
								vida_Total_Do_Inimigo1 = sistema.inimigo_Status_Vida1
								inimigo1 = love.graphics.newImage("img/batalha/inimigo/inimigo01.png")
								inimigo2 = love.graphics.newImage("img/batalha/inimigo/inimigo02.png")
								vitoria_F = 1
								magiaTxtY = -1000
								magiaTxtX = -1000
								magiaTxtLX = -1000
								magiaTxtLY = -1000
								inimigoTxt1X = -1000
								inimigoTxt1Y = -1000
								inimigoTxt2X = -1000
								inimigoTxt2Y = -1000
								xpX = -1000
								xpY = -1000
								lvlX = -1000
								lvlY = -1000
								dinX = -1000
								dinY = -1000
								
							
		end
				
							if seta_BatalhaX == 80 and seta_BatalhaY == 200 then
								seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
								seta_BatalhaX = 560
								seta_BatalhaY = 355
								
							elseif seta_BatalhaX == 130 and seta_BatalhaY == 100 then
								seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
								seta_BatalhaX = 560
								seta_BatalhaY = 355
							
							elseif seta_BatalhaX == 220 and seta_BatalhaY == 80 then
								seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
								seta_BatalhaX = 560
								seta_BatalhaY = 405
								fundo_ItensX = -1000
								fundo_ItensY = -1000
								pocao_Cura_JX = -1000
								pocao_Cura_JY = -1000
								pocao_Mana_JX = -1000
								pocao_Mana_JY = -1000
								
							elseif seta_BatalhaX == 220 and seta_BatalhaY == 40 then
								seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
								seta_BatalhaX = 560
								seta_BatalhaY = 405
								fundo_ItensX = -1000
								fundo_ItensY = -1000
								pocao_Cura_JX = -1000
								pocao_Cura_JY = -1000
								pocao_Mana_JX = -1000
								pocao_Mana_JY = -1000
							elseif vida_Total_Do_Gurreiro <= 0 then
							sound:stop()
							sound = love.audio.newSource("audio/gameover.ogg","stream")
							sound:setLooping(false)
							sound:play()
							fundo_GameoverX = 0
							funco_GameoverY = 0
							seta_BatalhaX = -1000 
							seta_BatalhaY = -1000
							
							turno = "nenhum"
							
		
		
							elseif vida_Total_Do_Inimigo < 0 and vida_Total_Do_Inimigo1 < 0 then
							sound: stop()
							sound = love.audio.newSource("audio/vitoria.ogg","stream")
							sound:setLooping(false)
							sound:play()
							sistema.xp = sistema.xp + 8
							sistema.dindin = sistema.dindin + 11
							xpX = 200
							xpY = 350
							lvlX = 200
							lvlY = 400
							dinX = 200
							dinY = 450
							 
							setaX = -1000
							setaY = -1000
							if sistema.xp == 100 then
							sistema.lvl = sistema.lvl + 1
							sistema.xp = 0
							end
		
							vitoria_F = 0
							
						
							elseif magiaTxtLX == 0 and magiaTxtLY == 0 then
								seta_Batalha = love.graphics.newImage("img/batalha/fundo/seta.png")
								seta_BatalhaX = 560
								seta_BatalhaY = 405
								magiaTxtLX = -1000
								magiaTxtLY = -1000
							
							elseif magiaTxtX == 450 and magiaTxtY == 80 then
							if vida_Total_Do_Inimigo > 0 then
							magiaTxtX = -1000
							magiaTxtY = -1000
							posicao_Do_Guerreiro_Batalha.posicaoX = 500
							posicao_Do_Guerreiro_Batalha.posicaoY = 120
							inimigoTxt1X = 450
							inimigoTxt1Y = 80
							seta_BatalhaX = -1000 
							seta_BatalhaY = -1000
							else
							magiaTxtX = -1000
							magiaTxtY = -1000
							posicao_Do_Guerreiro_Batalha.posicaoX = 500
							posicao_Do_Guerreiro_Batalha.posicaoY = 120
							inimigoTxt2X = 450
							inimigoTxt2Y = 80
							seta_BatalhaX = 560 
							seta_BatalhaY = 355
							end
							
													
							elseif inimigoTxt1X == 450 and inimigoTxt1Y == 80 then
						
							inimigoTxt1X = -1000
							inimigoTxt1Y = -1000
							posicao_Do_Guerreiro_Batalha.posicaoX = 500
							posicao_Do_Guerreiro_Batalha.posicaoY = 120
							inimigo1X = 430
							inimigo1Y = 120
							espada_Fx = love.audio.newSource("audio/espada.wav","stream")
							espada_Fx:setLooping(false)
							espada_Fx:play()
							inimigoTxt2X = 450
							inimigoTxt2Y = 80
							seta_BatalhaX = -1000
							seta_BatalhaY = -1000
							vida_Total_Do_Gurreiro = vida_Total_Do_Gurreiro - sistema.inimigo_Status_Ataque1
							
							
							elseif inimigoTxt2X == 450 and inimigoTxt2Y == 80 then
								if vida_Total_Do_Inimigo1 > 0 then
							inimigoTxt2X = -1000
							inimigoTxt2Y = -1000
							posicao_Do_Guerreiro_Batalha.posicaoX = 500
							posicao_Do_Guerreiro_Batalha.posicaoY = 120
							inimigo2X = 430
							inimigo2Y = 120
							inimigo1X = 100
							inimigo1Y = 150
							seta_BatalhaX = -1000 
							seta_BatalhaY = -1000
							espada_Fx = love.audio.newSource("audio/espada.wav","stream")
							espada_Fx:setLooping(false)
							espada_Fx:play()
							vida_Total_Do_Gurreiro = vida_Total_Do_Gurreiro - sistema.inimigo_Status_Ataque1
							else
							inimigoTxt2X = -1000
							inimigoTxt2Y = -1000
							posicao_Do_Guerreiro_Batalha.posicaoX = 500
							posicao_Do_Guerreiro_Batalha.posicaoY = 120
							inimigo1X = 100
							inimigo1Y = 150
							seta_BatalhaX = 560 
							seta_BatalhaY = 355
							
							
												
							end
							
							elseif inimigo1X == 100 and inimigo1Y == 150 and inimigo2X == 430 and inimigo2Y == 120 then
							
							inimigoTxt2X = -1000
							inimigoTxt2Y = -1000
							posicao_Do_Guerreiro_Batalha.posicaoX = 500
							posicao_Do_Guerreiro_Batalha.posicaoY = 120
							inimigo2X = 60
							inimigo2Y = 250
							inimigo1X = 100
							inimigo1Y = 150
							seta_BatalhaX = 560 
							seta_BatalhaY = 355
							
							
																		
							end
							end
	
	
	end
	



	

				


						if dt > 0.035 then
							return
						end
						guerreiro_Batalha_Tempo_De_Animacao = guerreiro_Batalha_Tempo_De_Animacao - dt
							if guerreiro_Batalha_Tempo_De_Animacao <= 0 then
								guerreiro_Batalha_Tempo_De_Animacao= 1 / guerreiro_Batalha_Quantidade_De_Quadros
								guerreiro_Batalha_Quadro = guerreiro_Batalha_Quadro + 1
									if guerreiro_Batalha_Quadro > guerreiro_Batalha_Num_Quadros then
										guerreiro_Batalha_Quadro = 1
									end
										guerreiro_Batalha_Xoffset = 16 * guerreiro_Batalha_Quadro
										guerreiro_Batalha_Recorte:setViewport(guerreiro_Batalha_Xoffset, 18, 16, 18)
							end
							
end

end


									if tp == 1000 then
									setaX = -1000
									setaY = -1000
									seta_BatalhaX = -1000
									seta_BatalhaY = -1000
									magiaTxtLX = -1000
									magiaTxt1X = -1000
									magiaTxt2X = -1000
									inimigo2X = -1000
									inimigo2Y = -1000
									inimigo1X = -1000
									inimigo1Y = -1000
									turno = "nenhum"
									end			


		
if tp == 102 then
 function love.keypressed(tecla)
	if tecla == "down" then
					if seta_LojaX == 400 and seta_LojaY == 30 then
						seta_LojaY = seta_LojaY + 30
						efeito_selecao:play()
					end
					
					elseif tecla == "up" then
						if seta_LojaX == 400 and seta_LojaY == 60 then
							seta_LojaY = seta_LojaY - 30
							efeito_selecao:play()		
						end
					elseif tecla == "x" then
						
						if seta_LojaX == 400 and seta_LojaY == 30 then
							tp = 6
							efeito_selecao:play()
						end
						
						if seta_LojaX == 400 and seta_LojaY == 60 then
							tp = 6
							efeito_selecao:play()		
						end
					elseif tecla == "space" then
					
						if seta_LojaX == 400 and seta_LojaY == 30 then
							if sistema.dindin < 5 then
						
							else
							sistema.dindin = sistema.dindin - 5
							sistema.pocao_Cura_J = sistema.pocao_Cura_J + 1
							efeito_selecao:play()
						end
						end
						if seta_LojaX == 400 and seta_LojaY == 60 then
							if sistema.dindin < 9 then
						
							else
							sistema.dindin = sistema.dindin - 9
							sistema.pocao_Mana_J = sistema.pocao_Mana_J + 1
							
							end
						end
						
					
						
					end
	end

end


if tp == 6 then

	function love.keypressed (tecla)
	
	if tecla == "space" then
		if posicao_Do_Jogador1.posicaoY >= 138 and posicao_Do_Jogador1.posicaoX >= 160 and
		posicao_Do_Jogador1.posicaoY <= 141 and posicao_Do_Jogador1.posicaoX <= 190 then
	menu_LojaX = 0
	menu_LojaY = 0
	seta_LojaX = 400
	seta_LojaY = 30
	texto_NpcX = 10
	texto_NpcY = 300
	tp = 102
	end
	end
	end
	

	if dt > 0.035 then
					return
				end
					npc_Loja_Tempo_De_Animacao = npc_Loja_Tempo_De_Animacao - dt
						if npc_Loja_Tempo_De_Animacao <= 0 then
							npc_Loja_Tempo_De_Animacao = 1 / npc.npc_Loja_Quantidade_De_Quadros
							npc.npc_Loja_Quadro = npc.npc_Loja_Quadro + 1
								if npc.npc_Loja_Quadro > npc.npc_Loja_Num_Quadros then
									npc.npc_Loja_Quadro = 1
								end
									npc.npc_Loja_Xoffset = 16 * npc.npc_Loja_Quadro
									npc.npc_Loja_Recorte:setViewport(npc.npc_Loja_Xoffset, 36, 16, 18)
						end
						


	
if love.keyboard.isDown("right") then
	--PAREDE DIREITA
	if posicao_Do_Jogador1.posicaoY >= 80 and posicao_Do_Jogador1.posicaoX >= 334 and
		posicao_Do_Jogador1.posicaoY <= 270 and posicao_Do_Jogador1.posicaoX <= 335 then
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
	elseif posicao_Do_Jogador1.posicaoY >= 225 and posicao_Do_Jogador1.posicaoX >= 194 and
		posicao_Do_Jogador1.posicaoY <= 300 and posicao_Do_Jogador1.posicaoX <= 196 then
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
	else
		posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX +
		posicao_Do_Jogador1.velocidade + dt
			if dt > 0.035 then
				return
			end
				tempo_De_Animacao = tempo_De_Animacao - dt
					if tempo_De_Animacao <= 0 then
						tempo_De_Animacao = 1 / quantidade_De_Quadros
						quadro = quadro + 1
							if quadro > num_Quadros then
								quadro = 1
							end
								xoffset = 16 * quadro
								jogador1_Recorte:setViewport(xoffset, 18, 16, 18)
					end
	end
elseif love.keyboard.isDown("left") then
	--PAREDE ESQUERDA
	if posicao_Do_Jogador1.posicaoY >= 80 and posicao_Do_Jogador1.posicaoX >= 14 and
		posicao_Do_Jogador1.posicaoY <= 270 and posicao_Do_Jogador1.posicaoX <= 15 then
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
	elseif posicao_Do_Jogador1.posicaoY >= 224 and posicao_Do_Jogador1.posicaoX >= 154 and
		posicao_Do_Jogador1.posicaoY <= 300 and posicao_Do_Jogador1.posicaoX <= 155 then
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
	else
		posicao_Do_Jogador1.posicaoX = posicao_Do_Jogador1.posicaoX -
		posicao_Do_Jogador1.velocidade - dt
			if dt > 0.035 then
				return
			end
				tempo_De_Animacao = tempo_De_Animacao - dt
					if tempo_De_Animacao <= 0 then
						tempo_De_Animacao = 1 / quantidade_De_Quadros
						quadro = quadro + 1
							if quadro > num_Quadros then
								quadro = 1
							end
								xoffset = 16 * quadro
								jogador1_Recorte:setViewport(xoffset, 54, 16, 18)
					end
	end
elseif love.keyboard.isDown("up") then
	--BALCÃO
	if posicao_Do_Jogador1.posicaoY >= 139 and posicao_Do_Jogador1.posicaoX >= -40 and
		posicao_Do_Jogador1.posicaoY <= 140 and posicao_Do_Jogador1.posicaoX <= 370 then
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
	else
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY -
		posicao_Do_Jogador1.velocidade - dt
			if dt > 0.035 then
				return
			end
			tempo_De_Animacao = tempo_De_Animacao - dt
				if tempo_De_Animacao <= 0 then
					tempo_De_Animacao = 1 / quantidade_De_Quadros
					quadro = quadro + 1
						if quadro > num_Quadros then
							quadro = 1
						end
							xoffset = 16 * quadro
							jogador1_Recorte:setViewport(xoffset, 0, 16, 18)
				end
	end
elseif love.keyboard.isDown("down") then
	--PAREDE BAIXO
	
	if posicao_Do_Jogador1.posicaoY >= 224 and posicao_Do_Jogador1.posicaoX >= -40 and
		posicao_Do_Jogador1.posicaoY <= 225 and posicao_Do_Jogador1.posicaoX <= 155 then
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
	elseif posicao_Do_Jogador1.posicaoY >= 224 and posicao_Do_Jogador1.posicaoX >= 195 and
		posicao_Do_Jogador1.posicaoY <= 225 and posicao_Do_Jogador1.posicaoX <= 400 then
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY
	elseif posicao_Do_Jogador1.posicaoY >= 244 and posicao_Do_Jogador1.posicaoX >= 160 and
			posicao_Do_Jogador1.posicaoY <= 245 and posicao_Do_Jogador1.posicaoX <= 190 then
			sound:stop()
			porta_sound = love.audio.newSource("audio/portaabrir.ogg","stream")
			porta_sound:setLooping(false)
			porta_sound:play()
			fundo = love.graphics.newImage("img/mundo/mapa/mapa04.png")
			posicao_Do_Jogador1.posicaoX = 133
			posicao_Do_Jogador1.posicaoY = 161
			sound = love.audio.newSource("audio/aventura.ogg","stream")
			sound:setLooping(true)
			sound:play()
			
			tp = 5
	else
		posicao_Do_Jogador1.posicaoY = posicao_Do_Jogador1.posicaoY +
		posicao_Do_Jogador1.velocidade + dt
			if dt > 0.035 then
				return
			end
				tempo_De_Animacao = tempo_De_Animacao - dt
					if tempo_De_Animacao <= 0 then
						tempo_De_Animacao = 1 / quantidade_De_Quadros
						quadro = quadro + 1
							if quadro > num_Quadros then
								quadro = 1
							end
								xoffset = 16 * quadro
								jogador1_Recorte:setViewport(xoffset, 36, 16, 18)
					end
	end
end


end




end



function love.draw()
videolib.draw()
love.graphics.draw(pularvideo, 470, 440)
	if tp == 0 then
		love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(selecao, selecaoX, selecaoY)
		
		love.graphics.draw(novojogo, novojogoX, novojogoY)
		love.graphics.draw(novojogo_Selecao, novojogo_SelecaoX, novojogo_SelecaoY)
		
	end

	if tp == 1 then
		love.graphics.draw(fundo, fundoX, funcoY)
		rc:draw(180, 150)
	end
	
	
	if tp == 2 then
		love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(porta_Obj, porta_Obj_Recorte, posicao_Da_porta.posicaoX, posicao_Da_porta.posicaoY, 0, 1.2, 1.2)
		love.graphics.draw(cristal_Obj, cristal_Obj_Recorte, posicao_Do_Obj_Cristal.posicaoX, posicao_Do_Obj_Cristal.posicaoY, 0, 1.2, 1.2)
		love.graphics.draw(galinha_Char, galinha_Recorte, posicao_Da_Galinha.posicaoX, posicao_Da_Galinha.posicaoY, 0, 2, 2)
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
		
		
	end
	
	
	if tp == 3 then
		love.graphics.draw(fundo, fundoX, funcoY)
		
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
	
	end
	
	
		if tp == 4 then
		love.graphics.draw(fundo, fundoX, funcoY)
	
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
		
	end
	
	
	if tp == 5 then
		love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
		
		love.graphics.draw(texto_Evt_01, texto_Evt_01X, texto_Evt_01Y)
		
	end
	
	
	if tp == 6 then
		love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
		--love.graphics.print("X "..posicao_Do_Jogador1.posicaoX, 100, 370)
		--love.graphics.print("Y "..posicao_Do_Jogador1.posicaoY, 100, 400)
		love.graphics.draw(npc.npc_Loja, npc.npc_Loja_Recorte, 175, 100, 0, 2, 2)
		
		
	end
	
	
	
	
	if tp == 7 then
		love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
		love.graphics.draw(texto_Evt_01, texto_Evt_01X, texto_Evt_01Y)
		
	end
	
	if tp == 8 then
		love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(porta_Obj, porta_Obj_Recorte, posicao_Da_porta.posicaoX, posicao_Da_porta.posicaoY, 0, 1.2, 1.2)
		love.graphics.draw(cristal_Obj, cristal_Obj_Recorte, posicao_Do_Obj_Cristal.posicaoX, posicao_Do_Obj_Cristal.posicaoY, 0, 1.2, 1.2)
		love.graphics.draw(galinha_Char, galinha_Recorte, posicao_Da_Galinha.posicaoX, posicao_Da_Galinha.posicaoY, 0, 2, 2)
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
		love.graphics.draw(texto_Evt_01, texto_Evt_01X, texto_Evt_01Y)
		
	end
	
	
		if tp == 98 then
		
		love.graphics.draw(novojogo, novojogoX, novojogoY)
		love.graphics.draw(novojogo_Selecao, novojogo_SelecaoX, novojogo_SelecaoY)
		
	end
		
			if tp == 99 then
		
		love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(inimigo1, inimigo1X, inimigo1Y)
		love.graphics.draw(inimigo2, inimigo2X, inimigo2Y)
		love.graphics.draw(magiaTxt, magiaTxtX, magiaTxtY)
		love.graphics.draw(inimigoTxt1, inimigoTxt1X, inimigoTxt1Y)
		love.graphics.draw(inimigoTxt2, inimigoTxt2X, inimigoTxt2Y)
		love.graphics.print("VIDA: "..vida_Total_Do_Inimigo, 100, 215)
		love.graphics.print("VIDA: "..vida_Total_Do_Inimigo1, 60, 315)
		love.graphics.draw(magiaTxtL, magiaTxtLX, magiaTxtLY)
		
		--love.graphics.print("Vitória:")
		love.graphics.print("Exp: "..sistema.xp, xpX, xpY)
		love.graphics.print("Moeda: "..sistema.dindin, dinX, dinY)
		love.graphics.print("Level: "..sistema.lvl, lvlX, lvlY)
		
		love.graphics.print(sistema.pocao_Cura_J, pocao_Cura_JX, pocao_Cura_JY)
		love.graphics.print(sistema.pocao_Mana_J, pocao_Mana_JX, pocao_Mana_JY)
		
	
		rc:draw(30, 335)
		love.graphics.draw(guerreiro_Batalha, guerreiro_Batalha_Recorte, posicao_Do_Guerreiro_Batalha.posicaoX, posicao_Do_Guerreiro_Batalha.posicaoY, 0, 3, 3)
	
		love.graphics.draw(fundo_Itens, fundo_ItensX, fundo_ItensY)
		love.graphics.draw(seta_Batalha, seta_BatalhaX, seta_BatalhaY)
		love.graphics.draw(fx, fx_Recorte, posicao_Do_Fx.posicaoX, posicao_Do_Fx.posicaoY, 0, 1, 1)
		
		love.graphics.print(vida_Total_Do_Gurreiro, 80, 385)
		--love.graphics.print(vida_Total_Do_Mago, 240, 385)
		--love.graphics.print(vida_Total_Da_Elfa, 390, 385)
				
		love.graphics.print(mana_Guerreiro_Total, 80, 435)
		--love.graphics.print(mana_Mago_Total, 240, 435)
		--love.graphics.print(mana_Elfa_Total, 390, 435)
		
		love.graphics.print("TURNO: "..turno, 470, 330)
		love.graphics.print(sistema.pocao_Cura_J, pocao_Cura_JX, pocao_Cura_JY)
		love.graphics.print(sistema.pocao_Mana_J, pocao_Mana_JX, pocao_Mana_JY)
		love.graphics.draw(fundo_Gameover, fundo_GameoverX, funco_GameoverY)
		
		
		
	end
	
	
	
	if tp == 100 then
	love.graphics.draw(menu_Lctrl, menu_LctrlX, menu_LctrlY)
	love.graphics.draw(seta_Loja, seta_LojaX, seta_LojaY)
	love.graphics.print(sistema.lvl, 200, 40)
	love.graphics.print(sistema.lvl, 200, 130)
	love.graphics.print(sistema.lvl, 200, 220)
	
	love.graphics.print(sistema.ataque_Total_Guerreiro_Print, 210, 65)
	love.graphics.print(sistema.def_Guerreiro_Total_Print, 210, 85)
	love.graphics.print(sistema.ataque_Total_Magia_Guerreiro_Print, 385, 72)
	
	love.graphics.print(sistema.ataque_Total_Mago_Print, 210, 155)
	love.graphics.print(sistema.def_Mago_Total_Print, 210, 178)
	love.graphics.print(sistema.ataque_Total_Magia_Mago_Print, 385, 160)
	
	love.graphics.print(sistema.ataque_Total_Elfa_Print, 210, 240)
	love.graphics.print(sistema.def_Elfa_Total_Print, 210, 262)
	love.graphics.print(sistema.ataque_Total_Magia_Elfa_Print, 385, 245)
	
	
	

	love.graphics.print(sistema.pocao_Cura_J.." Pote", 520, 80)
	love.graphics.print(sistema.pocao_Mana_J.." Pote", 520, 140)
	love.graphics.print(sistema.dindin, 450, 273)
	love.graphics.print(sistema.xp, 330, 273)
	love.graphics.print(eeeG, 180, 372)
	love.graphics.print(eeeM, 380, 372)
	love.graphics.print(eeeE, 600, 372)
	
	end
	
	

	
	if tp == 102 then
	love.graphics.draw(fundo, fundoX, funcoY)
		love.graphics.draw(jogador1_Char, jogador1_Recorte, posicao_Do_Jogador1.posicaoX, posicao_Do_Jogador1.posicaoY, 0, 2, 2)
		--love.graphics.print("X "..posicao_Do_Jogador1.posicaoX, 100, 370)
		--love.graphics.print("Y "..posicao_Do_Jogador1.posicaoY, 100, 400)
		love.graphics.draw(npc.npc_Loja, npc.npc_Loja_Recorte, 175, 100, 0, 2, 2)
		love.graphics.print(sistema.dindin, 490, 208)
		love.graphics.draw(menu_Loja, menu_LojaX, menu_LojaY)
		love.graphics.draw(seta_Loja, seta_LojaX, seta_LojaY)
		love.graphics.print("Ola, tudo bem! O que você deseja comprar?", texto_NpcX, texto_NpcY)
		
	end
	
	if tp == 1000 then
	love.graphics.draw(fundo_Gameover, fundo_GameoverX, funco_GameoverY)
	end
	
end







