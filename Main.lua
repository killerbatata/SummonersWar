--Settings
localPath = scriptPath()

Settings:setCompareDimension(true, 1920)
Settings:setScriptDimension(true, 1920)

--Monstro da esquerda em faimon
LeftMon = Region(165, 282, 240, 240)
--Monstro da direita em faimon
RightMon = Region(573, 282, 240, 240)
--Monstro de baixo em faimon
BottomMon = Region(369, 390, 240, 240)

function dialogo(...)
    dialogInit()
    addRadioGroup("ordemdeExecucao", 1)
    addRadioButton("XP Faimon", 1)
    addRadioButton("Runa Dungeon", 2)
    newRow()
    addCheckBox("energia", "Deseja recarregar as energias durante a execução?", false)
    dialogShowFullScreen("Recarregamento")
end

function recarregarEnergia(...)
        if exists("CaixaDePresente.jpg") then

            click("CaixaDePresente.jpg")

            wait(1)

            if exists("Coletar.jpg") then

                coletar = findAll("Coletar.jpg")

                click(coletar[1])

                waitClick("X.jpg")
            else
                click("X.jpg")
                waitClick("Loja.jpg")
                waitClick("90.jpg")
                waitClick("Sim.jpg")
                waitClick("Ok.jpg")
                waitClick("Fechar.jpg")
            end
        elseif exists("Loja.jpg") then
            click("Loja.jpg")
            waitClick("90.jpg")
            waitClick("Sim.jpg")
            waitClick("Ok.jpg")
            waitClick("Fechar.jpg")
        end
        
        wait(1)
        
        existsClick("Repetir.jpg")
        existsClick("Preparacao.jpg")
end

function iniciarFaimon( ... )

    click("IniciarBatalha.jpg")

    if exists("NaoEnergia.jpg") and energia == true then
        recarregarEnergia()
        waitClick("IniciarBatalha.jpg")
    end

    wait(8)
    
    if exists("Play.jpg") then
        click("Play.jpg")
    end

    --Variavel para sair da repetição de faimon, para ir pra tela de trocar os mob
    time = 0
    
    while time < 1 do
        if exists("Vitoria.jpg") then
            waitClick("Vitoria.jpg")
            waitClick("Bau.jpg")
            wait(2)
            if exists("Vender.jpg") then
                click("Vender.jpg")
                wait(2)
                if exists(Pattern("Sim.jpg"):similar(.5)) then
                    click(Pattern("Sim.jpg"):similar(.5))
                    waitClick(Pattern("Ok.jpg"):similar(.8))
                    wait(1)
                end
            elseif exists(Pattern("Ok.jpg"):similar(.8)) then
                click(Pattern("Ok.jpg"):similar(.8))
            end
            
            if exists("Repetir.jpg") then
                click("Repetir.jpg")
            else
                click("Preparacao.jpg")
                time = time + 1
            end
            
            if energia == true then
                recarregarEnergia()
            end
        
        elseif exists("Derrota.jpg") then
            waitClick("Nao.jpg")
            waitClick("Derrota.jpg")
            waitClick("Preparacao.jpg")
            time = time + 1
        
        else
            wait("Vitoria.jpg" or "Derrota.jpg")
        end
    end
end

--Função do arrastar pra direita em faimon
function moveRight()
    swipe(Location(1200, 750), Location(180, 750))
end

--Função de trocar os mobs em faimon
function trocandoMobsUpados(...)
    --Variavel de armazenar a quantidade de mob foi upado
    quantosMobsForamRetirados = 0
    
    --Nivel 20
    if LeftMon:exists(Pattern("20.jpg"):similar(.8)) or LeftMon:exists(Pattern("20-2.jpg"):similar(.8)) then
        if LeftMon:exists(Pattern("2EstrelasCinza.jpg"):similar(.8)) or LeftMon:exists(Pattern("2EstrelasDouradas.jpg"):similar(.8)) then
            click(LeftMon)
        end
        quantosMobsForamRetirados = quantosMobsForamRetirados + 1
    --Nivel 15
    elseif LeftMon:exists(Pattern("15.jpg"):similar(.8)) then
        if LeftMon:exists(Pattern("1EstrelaCinza.jpg"):similar(.8)) or LeftMon:exists(Pattern("1EstrelaDourada.jpg"):similar(.8)) then
            click(LeftMon)
        end
        quantosMobsForamRetirados = quantosMobsForamRetirados + 1
    end
    
    --Nivel 20
    if RightMon:exists(Pattern("20.jpg"):similar(.8)) or RightMon:exists(Pattern("20-2.jpg"):similar(.8)) then
        if RightMon:exists(Pattern("2EstrelasCinza.jpg"):similar(.8)) or RightMon:exists(Pattern("2EstrelasDouradas.jpg"):similar(.8)) then
            click(RightMon)
        end
        quantosMobsForamRetirados = quantosMobsForamRetirados + 1
    --Nivel 15
    elseif RightMon:exists(Pattern("15.jpg"):similar(.8)) then
        if RightMon:exists(Pattern("1EstrelaCinza.jpg"):similar(.8)) or RightMon:exists(Pattern("1EstrelaDourada.jpg"):similar(.8)) then
            click(RightMon)
        end
        quantosMobsForamRetirados = quantosMobsForamRetirados + 1
    end
    
    --Nivel 20
    if BottomMon:exists(Pattern("20.jpg"):similar(.8)) or BottomMon:exists(Pattern("20-2.jpg"):similar(.8)) then
        if BottomMon:exists(Pattern("2EstrelasCinza.jpg"):similar(.8)) or BottomMon:exists(Pattern("2EstrelasDouradas.jpg"):similar(.8)) then
            click(BottomMon)
        end
        quantosMobsForamRetirados = quantosMobsForamRetirados + 1
    --Nivel 15
    elseif BottomMon:exists(Pattern("15.jpg"):similar(.8)) then
        if BottomMon:exists(Pattern("1EstrelaCinza.jpg"):similar(.8)) or BottomMon:exists(Pattern("1EstrelaDourada.jpg"):similar(.8)) then
            click(BottomMon)
        end
        quantosMobsForamRetirados = quantosMobsForamRetirados + 1
    end
    
    moveRight()
    wait(1)
    moveRight()
    wait(1)
    moveRight()
    wait(1)
    
    --Todas os mobs niveis 1
    if quantosMobsForamRetirados ~= 0 then
        test1 = findAll(Pattern("1.jpg"))
    end
    
    --Loop para colocar os mobs nao upados
    for i = 1, quantosMobsForamRetirados do
        click(test1[i + 1])
        i = i + 1
    end

end

function playDungeon()
    click("IniciarBatalha.jpg")
    
    wait(6)
    
    existsClick("Play.jpg")
    
    time = 0
    
    while time < 1 do
        if exists("Vitoria.jpg") then    

            wait(2)      
              
            click("Vitoria.jpg")
            
            waitClick("Bau.jpg")
            
            waitClick("Ok.jpg")
            
            wait(1)
            
            existsClick("Repetir.jpg")
            
            if energia == true and exists("NaoEnergia.jpg") then
                recarregarEnergia()
            end
        
        elseif exists("Nao.jpg") then
           
            waitClick("Nao.jpg")
           
            waitClick("Derrota.jpg")
           
            waitClick("Preparacao.jpg")
            time = time + 1
        end
    end
end

--Variavel para o loop infinito
infinito = 0

--Meu main infinito
dialogo()

while infinito < 1 do
    if ordemdeExecucao == 1 then
        iniciarFaimon()
        trocandoMobsUpados()
    elseif ordemdeExecucao == 2 then
        playDungeon()
    end
end