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
--/ Colors Table
--/ rgb(194,243,30) vert lime (0.76, 0.95, 0.11)
--/ rgb(255,100,100) rouge fraise (1, 0.39, 0.39)
--/ rgb(255,81,0) orange (1, 0.32, 0)
--/ ---------------------------------------------

--/ Init de la librairie (PlatFormer Lib)
local LBAp = {}

--/ Déclaration et intialisation des propriétés de la librairie
local window = {}                        -- Paramètres de la fenêtre

--/ Définition des Constantes
local version = "1.0.0"
local DEF_W_TITLE = "Back To Space"      -- Titre fenêtre
local DEF_W_WIDTH = 900                  -- Largeur fenêtreà
local DEF_W_HEIGHT = 600                 -- Hauteur fenêtre


LBAp.objects = {}

--/ Propriétés des objets : [1] = Nom (str), [2] = Associable (bool), [3] = Type (str), [4] =Type d'Associabilité (str), [5] = Icône (str)

LBAp.objects[1] = { "Un moniteur", true, "Objet", "Ordinateur", "moniteur.png" }
LBAp.objects[2] = { "Un clavier", true, "Objet", "Ordinateur", "clavier.png" }
LBAp.objects[3] = { "Une unité centrale", true, "Objet", "Ordinateur", "uc.png" }
LBAp.objects[4] = { "Une souris", true, "Objet", "Ordinateur", "souris.png" }
LBAp.objects[5] = { "Une lampe de bureau", true, "Objet", "Bureau", "lampe.png" }
LBAp.objects[6] = { "Un vieux bureau en bois", true, "Objet", "Bureau", "bureau.png" }
LBAp.objects[7] = { "Une chaise de bureau", true, "Objet", "Bureau", "chaise.png" }
LBAp.objects[8] = { "Une jolie secrétaire", true, "Personnage", "Humain", "secretaire.png" }
LBAp.objects[9] = { "Un épagneul breton", true, "Personnage", "Animal", "chien.png" }
LBAp.objects[10] = { "Un extraterrestre", true, "Personnage", "Non Humain", "et.png" }
LBAp.objects[11] = { "Un vaisseau extraterrestre", true, "Objet", "Non Humain", "vaisseau.png" }
LBAp.objects[12] = { "Un téléphone à cadran", true, "Objet", "Bureau", "telephone.png" }
LBAp.objects[13] = { "Un document secret", true, "Objet", "Arme", "document.png" }
LBAp.objects[14] = { "Un savant fou", false, "Personnage", "Humain", "savant.png" }
LBAp.objects[15] = { "Une trousse à outils", false, "Objet", "Outils", "outils.png" }
LBAp.objects[16] = { "Un laser longue portée", false, "Objet", "Arme", "laser.png" }
LBAp.objects[17] = { "Un trou de ver", false, "Objet", "Naturel", "troudever.png" }
LBAp.objects[18] = { "Un ingénieur de la Nasa", true, "Personnage", "Humain", "ingenieur.png" }
LBAp.objects[19] = { "Un cosmonaute Russe", true, "Personnage", "Humain", "cosmonaute.png" }
LBAp.objects[20] = { "Un groupe électrogène", true, "Objet", "Outils", "groupelectro.png" }

LBAp.objects.index = 1

LBAp.strIntro = {}
LBAp.strIntro[1] = "Un vaisseau extraterrestre s'est écrasé dans le désert du Nevada."
LBAp.strIntro[2] = "Un être venu d'ailleurs d'apparence humanoïde en sort et souhaite rapidement réparer son vaisseau pour repartir."
LBAp.strIntro[3] = "Aidez-le a trouver une solution en lui fournissant les outils nécessaires à la mise en oeuvre de son plan de retour."

LBAp.selectedObjects = {}

--/ ----------------------------------------------------
--/ LOADING --------------------------------------------
--/ ----------------------------------------------------

--[[  Initialisation du jeu
      Chargement du niveau passé en paramètre
  ]] 
function LBAp.initGame()

  --/ Initialisation des paramètres de la fenêtre
  window.title = DEF_W_TITLE
  window.width = DEF_W_WIDTH
  window.height = DEF_W_HEIGHT 
  
  -- font = love.graphics.newFont("fonts/earlyGameBoy.ttf", 12)
  -- font = love.graphics.newFont("fonts/retroGaming.ttf", 12)
  -- font = love.graphics.newFont("fonts/8bitWonder.ttf", 12)
  font = love.graphics.newFont("fonts/pixellari.ttf", 15)
  love.graphics.setFont(font)
 
end --/ END FCT initGame()

--/ ----------------------------------------------------
--/ ACTIONS --------------------------------------------
--/ ----------------------------------------------------

--/ Ajoute un objet à la liste
function LBAp.addObject(pIndex)
  table.insert(LBAp.selectedObjects, pIndex)
end

--/ Supprime un objet de la liste
function LBAp.removeObject(pIndex)
  for n,v in ipairs(LBAp.selectedObjects) do
    if pIndex == v then
      table.remove(LBAp.selectedObjects, n)    
    end   
  end
end

function LBAp.checkCraftingSoluce()

  local objExist = 0
  
  local soluces = {}
  soluces[1] = {{10,11,17,18,19},{"Notre ami extraterrestre retourne chez lui à la façon d'un blockbuster Hollywoodien. Merci Bruce Willis!"}} -- Film hollywoodien 
  soluces[2] = {{8,9,10,11,17},{"\"ET\" est venu chercher une femme et un chien pour se faire une petit vie pépère de retour chez lui (ou pas) :)"}}     -- Femme+chien = vie bien rangée
  soluces[3] = {{10,11,12,15,17},{"E...Li...ot, \"ET\" téléphone maiiiiison..."}}   -- ET téléphone maison
  soluces[4] = {{7,10,13,14,15},{"Mauvaise pioche pour notre extraterrestre, il va ramasser de sa race. On ne voudrait pas être à sa place"}}    -- Il va rammasser de sa race 
  soluces[5] = {{1,2,3,4,5},{"Super et que vas-tu faire de tout ce bordel, il ne manquerait pas un bureau par hasard ?"}}        -- Il manque le bureau pour mettre tout ce bordel
  soluces[6] = {{5,7,10,14,15},{"Ya petite fraulein, nous afons les moyens de fous faire parler hahahaha..."}}      -- Nous afons les moyens de fous faire parler
  soluces[7] = {{8,10,14,18,19},{"Excellent choix, on tape tout ce petit monde sur un ring et on voit ce que cela donne... . Mode Fight Club ON"}}    -- Le club des cinq - Fight club
  soluces[8] = {{10,11,14,16,20},{"Le tir au pigeon 2.0. Pool et un Extraterrestre un! Celui-là n'essayera pas de revenir avec ses potes au moins"}}   -- Le tir aux clays: tir au pigeon - cours forest
  soluces[9] = {{6,7,8,10,12},{"Hmm c'est chaud ce soir, une meuf, un prédator et un bureau... Sex on the desk tonight!"}}      -- Sex on the desk
  soluces[10] = {{3,10,11,17,20},{"Nom de dieu! ET se barre avec un rack server de chez Amazon et de quoi l'alimenter, il veut nous piquer nos données le fumier!"}}   -- ET a piqué un rack server chez Amazon et de quoi l'alimenter
  
  local failResponses = {}
  failResponses = {
                    {"Essaye à nouveau, tu y es presque mais tu as l'esprit un peu tordu!"},
                    {"Non mais tu rigoles là?"},
                    {"C'est du grand n'importe quoi!"},
                    {"Franchement, autant ne pas essayer de trouver"},
                    {"Alors celle-là je ne l'ai pas vue venir!"},
                    {"Tu n'as même pas essayé de réfléchir"},
                    {"Ma grand-mère aurait pû élaborer une meilleure solution"},
                    {"Tu l'a fait les yeux fermes je parie"},
                    {"J'ai l'impression qu'ET n'est pas prêt de partir"},
                    {"Autant le tuer et le disséquer directement..."}
                  }

  local posInv = 1
  local posTxt = 2

  local response = {}
  response = {{""},{""}}

  --/ Boucle sur les solutions
  for s = 1, 10 do
    --/ Boucle sur les objets de la solution
    for index,value in ipairs(soluces[s][posInv]) do
      --/ Check si existe dans l'inventaire
      objExist = objExist + checkObjExistInInventory(value)      
    end
    --/ Si on a gagné 
    if objExist == 5 then
      response[0] = true
      response[1] = soluces[s][posTxt]
      return response       
    else
      objExist = 0
    end
  end  

  --/ Affiche un message "aléatoire" si on pas de bonne solution
  local numResponse = love.math.random(1, 10)
  response[0] = false
  response[1] = failResponses[numResponse]

  return response
  
end

--/ Restart Game et réinitialisation
function LBAp.restart()
  LBAp.selectedObjects = {}
end

--/ ----------------------------------------------------
--/ DRAWING --------------------------------------------
--/ ----------------------------------------------------

--/ Affiche la présention du jeu, des infos et le cadre/ footer du jeu
function LBAp.drawPresentation()
  local y = 10  
  love.graphics.setColor(1, 0.39, 0.39, 1) -- rouge fraise
  love.graphics.print("Synopsis", 10, y)
  y = y + 20
  love.graphics.setColor(1, 1, 1, 1) -- Blanc
  love.graphics.print(LBAp.strIntro[1], 15, y)
  y = y + 16
  love.graphics.print(LBAp.strIntro[2], 15, y)
  y = y + 16
  love.graphics.print(LBAp.strIntro[3], 15, y)
  y = y + 35
  love.graphics.setColor(1, 0.39, 0.39, 1) -- rouge fraise
  love.graphics.print("Liste des objets que vous pouvez essayer d'associer : ", 10, y)
  y = y + 16
  love.graphics.setColor(1, 1, 1, 1) -- Blanc
  love.graphics.print("Utilisez les flèches haut/bas pour naviguer et la touche enter pour ajouter un objet à votre inventaire", 15, y)
  y = y + 16
  love.graphics.print("Un objet ne peut être qu'une seule fois dans l'inventaire. Pour supprimer un objet, ajouter-le à nouveau", 15, y)
  y = y + 35

  --/ Bordure de l'application
  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  love.graphics.rectangle("line", 1, 1, 899, 599)
  --/ Footer
  love.graphics.line(1, 570, 899, 570)
  love.graphics.print("BACK TO SPACE v"..version.." : Alpha Kilo - Games Studio", 280 , 578)
end

--/ Affiche l'icône reçu à la postion passée en paramètre
function LBAp.drawIcon(pIcon, posX, posY)
  love.graphics.draw(pIcon, posX, posY, 0, 2, 2)
end

--/ Affiche l'interface d'information de l'objet sélectionné
function LBAp.drawHUDInfosObject(pObjectIndex)
  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  love.graphics.print("Informations sur l'objet", 280, 180)
  love.graphics.setColor(1, 1, 1, 0.5) 
  love.graphics.print("Nom : "..LBAp.objects[pObjectIndex][1], 280, 200)
  love.graphics.print("Type : "..LBAp.objects[pObjectIndex][4], 280, 220)
  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  love.graphics.rectangle("line", 270, 170, 600, 100 )
end

--/ Dessine l'interface des objets sélectionnés
function LBAp.drawHUDSelection()
  love.graphics.setColor(1, 0.32, 0, 1) -- orange
  love.graphics.print("Votre Inventaire (", 280, 290)
  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  love.graphics.print("il faut 5 objets", 408, 290)
  love.graphics.setColor(1, 0.32, 0, 1) -- orange
  love.graphics.print(")", 510, 290)
  love.graphics.rectangle("line", 270, 280, 600, 100 )  
end

--/ Afiche la liste des objets sélectionnable ainsi que l'icône associée
function LBAp.drawObjectsList(pSelectedElement)  
  local y = 170
  
  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  
  for n,v in ipairs(LBAp.objects) do
    --/ Element sélectionné
    if pSelectedElement == n then
      love.graphics.setColor(1, 0.32, 0, 1) -- orange
      love.graphics.print(" > "..n.."  "..v[1], 15, y)
      love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
      --/ Traitement des icônes   
      local iconName = "images/"..v[5]
      local info = love.filesystem.getInfo( iconName) 
      if info ~= nil then
        local icon = love.graphics.newImage(iconName)
        LBAp.drawIcon(icon, 530, 190)
      end
    else
      love.graphics.print(n.."  "..v[1], 15, y)
    end
    y = y + 16
  end
end

--/ Affiche la liste des objets sélectionnés
function LBAp.drawObjectsListSelected()
  local x = 300
  for n,v in ipairs(LBAp.selectedObjects) do
    --/ DEBUG -- love.graphics.print(n..":"..v, x, 350)
    local iconName = "images/"..LBAp.objects[v][5]
      local info = love.filesystem.getInfo( iconName) 
      if info ~= nil then
        love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
        local icon = love.graphics.newImage(iconName)
        LBAp.drawIcon(icon, x - 25, 310)
      end
    x = x + 64
  end
end

--/ Retourne true si un élément existe dans la liste des objets sélectionnés sinon retourne false
function LBAp.objectExistInList(pIndex)
  local exist = false
  for n,v in ipairs(LBAp.selectedObjects) do
    if pIndex == v then
      exist = true     
    end   
  end
  return exist
end

--/ Affiche un message à la position et à la couleur passée en paramètre
function LBAp.drawMessage(pText, posX, posY, color)

  if color == nil then
    color =  {1, 1, 1, 1} -- white
  end
  love.graphics.setColor(color[1], color[2], color[3], color[4]) -- orange
  love.graphics.print(pText, posX, posY)
end
--/ ----------------------------------------------------
--/ GETTERS --------------------------------------------
--/ ----------------------------------------------------

--/ Getter window
function LBAp.getWindow()
  return window
end --/ END FCT getWindow()

--/ ----------------------------------------------------
--/ SETTERS --------------------------------------------
--/ ----------------------------------------------------

--/ ----------------------------------------------------
--/ PRIVATE --------------------------------------------
--/ ----------------------------------------------------

--/ PRIVATE : Vérifie si un objet existe
function checkObjExistInInventory(pObjSoluce)

  for index, objInventory in ipairs(LBAp.selectedObjects) do
    --/ Si on trouve l'objet
    if objInventory == pObjSoluce then
      return 1    
    end
  end
  return 0
end

--/ ----------------------------------------------------
--/ LIB RETURN -----------------------------------------
--/ ----------------------------------------------------
return LBAp