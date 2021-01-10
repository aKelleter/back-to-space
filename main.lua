--/ ---------------------------------------------
--/         Gamecodeur Weekex Crafting
--/               BACK TO SPACE
--/ ---------------------------------------------
--/ Editor : Alpha Kilo - Games Studio
--/ Developper : Alain Kelleter - alain@ktdev.pro
--/ As Xoran Sorvor - xoran@xoransorvor.be
--/ Website : www.alphakilo.games
--/ Date : 2021
--/ Version : v0.0.1    10/01/2021 21:42
--/ ---------------------------------------------
--/ Colors Table
--/ rgb(194,243,30) vert lime (0.76, 0.95, 0.11)
--/ rgb(255,100,100) rouge fraise (1, 0.39, 0.39)
--/ rgb(255,81,0) orange (1, 0.32, 0)
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
local modeDebug = true    -- true or false
if modeDebug then
  --/ Chargement de la librairie libDebug (Debugging Lib)
  oDBG = require("libDebug")
  --/ Initialisation d'une liste de chaînes à débugger
  sDebug = {}
end

--/ Chargement des librairies
oLAP = require("libApp")



--/ Configuration de la génération de nombres aléatoires
--/ math.randomseed(love.timer.getTime())

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

end

--/ ----------------------------------------------------
--/ LOVE UPDATE ----------------------------------------
--/ ----------------------------------------------------
function love.update(dt)
  

end

--/ ----------------------------------------------------
--/ LOVE DRAW ------------------------------------------
--/ ----------------------------------------------------
function love.draw()
  
  oLAP.drawObjectsList(oLAP.objects.index)
  oLAP.drawPresentation() 
  oLAP.drawHUD(oLAP.objects.index)
  oLAP.drawSelection()
  oLAP.drawObjectsListSelected()

  if(table.getn(oLAP.selectedObjects) >= 5) then
    oLAP.drawMessage("Votre inventaire est plein")
  end
      
end

--/ ----------------------------------------------------
--/ LOVE KEYPRESSED ------------------------------------
--/ ----------------------------------------------------
function love.keypressed(key)
  
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
  
end