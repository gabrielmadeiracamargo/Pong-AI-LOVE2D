WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load() --Inicia o gamestate no começo da execução do programa, equivalente ao método construtor do Java ou Create do GameMaker.
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false,
        resizable = false,
        vsync = true --Sincronizado com a taxa de atualização do monitor.
    })
end --COLOCAR END E FUNCTION NAS FUNÇÕES
--love.update(dt) Executado a cada frame usando o delta time. Equivalente ao Tick do Java e Step do GameMaker.

function love.draw() --Também executado a cada frame, essa função desenha na tela. Equivalente ao Render do Java e Draw do GameMaker.
love.graphics.printf(
    'Hello Pong!',           --Renderiza o Texto
    0,                       -- X, 0 porque queremos alinhar ele
    WINDOW_HEIGHT / 2 - 6,   -- Y, divide a altura por 2 (pra centralizar) menos 6 (porque o tamanho padrão da altura da fonte do LOVE2D é 12), pro texto ficar no meio da tela.
    WINDOW_WIDTH,            -- "Número de pixels pra centralizar dentro" (?)
    'center')                -- Simplesmente alinha no centro
end
--love.graphics.printf() É equivalente ao System.out.println(); do Java ou show_debug_message(), mas permite desenhar fisicamente na tela.

--love.window.setMode() É usado pra inicializar as dimensões da janela e setar parâmetros como vsync, fullscren, redimensionar a janela, etc.

