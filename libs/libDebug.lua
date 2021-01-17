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

--/ Init de la librairie 
local LBDbg = {}

--/ A activer pour un débuggage pas à pas
--/ Local Lua Debugger - tomblind.local-lua-debugger-vscode
--/ Il faut au préalable installer l'extension ci-desssus et
--/ paramètrer le fichier launch.json comme tel:
--[[
  {
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug LÖVE2D",
            "type": "lua-local",
            "request": "launch",
            "program": {
                "command": "/Applications/love.app/Contents/MacOS/love" or "C:/Program Files/LOVE/love.exe"
            },
            "args": [
                "${workspaceFolder}"
            ]
        }
    ]
}
]]
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
  require("lldebugger").start()
end

--[[  Affichage d'une variable de type Table (clé->valeur)  
      Paramètres : 
      sDebug : Variable de type table à afficher
      posX : Postion de la zone de debug sur l'axe des X
      posY : Postion de la zone de debug sur l'axe des Y
      color :  couleur du texte  
  ]]
function LBDbg.draw (sDebug, posX, posY, color)
      
     LBDbg.posX = posX
     LBDbg.posY = posY
     LBDbg.title = "-- DEBUG ZONE --"     
     LBDbg.lineHeight = 13
      
      if color == "red" then
        love.graphics.setColor(1, 0, 0, 1)
      elseif color == "green" then
        love.graphics.setColor(0, 1, 0, 1)
      elseif color == "blue" then
        love.graphics.setColor(0, 0, 1, 1)
      elseif color == "aqua" then
        love.graphics.setColor(0, 1, 1, 1)
      elseif color == "yellow" then
        love.graphics.setColor(1, 1, 0, 1)
      elseif color == "black" then
        love.graphics.setColor(0, 0, 0, 1)
      elseif color == nil then -- white
        love.graphics.setColor(1, 1, 1, 1)
      end
      
      --/ Title
     love.graphics.print(LBDbg.title, LBDbg.posX, LBDbg.posY)
     LBDbg.posY = LBDbg.posY + LBDbg.lineHeight
      
      --/ Loop on table strings
      for key,value in pairs(sDebug) do
      
        if value ~= nil then  

          if type(value) == "number" then --/math.type() au lieu de type() si lua >= 5.3
            -- love.graphics.print(key.." "..dRound(value, 2), LBDbg.posX, LBDbg.posY)
            love.graphics.print(key.." "..type(value).." "..value,LBDbg.posX, LBDbg.posY)
          elseif type(value) == "string" then
            love.graphics.print(key.." "..tostring(value), LBDbg.posX, LBDbg.posY)
          end
        else
          love.graphics.print(key.." no data", LBDbg.posX, LBDbg.posY)
        end

        --/ Next Line
       LBDbg.posY = LBDbg.posY + LBDbg.lineHeight        
      end

      --/ Reset to white color (default color)
      love.graphics.setColor(1, 1, 1, 1)
end --/ END FCT draw()

--[[  Retourne un nombre flottant arrondi. Avec un nombre définit de chiffres après la virgule 
      Paramètres: 
      num : le nombre flottant à arrondir
      dec : le nombre de décimales souhaitées  
  ]]
function LBDbg.dRound(nbr, dec) -- -------------------------------------
  local mult = 10^(dec or 0)
  return math.floor(nbr * mult + 0.5) / mult
end --/ End cdRound() --------------------------------------------

--/ ----------------------------------------------------
--/ LIB RETURN -----------------------------------------
--/ ----------------------------------------------------
return LBDbg