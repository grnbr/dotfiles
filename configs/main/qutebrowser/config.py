# config.source(str(config.configdir / "themes" / "everforest.py"))
config.source('themes/everforest-light.py')

config.load_autoconfig()
# Start
c.auto_save.session = True
c.session.lazy_restore = True
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"
# content.private_browsing = True

# Apperance
c.tabs.position = "left"
c.tabs.width = 125
c.tabs.padding = {
    "top": 8,
    "bottom": 8,
    "left": 8,
    "right": 8,
}

config.unbind('.')
en_keys = "qwertyuiop[]asdfghjkl;'zxcvbnm,./"+'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'
ru_keys = 'йцукенгшщзхъфывапролджэячсмитьбю.'+'ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,'
c.bindings.key_mappings.update(dict(zip(ru_keys, en_keys)))

config.bind("d", "scroll-page 0 1")
config.bind("u", "scroll-page 0 -1")
config.bind("j", "scroll-px 0 150")
config.bind("k", "scroll-px 0 -150")

config.bind("x", "tab-close")
config.bind("<Alt-f>", "hint --rapid links tab-bg")

c.tabs.select_on_remove = "prev"
c.content.autoplay = False
c.content.blocking.method = "both"
