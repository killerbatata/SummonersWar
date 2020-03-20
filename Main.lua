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
--Nao sei se ta certa essa regiao
resultRegion = Region(1580, 200, 700, 250)

winCount = 0
loseCount = 0

function showBattleResult()
    local message = ""
    local totalBattle = loseCount + winCount
    message = message .. [[Battles:]] .. totalBattle .. "  W:" .. winCount .. "  L:" .. loseCount
    resultRegion:highlightOff()
    resultRegion:highlight(message)
end

function dialogo(...)
    dialogInit()
    spinnerFarm = {
        "Dungeon",
        "Faimon",
        "Toa"
    }
    spinnerEnergy = {
        "Caixa De Energia",
        "Loja"
    }
    addTextView("Farming Mode: ")
    addSpinner("farm", spinnerFarm, spinnerFarm[1])
    newRow()
    addCheckBox("energia", "Deseja recarregar as energias durante a execução?", false)
    newRow()
    addTextView("Energy Mode: ")
    addSpinner("energy", spinnerEnergy, spinnerEnergy[1])
    dialogShowFullScreen("Recarregamento")
end

function dialogo2(...)
    dialogInit()
    addCheckBox("mob1", "Mob 1*", false)
    addCheckBox("mob2", "Mob 2*", false)
    addCheckBox("mob3", "Mob 3*", false)
    addCheckBox("mob4", "Mob 4*", false)
    addCheckBox("mob5", "Mob 5*", false)
    addCheckBox("mob6", "Mob 6*", false)
    dialogShowFullScreen("faimon")
end

function recarregarEnergia(...)
    if energy == spinnerEnergy[1] then
        if exists("CaixaDePresente.jpg") then
            
            click("CaixaDePresente.jpg")
            
            wait(1)
            
            if exists("Coletar.jpg") then
                
                coletar = findAll("Coletar.jpg")
                
                click(coletar[1])
                
                waitClick("X.jpg")
            end
        end
        
        wait(1)
        
        existsClick("Repetir.jpg")
        existsClick("Preparacao.jpg")
        existsClick("IniciarBatalha.jpg")
    end
    
    if energy == spinnerEnergy[2] then
        if exists("Loja.jpg") then
            click("Loja.jpg")
            waitClick("90.jpg")
            waitClick("Sim.jpg")
            waitClick("Ok.jpg")
            waitClick("Fechar.jpg")
            existsClick("Repetir.jpg")
            existsClick("Preparacao.jpg")
        end
    end
end

function iniciarFaimon(...)
    
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
            winCount = winCount + 1
            showBattleResult()
            wait(2)
            click("Vitoria.jpg")
            waitClick("Bau.jpg")
            g = 0
            while g < 1 do
                if exists("Vender.jpg") then
                    click("Vender.jpg")
                    wait(2)
                    if exists(Pattern("Sim.jpg"):similar(.5)) then
                        click(Pattern("Sim.jpg"):similar(.5))
                        wait(1)
                        existsClick(Pattern("Ok.jpg"):similar(.8))
                        wait(1)
                    end
                    g = g + 1
                elseif exists(Pattern("Ok.jpg"):similar(.8)) then
                    click(Pattern("Ok.jpg"):similar(.8))
                    g = g + 1
                end
            end
            g = 0
            while g < 1 do
                if exists("Repetir.jpg") then
                    click("Repetir.jpg")
                    g = g + 1
                elseif exists("Preparacao.jpg") then
                    click("Preparacao.jpg")
                    g = g + 1
                    time = time + 1
                end
            end
            
            if exists("NaoEnergia.jpg") and energia == true then
                recarregarEnergia()
            end
        elseif exists("Derrota.jpg") then
            loseCount = loseCount + 1
            showBattleResult()
            waitClick("Nao.jpg")
            waitClick("Derrota.jpg")
            waitClick("Preparacao.jpg")
            time = time + 1
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
    
    if mob1 == true then
        if LeftMon:exists(Pattern("15.jpg"):similar(.8)) then
            if LeftMon:exists(Pattern("1EstrelaCinza.jpg"):similar(.8)) or LeftMon:exists(Pattern("1EstrelaDourada.jpg"):similar(.8)) then
                click(LeftMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if RightMon:exists(Pattern("15.jpg"):similar(.8)) then
            if RightMon:exists(Pattern("1EstrelaCinza.jpg"):similar(.8)) or RightMon:exists(Pattern("1EstrelaDourada.jpg"):similar(.8)) then
                click(RightMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if BottomMon:exists(Pattern("15.jpg"):similar(.8)) then
            if BottomMon:exists(Pattern("1EstrelaCinza.jpg"):similar(.8)) or BottomMon:exists(Pattern("1EstrelaDourada.jpg"):similar(.8)) then
                click(BottomMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
    end
    
    if mob2 == true then
        if LeftMon:exists(Pattern("20.jpg"):similar(.8)) or LeftMon:exists(Pattern("20-2.jpg"):similar(.8)) then
            if LeftMon:exists(Pattern("2EstrelasCinza.jpg"):similar(.8)) or LeftMon:exists(Pattern("2EstrelasDouradas.jpg"):similar(.8)) then
                click(LeftMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if RightMon:exists(Pattern("20.jpg"):similar(.8)) or RightMon:exists(Pattern("20-2.jpg"):similar(.8)) then
            if RightMon:exists(Pattern("2EstrelasCinza.jpg"):similar(.8)) or RightMon:exists(Pattern("2EstrelasDouradas.jpg"):similar(.8)) then
                click(RightMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if BottomMon:exists(Pattern("20.jpg"):similar(.8)) or BottomMon:exists(Pattern("20-2.jpg"):similar(.8)) then
            if BottomMon:exists(Pattern("2EstrelasCinza.jpg"):similar(.8)) or BottomMon:exists(Pattern("2EstrelasDouradas.jpg"):similar(.8)) then
                click(BottomMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
    end
    
    if mob3 == true then
        if LeftMon:exists(Pattern("25.jpg"):similar(.8)) then
            if LeftMon:exists(Pattern("3EstrelaCinza.jpg"):similar(.8)) or LeftMon:exists(Pattern("3EstrelaDourada.jpg"):similar(.8)) then
                click(LeftMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if RightMon:exists(Pattern("25.jpg"):similar(.8)) then
            if RightMon:exists(Pattern("3EstrelaCinza.jpg"):similar(.8)) or RightMon:exists(Pattern("3EstrelaDourada.jpg"):similar(.8)) then
                click(RightMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if BottomMon:exists(Pattern("25.jpg"):similar(.8)) then
            if BottomMon:exists(Pattern("3EstrelaCinza.jpg"):similar(.8)) or BottomMon:exists(Pattern("3EstrelaDourada.jpg"):similar(.8)) then
                click(BottomMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
    end
    
    if mob4 == true then
        if LeftMon:exists(Pattern("30.jpg"):similar(.8)) then
            if LeftMon:exists(Pattern("4EstrelaCinza.jpg"):similar(.8)) or LeftMon:exists(Pattern("4EstrelaDourada.jpg"):similar(.8)) then
                click(LeftMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if RightMon:exists(Pattern("30.jpg"):similar(.8)) then
            if RightMon:exists(Pattern("4EstrelaCinza.jpg"):similar(.8)) or RightMon:exists(Pattern("4EstrelaDourada.jpg"):similar(.8)) then
                click(RightMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if BottomMon:exists(Pattern("30.jpg"):similar(.8)) then
            if BottomMon:exists(Pattern("4EstrelaCinza.jpg"):similar(.8)) or BottomMon:exists(Pattern("4EstrelaDourada.jpg"):similar(.8)) then
                click(BottomMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
    end
    
    if mob5 == true then
        if LeftMon:exists(Pattern("35.jpg"):similar(.8)) then
            if LeftMon:exists(Pattern("5EstrelaCinza.jpg"):similar(.8)) or LeftMon:exists(Pattern("5EstrelaDourada.jpg"):similar(.8)) then
                click(LeftMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if RightMon:exists(Pattern("35.jpg"):similar(.8)) then
            if RightMon:exists(Pattern("5EstrelaCinza.jpg"):similar(.8)) or RightMon:exists(Pattern("5EstrelaDourada.jpg"):similar(.8)) then
                click(RightMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if BottomMon:exists(Pattern("35.jpg"):similar(.8)) then
            if BottomMon:exists(Pattern("5EstrelaCinza.jpg"):similar(.8)) or BottomMon:exists(Pattern("5EstrelaDourada.jpg"):similar(.8)) then
                click(BottomMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
    end
    
    if mob6 == true then
        if LeftMon:exists(Pattern("40.jpg"):similar(.8)) then
            if LeftMon:exists(Pattern("6EstrelaDourada.jpg"):similar(.8)) then
                click(LeftMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if RightMon:exists(Pattern("40.jpg"):similar(.8)) then
            if RightMon:exists(Pattern("6EstrelaDourada.jpg"):similar(.8)) then
                click(RightMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
        if BottomMon:exists(Pattern("40.jpg"):similar(.8)) then
            if BottomMon:exists(Pattern("6EstrelaDourada.jpg"):similar(.8)) then
                click(BottomMon)
            end
            quantosMobsForamRetirados = quantosMobsForamRetirados + 1
        end
    end
    
    if quantosMobsForamRetirados > 0 then
        moveRight()
        wait(1)
        moveRight()
        wait(1)
        moveRight()
        wait(1)
        moveRight()
        wait(1)
        
        test1 = findAll(Pattern("1.jpg"))
        
        --Loop para colocar os mobs nao upados
        for i = 1, quantosMobsForamRetirados do
            h = i - 1
            click(test1[#test1 - h])
            i = i + 1
        end
    end

end

function playDungeon()
    click("IniciarBatalha.jpg")
    
    wait(6)
    
    existsClick("Play.jpg")
    
    time = 0
    
    while time < 1 do
        if exists("Vitoria.jpg") then
            winCount = winCount + 1
            showBattleResult()
            wait(2)
            
            click("Vitoria.jpg")
            
            waitClick("Bau.jpg")
            
            waitClick("Ok.jpg")
            
            wait(1)
            
            waitClick("Repetir.jpg")
            
            if exists("NaoEnergia.jpg") and energia == true then
                recarregarEnergia()
            end
        
        elseif exists("Nao.jpg") then
            loseCount = loseCount + 1
            showBattleResult()
            waitClick("Nao.jpg")
            
            waitClick("Derrota.jpg")
            
            waitClick("Preparacao.jpg")
            if exists("NaoEnergia.jpg") and energia == true then
                recarregarEnergia()
            end
            time = time + 1
        end
    end
end

function playToa()
    click("IniciarBatalha.jpg")

    if exists("NaoEnergia.jpg") and energia == true then
        recarregarEnergia()
    end
    
    wait(6)
    
    existsClick("Play.jpg")
    
    time = 0
    
    while time < 1 do
        if exists("Vitoria.jpg") then
            winCount = winCount + 1
            showBattleResult()
            wait(2)
            
            click("Vitoria.jpg")
            
            waitClick("Bau.jpg")

            wait(2)
            
            click("Ok.jpg")
            
            wait(1)
            
            waitClick("ProximaFase.jpg")

            if exists("NaoEnergia.jpg") and energia == true then
                recarregarEnergia()
            end

            waitClick("IniciarBatalha.jpg")
        
        elseif exists("Derrota.jpg") then
            loseCount = loseCount + 1
            showBattleResult()
            
            waitClick("Derrota.jpg")
            
            waitClick("Preparacao.jpg")
            if exists("NaoEnergia.jpg") and energia == true then
                recarregarEnergia()
            end
            time = time + 1
        end
    end
end

--Variavel para o loop infinito
infinito = 0

--Meu main infinito
dialogo()
if farm == spinnerFarm[2] then
    dialogo2()
end

while infinito < 1 do
    if farm == spinnerFarm[2] then
        iniciarFaimon()
        trocandoMobsUpados()
    elseif farm == spinnerFarm[1] then
        playDungeon()
    elseif farm == spinnerFarm[3] then
        playToa()
    end
end
