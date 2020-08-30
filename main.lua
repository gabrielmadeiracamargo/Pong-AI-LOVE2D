push = require 'push' -- Transforma a janela física em virtual

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load() -- Inicia o gamestate no começo da execução do programa, equivalente ao método construtor do Java ou Create do GameMaker.
    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('font.ttf', 8)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
                     {
        fullscreen = false,
        resizable = false,
        vsync = true -- Sincronizado com a taxa de atualização do monitor.
    })
end -- COLOCAR END E FUNCTION NAS FUNÇÕES
-- love.update(dt) Executado a cada frame usando o delta time. Equivalente ao Tick do Java e Step do GameMaker.

function love.draw() -- Também executado a cada frame, essa função desenha na tela. Equivalente ao Render do Java e Draw do GameMaker.
    push:apply('start')
    love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')

    --love.graphics.clear(40, 45, 52, 255)

    -- Primeira raquete
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- Segunda raquete (Inimigp)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- Bola
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

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
-Função simples que encerra o aplicativo.

--]]

--[[    Funções importantes pong-2

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

]]
