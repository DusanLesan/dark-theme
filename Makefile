OOMOX = "https://github.com/themix-project/oomox-gtk-theme.git"

options:
	@echo "oomox repo: ${OOMOX}"

install:
	./create_theme.sh "${OOMOX}"
