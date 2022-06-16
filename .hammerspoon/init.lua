local map = hs.keycodes.map
local keyDown = hs.eventtap.event.types.keyDown
local flagsChanged = hs.eventtap.event.types.flagsChanged

local function setEN()
  hs.keycodes.setLayout('ABC')
end

local function setJP()
  hs.keycodes.setMethod('ひらかな')
end

local cmdAsModifier = false

local function handler(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  local t = event:getType()
  if t == keyDown then
    if c == map['escape'] then
      setEN()
      return
    end
    if f['cmd'] then
      cmdAsModifier = true
    elseif f['ctrl'] then
      if c == map['['] then
        setEN()
      end
    end
  elseif t == flagsChanged then
    if not f['cmd'] then
      if not cmdAsModifier then
        if c == map['cmd'] then
          setEN()
        elseif c == map['rightcmd'] then
          setJP()
        end
      end
      cmdAsModifier = false
    end
  end
end

Tap = hs.eventtap.new({ keyDown, flagsChanged }, handler)
Tap:start()
