--/ ---------------------------------------------
--/         Gamecodeur Weekex Crafting
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

--/ Init de la librairie (PlatFormer Lib)
local LBAp = {}

--/ Déclaration et intialisation des propriétés de la librairie
local window = {}         -- Paramètres de la fenêtre

--/ Définition des Constantes
local DEF_W_TITLE = "Gamecodeur WeekEx Crafting - Back To Space v0.0.1"     -- Titre fenêtre
local DEF_W_WIDTH = 900     -- Largeur fenêtreà
local DEF_W_HEIGHT = 600     -- Hauteur fenêtre

LBAp.objects = {}
--/ Propriétés des objets : Nom (str), Associable (bool), Type (str), Type d'Associabilité (str), Icône (str)
  
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
function LBAp.addObject(pIndex)

  table.insert(LBAp.selectedObjects, pIndex)

end

function LBAp.removeObject(pIndex)

  for n,v in ipairs(LBAp.selectedObjects) do
    if pIndex == v then
      table.remove(LBAp.selectedObjects, n)    
    end   
  end
  

end
--/ ----------------------------------------------------
--/ DRAWING --------------------------------------------
--/ ----------------------------------------------------
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
  love.graphics.print("BACK TO SPACE v.0.0.1", 370 , 578)

end

function LBAp.drawIcon(pIcon, posX, posY)  

  love.graphics.draw(pIcon, posX, posY, 0, 2, 2)

end

function LBAp.drawHUD(pObjectIndex)

  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  love.graphics.print("Informations sur l'objet", 280, 180)
  love.graphics.setColor(1, 1, 1, 0.5) 
  love.graphics.print("Nom : "..LBAp.objects[pObjectIndex][1], 280, 200)
  love.graphics.print("Type : "..LBAp.objects[pObjectIndex][4], 280, 220)
  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  love.graphics.rectangle("line", 270, 170, 600, 100 )

end

function LBAp.drawSelection()

  love.graphics.setColor(1, 0.32, 0, 1) -- orange
  love.graphics.print("Votre Inventaire (", 280, 290)
  love.graphics.setColor(0.76, 0.95, 0.11, 1) -- vert lime
  love.graphics.print("5 objects maximum", 408, 290)
  love.graphics.setColor(1, 0.32, 0, 1) -- orange
  love.graphics.print(")", 540, 290)
  love.graphics.rectangle("line", 270, 280, 600, 100 )
  
end

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

function LBAp.objectExistInList(pIndex)
  local exist = false
  for n,v in ipairs(LBAp.selectedObjects) do
    if pIndex == v then
      exist = true     
    end   
  end
  return exist
end

function LBAp.drawMessage(pText)
  love.graphics.setColor(1, 0.32, 0, 1) -- orange
  love.graphics.print(pText, 475, 390)
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
--/ LIB RETURN -----------------------------------------
--/ ----------------------------------------------------
return LBAp