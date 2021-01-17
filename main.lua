--/ ---------------------------------------------
--/               BACK TO SPACE
--/ ---------------------------------------------
--/ Editor : Alpha Kilo - Games Studio
--/ Developper : Alain Kelleter - alain@ktdev.pro
--/ As Xoran Sorvor - xoran@xoransorvor.be
--/ Website : www.alphakilo.games
--/ Date : 2021
--/ Version : v1.0.0    17/01/2021 17:22
--/ ---------------------------------------------
--/ External Library:
--/ CRON : https://github.com/kikito/cron.lua
--/ ---------------------------------------------


--/ ----------------------------------------------------
--/ INIT -----------------------------------------------
--/ ----------------------------------------------------

--/ Autorise ou non l'affichage des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

--/ Empèche Love de filtrer les contours des images quand elles sont redimentionnées
--/ Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

--/ Chargement de la librairie de debugging si le mode est actif
local modeDebug = false    -- true or false
if modeDebug then
  --/ Chargement de la librairie libDebug (Debugging Lib)
  oDBG = require("libs/libDebug")
  --/ Initialisation d'une liste de chaînes à débugger
  sDebug = {}
end

--/ Chargement des librairies
oLAP = require("libs/libApp")
oCron = require("extLibs/cron")

local keypressed = 1

--/ 1 =  il n'y a pas 5 éléments dans l'inventaire
displayStatus = 0

--/ Affichage des messages dynamiques
displayShow = true

--/ Soluce du jeu
soluce = nil

--/ Restart du jeu
restart = false

--/ Configuration de la génération de nombres aléatoires
math.randomseed(love.timer.getTime())

--/ ----------------------------------------------------
--/ LOVE LOAD ------------------------------------------
--/ ----------------------------------------------------
function love.load()
 
  --/ Initialisation du jeu
  oLAP.initGame(1)

  --/ Dimensionnement de la fenêtre de jeu
  love.window.setMode(oLAP.getWindow().width, oLAP.getWindow().height)

  --/ Initialisation du titre de la fenêtre du jeu
  love.window.setTitle(oLAP.getWindow().title)

  displayCounter = oCron.after(3,function() displayShow = false end)

end

--/ ----------------------------------------------------
--/ LOVE UPDATE ----------------------------------------
--/ ----------------------------------------------------
function love.update(dt)

  --/ Met à jour le compteur avec le delta times
  displayCounter:update(dt)

end

--/ ----------------------------------------------------
--/ LOVE DRAW ------------------------------------------
--/ ----------------------------------------------------
function love.draw()
  
  --/ Couleurs
  local colorOrange = {1, 0.32, 0, 1} 
  local colorWhite = {1, 1, 1, 1}
  local colorGreen = {0.76, 0.95, 0.11, 1}

  oLAP.drawObjectsList(oLAP.objects.index)
  oLAP.drawPresentation() 
  oLAP.drawHUDInfosObject(oLAP.objects.index)
  oLAP.drawHUDSelection()
  oLAP.drawObjectsListSelected()

  --/DEBUG/AFFICHE TOUCHE PRESSEE : oLAP.drawMessage(keypressed, 500, 500)

  if(table.getn(oLAP.selectedObjects) >= 5) then
    oLAP.drawMessage("Votre inventaire est plein", 475, 390, colorOrange)
    oLAP.drawMessage("Appuye sur \"C\" pour tester ta solution", 425, 410, colorWhite)    
    oLAP.drawMessage("(Il existe 10 solutions différentes)", 440, 430, colorWhite)    
  else 
    if displayShow then
      if displayStatus == 1 then        
        oLAP.drawMessage("Il faut 5 objets dans l'inventaire pour calculer une solution", 370, 430)                          
      end 
    end
  end

  --/ Gestiond du message affiché à l'issue du Crafting
  if soluce ~= nil and restart == false then
    if soluce[0] then
      color = colorGreen
      oLAP.drawMessage("YOU WIN :)", 15, 500, color) 
    else
      oLAP.drawMessage("YOU LOST :(", 15, 500, color) 
      color = colorWhite
    end 

    oLAP.drawMessage(soluce[1], 15, 520, color) 
    oLAP.drawMessage("Appuye sur la touche \"R\" pour tester une autre solution", 15, 540, colorOrange)
  end

  --/  Debug section -----------------------------------
  if modeDebug then    
    --/ Display Debug Zone
    oDBG.draw(sDebug, 400, 500, "yellow")
  end --/ End Debug section ------------------------------

  


end

--/ ----------------------------------------------------
--/ LOVE KEYPRESSED ------------------------------------
--/ ----------------------------------------------------
function love.keypressed(key)

  keypressed = key
  
  if key == "up" then
    if oLAP.objects.index == 1 then
      oLAP.objects.index = 20
    else
      oLAP.objects.index = oLAP.objects.index - 1
    end
  end
  
  if key == "down" then
    if oLAP.objects.index == 20 then
      oLAP.objects.index = 1
    else
      oLAP.objects.index = oLAP.objects.index + 1
    end  
  end

  if key == "return" or key == "kpenter" then
    --/ Si l'objet existe déjà on le supprime
    if oLAP.objectExistInList(oLAP.objects.index) then
      oLAP.removeObject(oLAP.objects.index)
    else
      --/ Ajout maximum 5 objets
      if(table.getn(oLAP.selectedObjects) < 5) then
        oLAP.addObject(oLAP.objects.index)
      end
    end
  end

  --/ L'appui sur la touche C calcule la solution du jeu
  if key == 'c' then
    if(table.getn(oLAP.selectedObjects) == 5) then
      checkSoluce()
      restart = false
    else
      displayStatus = 1 -- au moins 5 objets
      loadDisplayCounter(3)  -- pendant 3sec
    end
  end

  --/ L'appui sur la touche C calcule la solution du jeu
  if key == 'r' then
    oLAP.restart()
    restart = true
  end

  if key == "escape" then
    love.event.quit()
  end
  
end

--/ Charge le timer de l'afficahge des messages dynamiques
function loadDisplayCounter(sec)
  displayCounter = oCron.after(sec, function() displayShow = false end) 
  displayShow = true
end

function checkSoluce()
  soluce = oLAP.checkCraftingSoluce()
end