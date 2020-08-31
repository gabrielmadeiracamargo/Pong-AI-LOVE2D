push = require 'push' -- Transforma a janela física em virtual

Class = require 'class'

require 'Paddle'

require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load() -- Inicia o gamestate no começo da execução do programa, equivalente ao método construtor do Java ou Create do GameMaker.
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)

    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    love.window.setTitle("Crazy Pong!")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
                     {
        fullscreen = false,
        resizable = false,
        vsync = true -- Sincronizado com a taxa de atualização do monitor.
    })

    player1Score = 0
    player2Score = 0

    player1 = Paddle(10,30,5,20)
    player2 = Paddle(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT - 30, 5 , 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    --Abreviações de delta time.

    gameState = 'start'
end --COLOCAR END E FUNCTION NAS FUNÇÕES


function love.draw() -- Também executado a cada frame, essa função desenha na tela. Equivalente ao Render do Java e Draw do GameMaker.
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if gameState == 'play' then
    love.graphics.printf('Crazy Pong!', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Press Enter to start!', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
    end
    -- Primeira raquete
    player1:render()

    -- Segunda raquete (Inimigp)
    player2:render()

    -- Bola
    ball:render()

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    displayFPS()

    push:apply('end')
end

function displayFPS()
love.graphics.setFont(smallFont)
love.graphics.setColor(0,255/255,0,255/255)
love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()),10,10)
--o .. serve pra concatenar as strings.
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current Y scaled by deltaTime
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current Y scaled by deltaTime
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key) 
    if key == 'escape' then 
        love.event.quit() 
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else gameState = 'start'

            ball:reset()

            --[[
                1. Ele garante que cada vez que você chamar math.random, ele produza um resultado diferente
                2. equivalente a:
                se math.random (2) == 1 então
                        ballDX = 100
                            else
                        ballDX = -100
                onde math.random (2) dá 1 ou 2
                3. dá um número inteiro entre -50 e 50
            --]]

        end
    end
end

--Fim do código, comentários abaixo

--[[
    
    Funções importantes pong-0

love.graphics.printf() É equivalente ao System.out.println(); do Java ou show_debug_message(), mas permite desenhar fisicamente na tela.

love.window.setMode() É usado pra inicializar as dimensões da janela e setar parâmetros como vsync, fullscren, redimensionar a janela, etc.



    Funções importantes pong-1

 love.graphics.setDefaultFilter (min, mag)  Define o filtro de escala de textura ao minimizar e ampliar texturas e fontes; o padrão é bilinear, o que causa
embaçamento e, para nossos casos de uso, normalmente queremos a filtragem do vizinho mais próximo ('mais próximo'), o que resulta em perfeita
aumento e redução de pixel, simulando uma sensação retro.

 love.keypressed (comando)Uma função de retorno de chamada LÖVE2D que executa sempre que pressionamos uma tecla, assumindo que implementamos isso em nosso
main.lua, na mesma linha de love.load (), love.update (dt) e love.draw ().
● love.event.quit ()
-Função simples que encerra o aplicativo.



    Funções importantes pong-2

love.graphics.newFont (caminho, tamanho) Define uma fonte nova

love.graphics.setFont (fonte) Ajusta a fonte atualmente ativa de LÖVE2D (da qual só pode haver uma de cada vez) para um objeto de fonte passado que nós
pode criar usando love.graphics.newFont.

love.graphics.clear (r, g, b, a)
-Limpa a tela inteira com uma cor definida por um conjunto RGBA, cada componente sendo de 0-255.

love.graphics.rectangle (modo, x, y, largura, altura)
- Desenha um retângulo na tela usando qualquer que seja nossa cor ativa (love.graphics.setColor, que nós
não precisa usar neste projeto específico, já que quase tudo é branco, a cor LÖVE2D padrão). modo pode ser definido para
‘Preencher’ ou ‘linha’, que resulta em um retângulo preenchido ou não-preebcgudi, respectivamente, e os outros quatro parâmetros são seus
posição e dimensões de tamanho. Esta é a função de desenho fundamental de toda a nossa implementação Pong!



    Funções importantes pong-3

 love.keyboard.isDown (chave)

-Retorna verdadeiro ou falso dependendo se a tecla especificada está pressionada; é diferente de
love.keypressed (key) em que isso pode ser chamado arbitrariamente e retornará continuamente verdadeiro se a tecla for pressionada,
onde love.keypressed (key) só disparará seu código uma vez sempre que a tecla for pressionada inicialmente. No entanto, já que nós
queremos ser capazes de mover nossas pás para cima e para baixo segurando as teclas apropriadas, precisamos de uma função para testar
períodos mais longos de entrada, portanto, o uso de love.keyboard.isDown (tecla)!

    Funções importantes pong-4
math.randomseed(num)
- ”Planta" o gerador de números aleatórios usado por Lua (math.random) com algum valor tal que sua aleatoriedade é
dependente desse valor fornecido, o que nos permite passar em números diferentes a cada jogada para garantir
inconsistência em diferentes execuções de programas (ou uniformidade se quisermos um comportamento consistente para teste).
os.time ()
Função -Lua que retorna, em segundos, o horário desde 00:00:00 UTC de 1º de janeiro de 1970, também conhecido como Unix epoch time
(https://en.wikipedia.org/wiki/Unix_time).
math.random (min, max)
-Retorna um número aleatório, dependente do gerador de número aleatório propagado, entre o mínimo e o máximo,
inclusive.
math.min (num1, num2)
-Retorna o menor dos dois números passados.
math.max (num1, num2)
-Retorna o maior dos dois números passados.

    Funções importantes pong-5
            ...

Funções importantes pong-6

love.window.setTitle (título)
Simplesmente define o título da janela do nosso aplicativo, adicionando um leve nível de polimento.
love.timer.getFPS ()
-Retorna o FPS atual de nosso aplicativo, facilitando o monitoramento quando impresso.
--]]