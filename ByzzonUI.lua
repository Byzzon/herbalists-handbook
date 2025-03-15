SLASH_BYZZONUI1 = "/byzzonui"

-- local Unit = {
--     Player = "player"
-- }
-- local playerName = UnitName(Unit.Player);
local isVisible = true

local flowers = ByzzonUI.flowerList;

local LedgerFrame = CreateFrame("Frame", "FRAME_LEDGER_PANEL", UIParent)
LedgerFrame:SetWidth(384)
LedgerFrame:SetHeight(512)
LedgerFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

LedgerFrame:EnableMouse(true)
LedgerFrame:SetMovable(true)
LedgerFrame:SetUserPlaced(true)

LedgerFrame:RegisterForDrag("LeftButton")
LedgerFrame:SetScript("OnDragStart", function() LedgerFrame:StartMoving() end)
LedgerFrame:SetScript("OnDragStop", function() LedgerFrame:StopMovingOrSizing() end)

local CloseButton = CreateFrame("Button", "FRAME_LEDGER_PANEL_BUTTON_CLOSE", LedgerFrame, "UIPanelCloseButton")
CloseButton:SetPoint("CENTER", LedgerFrame, "TOPRIGHT", -44, -25)
CloseButton:SetScript("OnClick", function()
    LedgerFrame:Hide()
    isVisible = false
end)

local Icon = LedgerFrame:CreateTexture(nil, "BACKGROUND")
Icon:SetTexture([[Interface\Spellbook\Spellbook-Icon]])
Icon:SetWidth(58)
Icon:SetHeight(58)
Icon:SetPoint("TOPLEFT", LedgerFrame, "TOPLEFT", 10, -8)

local TopLeft = LedgerFrame:CreateTexture(nil, "ARTWORK")
TopLeft:SetTexture([[Interface\Spellbook\UI-SpellbookPanel-TopLeft]])
TopLeft:SetWidth(256)
TopLeft:SetHeight(256)
TopLeft:SetPoint("TOPLEFT", LedgerFrame, "TOPLEFT", 0, 0)

local TopRight = LedgerFrame:CreateTexture(nil, "ARTWORK")
TopRight:SetTexture([[Interface\Spellbook\UI-SpellbookPanel-TopRight]])
TopRight:SetWidth(128)
TopRight:SetHeight(256)
TopRight:SetPoint("TOPRIGHT", LedgerFrame, "TOPRIGHT", 0, 0)

local BottomLeft = LedgerFrame:CreateTexture(nil, "ARTWORK")
BottomLeft:SetTexture([[Interface\Spellbook\UI-SpellbookPanel-BotLeft]])
BottomLeft:SetWidth(256)
BottomLeft:SetHeight(256)
BottomLeft:SetPoint("BOTTOMLEFT", LedgerFrame, "BOTTOMLEFT", 0, 0)

local BottomRight = LedgerFrame:CreateTexture(nil, "ARTWORK")
BottomRight:SetTexture([[Interface\Spellbook\UI-SpellbookPanel-BotRight]])
BottomRight:SetWidth(128)
BottomRight:SetHeight(256)
BottomRight:SetPoint("BOTTOMRIGHT", LedgerFrame, "BOTTOMRIGHT", 0, 0)

local TitleText = LedgerFrame:CreateFontString("FRAME_LEDGER_PANEL_TITLE_TEXT", "ARTWORK", "GameFontNormal")
TitleText:SetPoint("CENTER", LedgerFrame, "CENTER", 6, 230)
TitleText:SetText("Herbalist's Handbook")

local PageText = LedgerFrame:CreateFontString("FRAME_LEDGER_PANEL_PAGE_TEXT", "ARTWORK", "GameFontNormal")
PageText:SetWidth(102)
PageText:SetPoint("BOTTOM", LedgerFrame, "BOTTOM", -14, 96)
PageText:SetText("Page 1")

local FlowerFrame = CreateFrame("Frame", "FlowerFrame", LedgerFrame);
FlowerFrame:SetWidth(384)
FlowerFrame:SetHeight(512)
FlowerFrame:SetPoint("TOPLEFT", LedgerFrame, "TOPLEFT", 0, -90)

function addFlower(iconPath, flowerName, orangeLevel, yellowLevel, greenLevel, grayLevel, marginTop, locations)
    local IconFrame = CreateFrame("Button", "IconFrame", FlowerFrame);
    IconFrame:SetWidth(40)
    IconFrame:SetHeight(40)
    IconFrame:SetPoint("TOPLEFT", FlowerFrame, "TOPLEFT", 35, marginTop)

    local FlowerIcon = IconFrame:CreateTexture(nil, "OVERLAY")
    FlowerIcon:SetTexture(iconPath)
    FlowerIcon:SetWidth(40)
    FlowerIcon:SetHeight(40)
    FlowerIcon:SetPoint("CENTER", IconFrame, "CENTER", 0, 0)

    local FlowerText = IconFrame:CreateFontString("FRAME_LEDGER_PANEL_PAGE_TEXT", "ARTWORK", "GameFontNormal")
    FlowerText:SetWidth(200)
    FlowerText:SetPoint("CENTER", IconFrame, "CENTER", 122, 0)
    FlowerText:SetJustifyH("LEFT")
    FlowerText:SetFont("Fonts\\FRIZQT__.TTF", 12)
    FlowerText:SetText(flowerName ..
        "\n|cffFFA500" ..
        orangeLevel .. "|r |cFFFFFF00" .. yellowLevel .. "|r |cFF00FF00" .. greenLevel .. "|r |cFF808080" .. grayLevel ..
        "|r")

    IconFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(IconFrame, "ANCHOR_RIGHT")
        GameTooltip:SetText(
            "|cffffffffCan be gathered in:|r")
        GameTooltip:AddLine(locations)
        GameTooltip:Show()
    end)

    IconFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

for _, flower in ipairs(flowers) do
    addFlower(flower.iconPath, flower.name, flower.orangeLevel, flower.yellowLevel, flower.greenLevel, flower.grayLevel,
        flower.marginTop, flower.locations)
end


local function toggle()
    if (isVisible)
    then
        LedgerFrame:Hide();
        isVisible = false;
    else
        LedgerFrame:Show();
        isVisible = true;
    end
end



SlashCmdList["BYZZONUI"] = toggle
