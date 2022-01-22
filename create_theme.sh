#!/bin/sh

cleanup() {
	for dependency in ${cleanuplist[@]}; do
		pacman -Rcns --noconfirm $dependency >/dev/null 2>&1
	done
}

makedependenciesinstall() {
	for dependency in "${dependencies[@]}"; do
		if ! pacman -Qi $dependency &> /dev/null; then
			cleanuplist+=("$dependency")
			pacman --noconfirm -S "$dependency" >/dev/null 2>&1
		fi
	done
}

createtheme() {
	dir=$(mktemp -d)
	dependencies=(bash grep sed bc glib2 gdk-pixbuf2 sassc gtk-engine-murrine gtk-engines librsvg)
	makedependenciesinstall
	git clone --recursive --depth 1 "$1" "$dir" >/dev/null 2>&1
	bash $dir/change_color.sh -o oomox-dusan -t /usr/share/themes <(cat colorfile)
}

createtheme "$1"
cleanup
