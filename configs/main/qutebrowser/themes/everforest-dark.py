# =============================================================================
# Everforest Dark — Medium
# =============================================================================

t = {
    # Backgrounds
    "bg_dim": "#232A2E",
    "bg0": "#2D353B",
    "bg1": "#343F44",
    "bg2": "#3D484D",
    "bg3": "#475258",
    "bg4": "#4F585E",
    "bg5": "#56635F",

    # Special backgrounds
    "bg_visual": "#543A48",
    "bg_red": "#514045",
    "bg_yellow": "#4D4C43",
    "bg_green": "#425047",
    "bg_blue": "#3A515D",
    "bg_purple": "#4A444E",

    # Foreground
    "fg": "#D3C6AA",
    "fg_dim": "#859289",

    # Accents
    "red": "#E67E80",
    "orange": "#E69875",
    "yellow": "#DBBC7F",
    "green": "#A7C080",
    "teal": "#83C092",
    "blue": "#7FBBB3",
    "purple": "#D699B6",

    # Greys
    "grey0": "#7A8478",
    "grey1": "#859289",
    "grey2": "#9DA9A0",

    # Statusline
    "statusline1": "#A7C080",
    "statusline2": "#D3C6AA",
    "statusline3": "#E67E80",
}


# =============================================================================
# Webpage
# =============================================================================

c.colors.webpage.bg = t["bg0"]


# =============================================================================
# Key hints
# =============================================================================

c.colors.keyhint.fg = t["fg"]
c.colors.keyhint.suffix.fg = t["red"]


# =============================================================================
# Messages
# =============================================================================

c.colors.messages.error.bg = t["bg_red"]
c.colors.messages.error.fg = t["red"]

c.colors.messages.info.bg = t["bg_blue"]
c.colors.messages.info.fg = t["fg"]

c.colors.messages.warning.bg = t["bg_yellow"]
c.colors.messages.warning.fg = t["fg"]


# =============================================================================
# Prompts / command line
# =============================================================================

c.colors.prompts.bg = t["bg0"]
c.colors.prompts.fg = t["fg"]


# =============================================================================
# Completion menu
# =============================================================================

c.colors.completion.category.bg = t["bg0"]
c.colors.completion.category.fg = t["grey2"]

c.colors.completion.fg = t["fg"]

c.colors.completion.even.bg = t["bg0"]
c.colors.completion.odd.bg = t["bg1"]

c.colors.completion.match.fg = t["red"]

c.colors.completion.item.selected.fg = t["fg"]
c.colors.completion.item.selected.bg = t["bg_yellow"]

c.colors.completion.item.selected.border.top = t["bg_yellow"]
c.colors.completion.item.selected.border.bottom = t["bg_yellow"]

c.colors.completion.scrollbar.bg = t["bg_dim"]
c.colors.completion.scrollbar.fg = t["grey1"]


# =============================================================================
# Hints
# =============================================================================

# c.colors.hints.bg = t["bg_green"]
# c.colors.hints.fg = t["fg"]
# c.colors.hints.match.fg = t["red"]
#
# c.hints.border = "0px solid black"
#

# =============================================================================
# Status bar
# =============================================================================

c.colors.statusbar.normal.fg = t["fg"]
c.colors.statusbar.normal.bg = t["bg1"]

c.colors.statusbar.insert.fg = t["bg0"]
c.colors.statusbar.insert.bg = t["statusline1"]

c.colors.statusbar.command.fg = t["fg"]
c.colors.statusbar.command.bg = t["bg0"]

c.colors.statusbar.private.fg = t["fg"]
c.colors.statusbar.private.bg = t["bg_purple"]

c.colors.statusbar.url.error.fg = t["orange"]
c.colors.statusbar.url.fg = t["fg"]
c.colors.statusbar.url.hover.fg = t["blue"]

c.colors.statusbar.url.success.http.fg = t["green"]
c.colors.statusbar.url.success.https.fg = t["green"]

c.colors.statusbar.url.warn.fg = t["yellow"]


# =============================================================================
# Tabs
# =============================================================================

c.colors.tabs.bar.bg = t["bg_dim"]

c.colors.tabs.even.bg = t["bg0"]
c.colors.tabs.odd.bg = t["bg0"]
c.colors.tabs.even.fg = t["fg_dim"]
c.colors.tabs.odd.fg = t["fg_dim"]

c.colors.tabs.selected.even.bg = t["green"]
c.colors.tabs.selected.odd.bg = t["green"]
c.colors.tabs.selected.even.fg = t["bg0"]
c.colors.tabs.selected.odd.fg = t["bg0"]

c.colors.tabs.indicator.start = t["blue"]
c.colors.tabs.indicator.stop = t["green"]
c.colors.tabs.indicator.error = t["red"]
