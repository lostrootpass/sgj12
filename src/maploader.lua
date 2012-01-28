require('object')

MapLoader = Object:new()


function MapLoader:init(filepath)
	print(filepath)
	self.tileSize = 32
	self.emptyType = 0
	self.tileGfx = {}
	self.tiletype, self.layers, self.objects = self:parse(filepath)
	
	for gid, path in pairs(self.tiletype) do
		local i, j = string.find(path, "../")
		if i == 1 then
			path = string.sub(path, 4, -1)
		end
		local raw = love.image.newImageData(path)
		local w, h = raw:getWidth(), raw:getHeight()
		local e = self.tileSize
		
		for y = 0, math.floor(h/self.tileSize) - 1 do
			for x = 0, math.floor(w/self.tileSize) - 1 do
				local sprite = love.image.newImageData(self.tileSize, self.tileSize)
				sprite:paste(raw, 0, 0, x * e, y * e, e, e)
				self.tileGfx[gid] = love.graphics.newImage(sprite)
				gid = gid + 1
			end
		end
	end
end

function MapLoader:getMapTile(tx, ty, layerid)
	local row = self.layers[layerid][ty]
	return row and row[tx] or self.emptyType
end

function MapLoader:getMapObjects()
	return self.objects
end

function MapLoader:drawNearCam(camx, camy)
	camx, camy = math.floor(camx), math.floor(camy)
	local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
	local minx, maxx = math.floor((camx - sw / 2)/self.tileSize), math.ceil((camx + sw / 2)/self.tileSize)
	local miny, maxy = math.floor((camy - sh / 2)/self.tileSize), math.ceil((camy + sh / 2)/self.tileSize)
	
	for z = 1,#self.layers do
		for x = minx, maxx do
			for y = miny, maxy do
				local gfx = self.tileGfx[self:getMapTile(x, y, z)]
				
				if gfx then
					local sx = x * self.tileSize - camx + sw / 2
					local sy = y * self.tileSize - camy + sh / 2
					
					love.graphics.draw(gfx, sx, sy)
				end
			end
		end
	end
end


function MapLoader:parse(filename)
	--print(filename)
	local xml = LoadXML(love.filesystem.read(filename))
	local tiles = getTilesets(xml[2])
	local layers = getLayers(xml[2])
	local objects = getObjects(xml[2])
	
	return tiles, layers, objects
end

-- ***** ***** ***** ***** ***** xml parser


-- LoadXML from http://lua-users.org/wiki/LuaXml
function LoadXML(s)
  local function LoadXML_parseargs(s)
    local arg = {}
    string.gsub(s, "(%w+)=([\"'])(.-)%2", function (w, _, a)
    arg[w] = a
    end)
    return arg
  end
  local stack = {}
  local top = {}
  table.insert(stack, top)
  local ni,c,label,xarg, empty
  local i, j = 1, 1
  while true do
    ni,j,c,label,xarg, empty = string.find(s, "<(%/?)([%w:]+)(.-)(%/?)>", i)
    if not ni then break end
    local text = string.sub(s, i, ni-1)
    if not string.find(text, "^%s*$") then
      table.insert(top, text)
    end
    if empty == "/" then  -- empty element tag
      table.insert(top, {label=label, xarg=LoadXML_parseargs(xarg), empty=1})
    elseif c == "" then   -- start tag
      top = {label=label, xarg=LoadXML_parseargs(xarg)}
      table.insert(stack, top)   -- new level
    else  -- end tag
      local toclose = table.remove(stack)  -- remove top
      top = stack[#stack]
      if #stack < 1 then
        error("nothing to close with "..label)
      end
      if toclose.label ~= label then
        error("trying to close "..toclose.label.." with "..label)
      end
      table.insert(top, toclose)
    end
    i = j+1
  end
  local text = string.sub(s, i)
  if not string.find(text, "^%s*$") then
    table.insert(stack[#stack], text)
  end
  if #stack > 1 then
    error("unclosed "..stack[stack.n].label)
  end
  return stack[1]
end


-- ***** ***** ***** ***** ***** parsing the tilemap xml file

function getTilesets(node)
    local tiles = {}
    for k, sub in ipairs(node) do
        if (sub.label == "tileset") then
            tiles[tonumber(sub.xarg.firstgid)] = sub[1].xarg.source
        end
    end
    return tiles
end

function getLayers(node)
    local layers = {}
    for k, sub in ipairs(node) do
        if (sub.label == "layer") then --  and sub.xarg.name == layer_name
            local layer = {}
            table.insert(layers,layer)
            width = tonumber(sub.xarg.width)
            i = 1
            j = 1
            for l, child in ipairs(sub[1]) do
                if (j == 1) then
                    layer[i] = {}
                end
                layer[i][j] = tonumber(child.xarg.gid)
                j = j + 1
                if j > width then
                    j = 1
                    i = i + 1
                end
            end
        end
    end
    return layers
end

function getObjects(node)
	local olayer = {}
    for k, sub in ipairs(node) do
        if (sub.label == "objectgroup") then --  and sub.xarg.name == layer_name
			for l, child in ipairs(sub) do
                olayer[l] = {
					t = child.xarg.type,
					x = tonumber(child.xarg.x), 
					y = tonumber(child.xarg.y), 
					w = tonumber(child.xarg.width), 
					h = tonumber(child.xarg.height),
				}
				
				for m, sub2 in ipairs(child) do
					if (sub2.label == "properties") then
						for n, child2 in ipairs(sub2) do
							olayer[l][child2.xarg.name] = child2.xarg.value
						end
					end
				end
				
            end
        end
    end
    return olayer
end