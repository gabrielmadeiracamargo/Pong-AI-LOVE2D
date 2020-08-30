push = require 'push' -- Transforma a janela física e virtual

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load() -- Inicia o gamestate no começo da execução do programa, equivalente ao método construtor do Java ou Create do GameMaker.
    love.graphics.setDefaultFilter('nearest','nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true -- Sincronizado com a taxa de atualização do monitor.
    })
end -- COLOCAR END E FUNCTION NAS FUNÇÕES
-- love.update(dt) Executado a cada frame usando o delta time. Equivalente ao Tick do Java e Step do GameMaker.

function love.draw() -- Também executado a cada frame, essa função desenha na tela. Equivalente ao Render do Java e Draw do GameMaker.
    push:apply('start')
    love.graphics.printf('Hello Pong!', -- Renderiza o Texto
    0, -- X, 0 porque queremos alinhar ele
    VIRTUAL_HEIGHT / 2 - 6, -- Y, divide a altura por 2 (pra centralizar) menos 6 (porque o tamanho padrão da altura da fonte do LOVE2D é 12), pro texto ficar no meio da tela.
    VIRTUAL_WIDTH, 'center') -- Simplesmente alinha no centro
    push:apply('end')
end

function love.keypressed(key) if key == 'escape' then love.event.quit() end end

--[[    Funções importantes pong-0

love.graphics.printf() É equivalente ao System.out.println(); do Java ou show_debug_message(), mas permite desenhar fisicamente na tela.

love.window.setMode() É usado pra inicializar as dimensões da janela e setar parâmetros como vsync, fullscren, redimensionar a janela, etc.
--]]

--[[    Funções importantes pong-1

 love.graphics.setDefaultFilter (min, mag)  Define o filtro de escala de textura ao minimizar e ampliar texturas e fontes; o padrão é bilinear, o que causa
embaçamento e, para nossos casos de uso, normalmente queremos a filtragem do vizinho mais próximo ('mais próximo'), o que resulta em perfeita
aumento e redução de pixel, simulando uma sensação retro.

 love.keypressed (comando)Uma função de retorno de chamada LÖVE2D que executa sempre que pressionamos uma tecla, assumindo que implementamos isso em nosso
main.lua, na mesma linha de love.load (), love.update (dt) e love.draw ().
● love.event.quit ()
-Função simples que encerra o aplicativo.]]
