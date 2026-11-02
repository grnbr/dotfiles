# =============================================================================
# Everforest Light — Medium
# =============================================================================

t = {
    # Backgrounds
    "bg_dim": "#EFEBD4",
    "bg0": "#FDF6E3",
    "bg1": "#F3EAD3",
    "bg2": "#EAE4CA",
    "bg3": "#E0D8C0",
    "bg4": "#D8CFB7",
    "bg5": "#C9C09E",

    # Foreground
    "fg": "#5C6A72",
    "fg_dim": "#829181",

    # Accents
    "red": "#F85552",
    "orange": "#F57D26",
    "yellow": "#DFA000",
    "green": "#8DA101",
    "teal": "#35A77C",
    "blue": "#3A94C5",
    "purple": "#DF69BA",
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

c.colors.messages.error.bg = t["bg0"]
c.colors.messages.error.fg = t["red"]

c.colors.messages.info.bg = t["bg1"]
c.colors.messages.info.fg = t["fg"]

c.colors.messages.warning.bg = t["bg1"]
c.colors.messages.warning.fg = t["orange"]


# =============================================================================
# Prompts / command line
# =============================================================================

c.colors.prompts.bg = t["bg0"]
c.colors.prompts.fg = t["fg"]


# =============================================================================
# Completion menu
# =============================================================================

c.colors.completion.category.bg = t["bg1"]
c.colors.completion.category.fg = t["fg_dim"]

c.colors.completion.fg = t["fg"]

c.colors.completion.even.bg = t["bg0"]
c.colors.completion.odd.bg = t["bg1"]

c.colors.completion.match.fg = t["red"]

c.colors.completion.item.selected.fg = t["fg"]
c.colors.completion.item.selected.bg = t["bg2"]

c.colors.completion.item.selected.border.top = t["bg2"]
c.colors.completion.item.selected.border.bottom = t["bg2"]

c.colors.completion.scrollbar.bg = t["bg_dim"]
c.colors.completion.scrollbar.fg = t["fg_dim"]


# =============================================================================
# Hints
# =============================================================================

# c.colors.hints.bg = t["bg1"]
# c.colors.hints.fg = t["fg"]
# c.colors.hints.match.fg = t["red"]
#
# c.hints.border = "0px solid black"


# =============================================================================
# Status bar
# =============================================================================

c.colors.statusbar.normal.fg = t["fg"]
c.colors.statusbar.normal.bg = t["bg1"]

c.colors.statusbar.insert.fg = t["bg0"]
c.colors.statusbar.insert.bg = t["green"]

c.colors.statusbar.command.fg = t["fg"]
c.colors.statusbar.command.bg = t["bg0"]

c.colors.statusbar.private.fg = t["fg"]
c.colors.statusbar.private.bg = t["bg2"]

c.colors.statusbar.url.error.fg = t["red"]
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
