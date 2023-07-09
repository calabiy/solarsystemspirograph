require ("Spirograph")

local planets = {
  mercury = {
    calc = function() spiro(40, 10, 0, 170, false, coroutine.yield) end,
    draw = function(cx, cy, x, y) pncl("#000000") crcl(cx, cy, 6, "#666688") end,
  },
  venus = {
    calc = function() spiro(90, 10, 0, 480, false, coroutine.yield) end,
    draw = function(cx, cy, x, y) pncl("#000000") crcl(cx, cy, 8, "#FF0000") end,
  },
  mars = {
    calc = function() spiro(190, 10, 0, 1350, false, coroutine.yield) end,
    draw = function(cx, cy, x, y) pncl("#000000") crcl(cx, cy, 8, "#008888") end,
  },
}
pncl("#DDDDDD") 

spiro(140, 10.5,20, 720, 0.02, function(cx, cy, x, y)
  pncl("#000001") 
  crcl(0, 0, 22, "#0003FF") 
  crcl(cx, cy, 10, "#FF00FF") 
  crcl(x, y, 5, "#888888") 

  for _,planet in pairs(planets) do
    local ok, cx, cy, x, y
    while not cx or not cy do
      
      if not planet.coro or coroutine.status(planet.coro) == 'dead' then
        planet.coro = coroutine.create(planet.calc)
      end
      pncl("#2342124") 
      ok, cx, cy, x, y = coroutine.resume(planet.coro, true) 
      if not ok then error(cx) end 
      if cx and cy then planet.draw(cx, cy, x, y) end 
    end
  end
end)
wait()
