SLASH_BYZZONUI1 = "/byzzonui"

-- local Unit = {
--     Player = "player"
-- }
-- local playerName = UnitName(Unit.Player);
local bookTitle = "Herbalist's Handbook (Beta)"
local isVisible = true
local flowers = ByzzonUI.flowerList;
local currentPage = 1;

local function getHerbalismLevel()
    for i = 1, GetNumSkillLines() do
        local skillName, _, _, skillRank = GetSkillLineInfo(i)
        if skillName == "Herbalism" then
            return skillRank
        end
    end

    return 0
end

local LedgerFrame = CreateFrame("Frame", "FRAME_LEDGER_PANEL", UIParent)
LedgerFrame:SetFrameStrata("DIALOG")
LedgerFrame:SetWidth(395)
LedgerFrame:SetHeight(512)
LedgerFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

LedgerFrame:EnableMouse(true)
LedgerFrame:SetMovable(true)
LedgerFrame:SetUserPlaced(true)

LedgerFrame:RegisterForDrag("LeftButton")
LedgerFrame:SetScript("OnDragStart", function() LedgerFrame:StartMoving() end)
LedgerFrame:SetScript("OnDragStop", function() LedgerFrame:StopMovingOrSizing() end)

local CloseButton = CreateFrame("Button", "FRAME_LEDGER_PANEL_BUTTON_CLOSE", LedgerFrame, "UIPanelCloseButton")
CloseButton:SetPoint("CENTER", LedgerFrame, "TOPRIGHT", -48, -25)
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
TopRight:SetWidth(139)
TopRight:SetHeight(256)
TopRight:SetPoint("TOPRIGHT", LedgerFrame, "TOPRIGHT", 0, 0)

local BottomLeft = LedgerFrame:CreateTexture(nil, "ARTWORK")
BottomLeft:SetTexture([[Interface\Spellbook\UI-SpellbookPanel-BotLeft]])
BottomLeft:SetWidth(256)
BottomLeft:SetHeight(256)
BottomLeft:SetPoint("BOTTOMLEFT", LedgerFrame, "BOTTOMLEFT", 0, 0)

local BottomRight = LedgerFrame:CreateTexture(nil, "ARTWORK")
BottomRight:SetTexture([[Interface\Spellbook\UI-SpellbookPanel-BotRight]])
BottomRight:SetWidth(139)
BottomRight:SetHeight(256)
BottomRight:SetPoint("BOTTOMRIGHT", LedgerFrame, "BOTTOMRIGHT", 0, 0)

local TitleText = LedgerFrame:CreateFontString("FRAME_LEDGER_PANEL_TITLE_TEXT", "ARTWORK", "GameFontNormal")
TitleText:SetPoint("CENTER", LedgerFrame, "CENTER", 6, 230)
TitleText:SetText(bookTitle)

local PageText = LedgerFrame:CreateFontString("FRAME_LEDGER_PANEL_PAGE_TEXT", "ARTWORK", "GameFontNormal")
PageText:SetWidth(102)
PageText:SetPoint("BOTTOM", LedgerFrame, "BOTTOM", -14, 96)
PageText:SetText("Page " .. currentPage)

local LevelText = LedgerFrame:CreateFontString("FRAME_LEDGER_PANEL_PAGE_TEXT", "ARTWORK", "GameFontNormal")
LevelText:SetWidth(120)
LevelText:SetPoint("TOP", LedgerFrame, "TOP", 0, -50)
if getHerbalismLevel() > 0 then
    LevelText:SetText("Herbalism level |cFFFFFFFF" .. getHerbalismLevel())
end

local FlowerFrame = CreateFrame("Frame", "FlowerFrame", LedgerFrame);
FlowerFrame:SetWidth(384)
FlowerFrame:SetHeight(512)
FlowerFrame:SetPoint("TOPLEFT", LedgerFrame, "TOPLEFT", 40, -90)

-----------------
-- NEXT BUTTON --
-----------------
local nextButton = CreateFrame("Button", "HerbalistNextButton", LedgerFrame)

-- Set Size
nextButton:SetWidth(32)
nextButton:SetHeight(32)

-- Set Strata
nextButton:SetFrameStrata("FULLSCREEN")

-- Set Position (Adjust as needed)
nextButton:SetPoint("CENTER", LedgerFrame, "CENTER", 50, -155) -- Example position

-- Normal Texture
local normalTexture = nextButton:CreateTexture(nil, "BACKGROUND")
normalTexture:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
normalTexture:SetAllPoints()
nextButton:SetNormalTexture(normalTexture)

-- Pushed Texture
local pushedTexture = nextButton:CreateTexture(nil, "BACKGROUND")
pushedTexture:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
pushedTexture:SetAllPoints()
nextButton:SetPushedTexture(pushedTexture)

-- Disabled Texture
local disabledTexture = nextButton:CreateTexture(nil, "BACKGROUND")
disabledTexture:SetTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
disabledTexture:SetAllPoints()
nextButton:SetDisabledTexture(disabledTexture)

-- Highlight Texture
local highlightTexture = nextButton:CreateTexture(nil, "HIGHLIGHT")
highlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
highlightTexture:SetAllPoints()
highlightTexture:SetBlendMode("ADD")
nextButton:SetHighlightTexture(highlightTexture)

-- Button Functionality (Example: Print message when clicked)
nextButton:SetScript("OnClick", function()
    currentPage = currentPage + 1;
    PageText:SetText("Page " .. currentPage)
end)


function addFlower(iconPath, flowerName, orangeLevel, yellowLevel, greenLevel, grayLevel, marginLeft, marginTop,
                   locations)
    local IconFrame = CreateFrame("Button", "IconFrame", FlowerFrame);
    IconFrame:SetWidth(40)
    IconFrame:SetHeight(40)
    IconFrame:SetPoint("TOPLEFT", FlowerFrame, "TOPLEFT", marginLeft, marginTop)

    local border = IconFrame:CreateTexture(nil, "HIGHLIGHT")
    border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
    border:SetPoint("TOPLEFT", IconFrame, "TOPLEFT", -15, 15) -- Expand outward
    border:SetPoint("BOTTOMRIGHT", IconFrame, "BOTTOMRIGHT", 15, -15)
    border:SetBlendMode("ADD")                                -- Makes it glow slightly
    -- border:SetAllPoints()
    border:SetAlpha(0)

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
        border:SetAlpha(1)
    end)

    IconFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
        border:SetAlpha(0)
    end)
end

for index, flower in ipairs(flowers) do
    local row
    local col
    local marginLeft
    local marginTop

    if index < 7 then
        row = index - 1;
        col = 0;
    else
        row = index - 7
        col = 1;
    end

    marginLeft = col * 150
    marginTop = row * -50

    addFlower(flower.iconPath, flower.name, flower.orangeLevel, flower.yellowLevel, flower.greenLevel,
        flower.grayLevel, marginLeft, marginTop, flower.locations);
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
